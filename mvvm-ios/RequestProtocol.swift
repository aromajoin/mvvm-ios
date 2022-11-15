//
//  RequestProtocol.swift
//  mvvm-ios
//
//  Created by Behnam on 11/7/22.
//  Copyright © 2022 Behnam. All rights reserved.
//

import Foundation

typealias Header = [String: String]

protocol RequestProtocol {
    var baseUrl: String { get }
    var path: String { get }
    var method: Method { get }
    var header: Header? { get }
    var queryParameters: [URLQueryItem]? { get }
    
    func getBody() -> Data?
    func getRequest() -> URLRequest
}

extension RequestProtocol {
    func getRequest() -> URLRequest {
        var request = URLRequest(url: getURL()!)
        
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = header
        request.httpBody = getBody()
        
        return request
    }
    
    func getURL() -> URL? {
        var urlComponent = URLComponents(string: baseUrl)
        urlComponent?.path += path
        urlComponent?.queryItems = queryParameters
        return urlComponent?.url
    }
    
    var header: Header? {
        return nil
    }
}
