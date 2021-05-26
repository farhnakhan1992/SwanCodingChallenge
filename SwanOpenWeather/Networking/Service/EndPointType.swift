//
//  EndPoint.swift
//  SwanOpenWeather
//
//  Created by Farhan Khan on 25/05/2021.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

