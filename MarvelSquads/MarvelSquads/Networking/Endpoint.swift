//
//  Endpoint.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 02/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import Foundation

enum Endpoint {
    
    case getMarvelCaracters
    
    var scheme: String {
        switch self {
        case .getMarvelCaracters:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .getMarvelCaracters:
            return "gateway.marvel.com:443"
        }
    }
    
    var path: String {
        switch self {
        case .getMarvelCaracters:
            return "/v1/public/characters"
        }
    }
    
    var method: String {
        switch self {
        case .getMarvelCaracters:
            return "GET"
        }
    }
    
    var parameters: [URLQueryItem] {
        let apiKey = "b7de28137b3c1b7288e03df1efe72a6d"
        switch self {
        case .getMarvelCaracters:
            return [URLQueryItem(name: "api_key", value: apiKey)]
        }
    }
}
