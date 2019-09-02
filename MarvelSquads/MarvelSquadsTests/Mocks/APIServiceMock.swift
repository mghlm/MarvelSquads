//
//  APIServiceMock.swift
//  MarvelSquadsTests
//
//  Created by Magnus Holm on 02/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import XCTest
@testable import MarvelSquads

final class APIServiceMock: APIServiceType {
    
    
    var isSuccessForCharacters: Bool = true
    var isSuccessForComics: Bool = true
    
    let charactersResponseModel = CharactersResponse(data: CharactersResponseData(limit: 20, total: 200,
                                                                                  results: [Character(id: 123,
                                                                                                      name: "Hulk",
                                                                                                      description: "He's green and strong",
                                                                                                      thumbnail: Thumbnail(path: "https://hulkimage.com/hulk",
                                                                                                                           extension: "jpg")),
                                                                                            Character(id: 456,
                                                                                                      name: "Ironman",
                                                                                                      description: "He's rich and smart",
                                                                                                      thumbnail: Thumbnail(path: "https://ironmanimage.com/ironman",
                                                                                                                           extension: "jpg"))
        ]))
    
    let comicsResponseModel = CharacterComicsResponse(data: CharacterComicsResponseData(results: [Comic(title: "The Incredible Hulk",
                                                                                                        thumbnail: Thumbnail(path: "https://hulkimage.com/hulk",
                                                                                                                             extension: "jpg")),
                                                                                                  Comic(title: "Ironman",
                                                                                                        thumbnail: Thumbnail(path: "https://ironmanimage.com/ironman",
                                                                                                                             extension: "jpg"))
        ]))
    
    func request<T: Decodable>(type: T.Type, endpoint: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        if isSuccessForCharacters {
            let charactersModel = self.charactersResponseModel as! T
            isSuccessForCharacters = false
            completion(.success(charactersModel))
        } else if isSuccessForComics {
            let comicsModel = self.comicsResponseModel as! T
            isSuccessForComics = false
            completion(.success(comicsModel))
        } else {
            completion(.failure(.networkError))
        }
    }
}


