//
//  Network.swift
//  FSI Code Challenge
//
//  Created by Joel Youngblood on 11/13/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa
import RxAlamofire

final class Network {

    static let reachability = NetworkReachabilityManager()!
    
    static func request<T: Codable>(from route: ApiRoute, for type: T.Type) -> Observable<T> {
        if !reachability.isReachable {
            return Observable.error(NetworkError.noConnection)
        } else {
            return RxAlamofire.request(route).validate().responseData().flatMap { response, data -> Observable<T> in
                if response.statusCode == 200 {
                    return Observable.just(try JSONDecoder().decode(type.self, from: data))
                } else {
                    return Observable.error(NetworkError.errorCode(code: response.statusCode))
                }
            }
        }
    }
}
