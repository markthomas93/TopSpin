//
//  TopSpinApi.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 8/29/19.
//

import Foundation
import RocketWatch

struct NetworkManager {
    static let sharedInstance = RocketNetworkManager<TopSpinApi>()

    static func setEnvironment(for environment: NetworkEnvironment) {
        NetworkManager.sharedInstance.setupNetworkLayer(in: environment)
    }
}

enum TopSpinApi {
    case signIn(user: UserSignUp)
    case getMatches
    case putMatches(matches: [Match])
    case getMatchSettings
    case updateSettings(settings: MatchSetting)
}

extension TopSpinApi: EndPointType {
    public var environmentBaseURL: String {
        switch NetworkManager.sharedInstance.environment {
        case .local:
            return APIConstants.EndPoint.local
            
        case .staging:
            return APIConstants.EndPoint.staging
            
        case .production:
            return APIConstants.EndPoint.production
            
        default:
            return ""
        }
    }
    
    public var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("base url could not be config") }
        return url
    }
    
    public var path: String {
        switch self {
        case .signIn:
            return APIConstants.User.users
        case .getMatches:
            return APIConstants.Match.userMatches
        case .putMatches:
            return APIConstants.Match.userMatches
        case .getMatchSettings:
            return APIConstants.MatchSettings.userMatchSettings
        case .updateSettings(settings: let settings):
            return APIConstants.MatchSettings.updateMatch(settings.id!)
        }
    }
    
    public var httpMethod: HTTPMethod {
        switch self {
        case .signIn:
            return .post
        case .getMatches, .getMatchSettings:
            return .get
        case .putMatches, .updateSettings:
            return .put
        }
    }
    
    public var task: HTTPTask {
        switch self {
        case .signIn(user: let newUser):
            return .requestParameters(bodyParameters: newUser, urlParameters: nil)
        case .getMatches, .getMatchSettings:
            return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: nil, additionalHeaders: headers)
        case .putMatches(matches: let matches):
            return .requestParametersAndHeaders(bodyParameters: matches, urlParameters: nil, additionalHeaders: headers)
        case .updateSettings(settings: let settings):
            return .requestParametersAndHeaders(bodyParameters: settings, urlParameters: nil, additionalHeaders: headers)
        }
    }
    
    public var headers: HTTPHeaders? {
        if let token = UserDefaultsManager.userToken {
            return ["Authorization": "Bearer \(token)"]
        }
        
        return nil
    }
}
