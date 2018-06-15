//
//  Player.swift
//  Polla Ulima
//
//  Created by Anton Tchistiakov on 6/13/18.
//  Copyright © 2018 Anton Tchistiakov. All rights reserved.
//

import Foundation

class Players: Codable {
    let players: [Player]
    
    init(players: [Player]) {
        self.players = players
    }
}

class Player: Codable {
    let name, position: String
    let jerseyNumber: Int?
    let dateOfBirth: String
    let nationality, contractUntil: String?
    let marketValue: JSONNull?
    
    init(name: String, position: String, jerseyNumber: Int?, dateOfBirth: String, nationality: String?, contractUntil: String?, marketValue: JSONNull?) {
        self.name = name
        self.position = position
        self.jerseyNumber = jerseyNumber
        self.dateOfBirth = dateOfBirth
        self.nationality = nationality
        self.contractUntil = contractUntil
        self.marketValue = marketValue
    }
}

// MARK: Encode/decode helpers

class JSONNull: Codable {
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
