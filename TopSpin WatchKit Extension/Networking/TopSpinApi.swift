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
    case getMatches(id: String)
    case putMatches(id: String, matches: [Match])
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
        case .getMatches(id: let id):
            return APIConstants.Match.userMatches(id)
        case .putMatches(id: let id, matches: _):
            return APIConstants.Match.userMatches(id)
        }
    }
    
    public var httpMethod: HTTPMethod {
        switch self {
        case .signIn:
            return .post
        case .getMatches:
            return .get
        case .putMatches:
            return .put
        }
    }
    
    public var task: HTTPTask {
        switch self {
        case .signIn(user: let newUser):
            return .requestParameters(bodyParameters: newUser, urlParameters: nil)
        case .getMatches:
            return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: nil, additionalHeaders: headers)
        case .putMatches(id: _, matches: let matches):
            return .requestParametersAndHeaders(bodyParameters: matches, urlParameters: nil, additionalHeaders: headers)
        }
    }
    
    public var headers: HTTPHeaders? {
        if let token = UserDefaultsManager.userToken {
            return ["Authorization": "Bearer \(token)"]
        }
        
        return nil
    }
}
