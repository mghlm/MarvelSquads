//
//  Character.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 02/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import Foundation

struct CharactersResponse: Decodable {
    let data: CharactersResponseData
}

struct CharactersResponseData: Decodable {
    let limit: Int
    let total: Int
    let results: [Character]
}

struct Character: Decodable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail?
    var comics: [Comic]?
    var imageUrl: String?
    
    var isInSquad: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, thumbnail
    }
}

struct Thumbnail: Decodable {
    let path: String?
    let `extension`: String?
    
    func imageUrl() -> URL? {
        guard let path = path, let ext = `extension` else { return nil }
        return URL(string: "\(path).\(ext)")
    }
}


