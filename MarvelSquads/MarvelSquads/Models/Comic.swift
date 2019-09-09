//
//  Comic.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 02/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import Foundation

struct CharacterComicsResponse: Decodable {
    let data: CharacterComicsResponseData
}

struct CharacterComicsResponseData: Decodable {
    let results: [Comic]
}

struct Comic: Decodable {
    let title: String
    let thumbnail: Thumbnail
}
