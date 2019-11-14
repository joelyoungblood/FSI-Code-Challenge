//
//  Posts.swift
//  FSI Code Challenge
//
//  Created by Joel Youngblood on 11/13/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import Foundation
import Alamofire

enum Posts: ApiRoute {
    
    case allPosts
    
    var path: String {
        switch self {
        case .allPosts: return "posts"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var params: JSON? {
        return nil
    }
}
