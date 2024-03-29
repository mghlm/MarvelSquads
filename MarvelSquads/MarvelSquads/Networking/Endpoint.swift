//
//  Endpoint.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 02/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import Foundation

enum Endpoint {
    
    case getMarvelCharacters(limit: Int, offset: Int), getCharacterComics(characterId: String)
    
    var scheme: String {
        switch self {
        case .getMarvelCharacters, .getCharacterComics:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .getMarvelCharacters, .getCharacterComics:
            return "gateway.marvel.com"
        }
    }
    
    var port: Int {
        switch self {
        case .getMarvelCharacters, .getCharacterComics:
            return 443
        }
    }
    
    var path: String {
        switch self {
        case .getMarvelCharacters:
            return "/v1/public/characters"
        case .getCharacterComics(let id):
            return "/v1/public/characters/\(id)/comics"
        }
    }
    
    var method: String {
        switch self {
        case .getMarvelCharacters, .getCharacterComics:
            return "GET"
        }
    }
    
    var parameters: [URLQueryItem] {
        // To be stored in keychain
        let apiKey = "b7de28137b3c1b7288e03df1efe72a6d"
        let privateKey = "0bf21185bb9494578b9927a6b38fd35a9c06e777"
        let ts = Date().timeIntervalSince1970.description
        let hash = "\(ts)\(privateKey)\(apiKey)".md5
        var commonQueryItems = [URLQueryItem(name: "apikey", value: apiKey),
                          URLQueryItem(name: "ts", value: ts),
                          URLQueryItem(name: "hash", value: hash)
        ]
        
        switch self {
        case .getMarvelCharacters(let limit, let offset):
            commonQueryItems.append(URLQueryItem(name: "limit", value: "\(limit)"))
            commonQueryItems.append(URLQueryItem(name: "offset", value: "\(offset)"))
            return commonQueryItems
        case .getCharacterComics:
            return commonQueryItems
        }
    }
}
