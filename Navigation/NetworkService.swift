//
//  NetworkService.swift
//  Navigation
//
//  Created by v.milchakova on 10.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

struct NetworkService {
    
    enum AppConfiguration: String {
        case people = "https://swapi.dev/api/people/8"
        case starships = "https://swapi.dev/api/starships/3"
        case planets = "https://swapi.dev/api/planets/5"
    }
    
    static let session = URLSession.shared
    
    static func dataTask(config: AppConfiguration, complition: @escaping (String?) -> Void) {
        if let url = URL(string: config.rawValue) {
            session.dataTask(with: url) {
                data, response, error in
                guard error == nil else {
                    print(error.debugDescription)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { return }
                print("statusCode: \(httpResponse.statusCode)")
                print("headers: \(httpResponse.allHeaderFields)")
                if let data = data {
                    complition(String(data: data, encoding: .utf8))
                }
            }.resume()
        }
    }
    
    public enum HTTPMethod: String {
        
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
        case head = "HEAD"
        case options = "OPTIONS"
        case trace = "TRACE"
        case connect = "CONNECT"
    }
    
    static func dataTaskRequest(httpMethod: HTTPMethod, config: AppConfiguration,  complition: @escaping (String?) -> Void) {
        if let url = URL(string: config.rawValue) {
            var request = URLRequest(url: url)
            request.httpMethod = httpMethod.rawValue
            session.dataTask(with: request) {
                data, response, error in
                guard error == nil else {
                    print(error.debugDescription)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { return }
                print("statusCode: \(httpResponse.statusCode)")
                print("headers: \(httpResponse.allHeaderFields)")
                if let data = data {
                    complition(String(data: data, encoding: .utf8))
                }
            }.resume()
        }
    }
}
