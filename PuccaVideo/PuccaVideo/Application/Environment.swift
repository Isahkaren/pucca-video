//
//  Environment.swift
//  PuccaVideo

//  Copyright © 2018 Isabela Karen Louli. All rights reserved.
//

import Foundation

class Environment {
    
    static let shared = Environment()
    
    var baseUrl = URL(string: "https://www.googleapis.com/youtube/v3/")!
    public let apiKey = "AIzaSyCwbGziupadfpxuaTv72BsKZxOAQQDDj9A"
}
