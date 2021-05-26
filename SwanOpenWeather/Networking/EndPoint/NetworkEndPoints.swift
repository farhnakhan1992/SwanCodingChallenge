//
//  NetworkEndPoints.swift
//  SwanOpenWeather
//
//  Created by Farhan Khan on 25/05/2021.
//



import Foundation


enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum ForcastApi {

    case fiveDaysForcast(lat: Double, lng: Double)
    case currentLocationForcast(lat: Double, lng: Double)
    
}

extension ForcastApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "https://api.openweathermap.org/data/2.5"
        case .qa: return "https://api.openweathermap.org/data/2.5"
        case .staging: return "https://api.openweathermap.org/data/2.5"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .fiveDaysForcast(_, _):
        return "/forecast"
        case .currentLocationForcast(lat: _, lng: _):
            return "/weather"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .fiveDaysForcast(let lat, let lng):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["lat":lat,
                                                      "lon":lng,
                                                      "appid":NetworkManager.OpenForcastKey])
        case .currentLocationForcast(let lat, let lng):
        return .requestParameters(bodyParameters: nil,
                                  bodyEncoding: .urlEncoding,
                                  urlParameters: ["lat":lat,
                                                  "lon":lng,
                                                  "appid":NetworkManager.OpenForcastKey])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}


