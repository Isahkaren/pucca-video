//
//  NetworkResponse.swift
//  PuccaVideo
//
//  Created by Diego Louli on 20.06.18.
//  Copyright © 2018 Isabela Karen Louli. All rights reserved.
//

import Foundation

struct NetworkResponse {
        var data: Data?
        var rawResponse: String?
        var response: HTTPURLResponse?
        var request: URLRequest?
        var error: NetworkError?
}
