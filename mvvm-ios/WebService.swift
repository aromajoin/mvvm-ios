//
//  WebService.swift
//  mvvm-ios
//
//  Created by Behnam on 11/7/22.
//  Copyright © 2022 Behnam. All rights reserved.
//

import Foundation
import RxSwift

class WebService {
    
    func request<T: Codable>(resource: Resource<T>) -> Observable<T?> {
        Observable.just(resource.endpoint.getURL()!)
            .flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
                let request = resource.endpoint.getRequest()
                return URLSession.shared.rx.response(request: request)
            }.map({ (response: HTTPURLResponse, data: Data) -> T? in
                return try? JSONDecoder().decode(T.self, from: data)
            }).asObservable()
    }
    
}
