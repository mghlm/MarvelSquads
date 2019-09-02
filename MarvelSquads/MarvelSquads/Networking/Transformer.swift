//
//  Transformer.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 02/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import Foundation

protocol  Transformer {
    
    /// Decodes any decotable type
    ///
    /// - Parameters:
    ///   - type: Any type that conforms to the decodable protocol
    ///   - data: data to decode into Swift model
    /// - Returns: Swift model
    /// - Throws: Potential error
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

struct JSONTransformer: Transformer {
    
    // MARK: - Private properties
    
    private let decoder: JSONDecoder
    
    // MARK: - Init
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    // MARK: - Public methods
    
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        return try decoder.decode(type, from: data)
    }
}
