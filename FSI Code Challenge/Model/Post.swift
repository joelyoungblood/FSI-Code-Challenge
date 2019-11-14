//
//  Post.swift
//  FSI Code Challenge
//
//  Created by Joel Youngblood on 11/13/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import Foundation

struct Post: Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
