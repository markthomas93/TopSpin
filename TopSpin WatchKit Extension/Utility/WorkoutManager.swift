//
//  WorkoutManager.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 8/25/19.
//

import HealthKit
import Combine

class WorkoutManager: NSObject, ObservableObject {
    
    static let shared: WorkoutManager = WorkoutManager()
    let objectWillChange = PassthroughSubject<Void, Never>()

    // MARK: - Properties
    
    private let activity: HKWorkoutActivityType
    
    private var healthStore: HKHealthStore?
    private var workoutStartDate = Date()
    private var workoutEndDate = Date()
    private var activeDataQueries = [HKQuery]()
    private var workoutSession: HKWorkoutSession?
    private var maxHeartRate: Double = 0.0
    private let countPerMinute = HKUnit(from: "count/min")

    // Bindable props
    @Published var latestHeartRate = 0.0
    
    // MARK: - Initializer
    
    init(type: HKWorkoutActivityType = .tableTennis) {
        activity = type
        
        super.init()        
    }
    
    deinit {
        print("Workout Manager - Deinit")
    }
    
    // MARK: - Methods
    
    func getCurrentWorkoutSession() -> WorkoutSession? {
        guard workoutSession != nil, maxHeartRate != 0 else {
            return nil
        }
        
        return WorkoutSession(maxHeartRate: maxHeartRate)
    }
    
    func completeWorkout() {
        endWorkout()
        print("Workout Manager - Workout Finished")
    }
    
    func startWorkoutSession() {
        setupHealthAuthorization()
    }
    
    // MARK: - Private Methods
    
    private func endWorkout() {
        guard let session = workoutSession else {
            return
        }
        
        session.end()
        workoutEndDate = Date()
    }
    
    private func cleanQueries() {
        activeDataQueries.forEach { query in
            healthStore?.stop(query)
        }
        
        activeDataQueries.removeAll()
    }
    
    private func saveWorkout(_ session: HKWorkoutSession) {
        let config = session.workoutConfiguration
        let workout = HKWorkout(activityType: config.activityType,
                                start: workoutStartDate,
                                end: workoutEndDate,
                                workoutEvents: nil,
                                totalEnergyBurned: nil,
                                totalDistance: nil,
                                metadata: [HKMetadataKeyIndoorWorkout: true])
        
        healthStore?.save(workout) { success, error in
            if success {
                print("Workout Manager - Saved Workout")
            }
        }
    }
    
    private func startWorkout(_ workoutType: HKWorkoutActivityType) {
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = workoutType
        configuration.locationType = .outdoor
        
        guard let store = healthStore,
            let session = try? HKWorkoutSession(healthStore: store, configuration: configuration) else {
            print("Failed to start session.")
            return
        }
        
        workoutSession = session
        workoutStartDate = Date()
        workoutSession?.startActivity(with: workoutStartDate)
        workoutSession?.delegate = self
        print("Workout started")
    }
    
    private func setupHealthAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else { return }
        
        // What data we want to write
        let writeTypes: Set<HKSampleType> = [.workoutType(),
                                             HKSampleType.quantityType(forIdentifier: .heartRate)!]
        
        // What data we want to
        let readTypes: Set<HKObjectType> = [.activitySummaryType(),
                                            .workoutType(),
                                            HKObjectType.quantityType(forIdentifier: .heartRate)!]
        
        healthStore = HKHealthStore()
        healthStore?.requestAuthorization(toShare: writeTypes, read: readTypes) { [weak self] success, error in
            guard let weakSelf = self, error == nil else {
                print("Failed to get Authorization")
                return
            }
            
            if success {
                print("Finished authorizing HealthKit")
                self?.startWorkout(weakSelf.activity)
            }
        }
        
    }
    
    typealias HealthQueryUpdateHandler = (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void
    
    private func startQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
        let datePredicate = HKQuery.predicateForSamples(withStart: workoutStartDate, end: nil, options: .strictStartDate)
        let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
        let queryPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [datePredicate, devicePredicate])
        
        let updateHandler: HealthQueryUpdateHandler = { [weak self] query, samples, deletedObjects, queryAnchor, error in
            guard let weakSelf = self, let samples = samples as? [HKQuantitySample] else {
                print("Samples do not conform")
                return
            }
            
            weakSelf.process(samples, type: quantityTypeIdentifier)
        }
        
        let query = HKAnchoredObjectQuery(type: HKObjectType.quantityType(forIdentifier: quantityTypeIdentifier)!,
                                          predicate: queryPredicate,
                                          anchor: nil,
                                          limit: HKObjectQueryNoLimit,
                                          resultsHandler: updateHandler)
        
        query.updateHandler = updateHandler
        healthStore?.execute(query)
        activeDataQueries.append(query)
    }
    
    private func startQueries() {
        startQuery(quantityTypeIdentifier: .heartRate)
    }
    
    private func process(_ samples: [HKQuantitySample], type: HKQuantityTypeIdentifier) {
        samples.forEach { sample in
            switch type {
            case .heartRate:
                DispatchQueue.main.async {
                    self.latestHeartRate = sample.quantity.doubleValue(for: self.countPerMinute)
                    self.objectWillChange.send()
                }
                maxHeartRate = latestHeartRate > maxHeartRate ? latestHeartRate : maxHeartRate
                print("Last Heart Rate: \(latestHeartRate)")
                
            default:
                break
            }
        }
    }
}

extension WorkoutManager: HKWorkoutSessionDelegate {
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date) {
        switch toState {
        case .running:
            if fromState == .notStarted {
                startQueries()
            }
        case .paused:
            print("Workout Paused")
            
        case .ended:
            cleanQueries()
            saveWorkout(workoutSession)
            
        default:
            break
        }
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didGenerate event: HKWorkoutEvent) {
        print(event)
    }
}
