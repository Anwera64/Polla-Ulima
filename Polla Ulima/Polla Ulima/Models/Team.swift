//
//  Team.swift
//  Polla Ulima
//
//  Created by Anton Tchistiakov on 6/12/18.
//  Copyright © 2018 Anton Tchistiakov. All rights reserved.
//

import Foundation

//class Team {
//    let links: Dictionary<LinkType, String>
//    let name, code: String
//    let shortName: String?
//    let squadMarketValue: Int?
//    let crestURL: String
//
//    init(links: Dictionary<LinkType, String>, name: String, code: String, shortName: String?, squadMarketValue: Int?, crestURL: String) {
//        self.links = links
//        self.name = name
//        self.code = code
//        self.shortName = shortName
//        self.squadMarketValue = squadMarketValue
//        self.crestURL = crestURL
//    }
//}
//
//enum LinkType {
//    case fixtures
//    case players
//}

// To parse the JSON, add this file to your project and do:
//
//   let teams = try? JSONDecoder().decode(Teams.self, from: jsonData)

import Foundation

class TeamApiData: Codable {
    let teams: [Team]
    
    init(teams: [Team]) {
        self.teams = teams
    }
}

class Team: Codable {
    let links: Links
    let name, code: String
    let shortName: String?
    let squadMarketValue: JSONNull?
    let crestURL: String
    
    enum CodingKeys: String, CodingKey {
        case links = "_links"
        case name, code, shortName, squadMarketValue
        case crestURL = "crestUrl"
    }
    
    init(links: Links, name: String, code: String, shortName: String?, squadMarketValue: JSONNull?, crestURL: String) {
        self.links = links
        self.name = name
        self.code = code
        self.shortName = shortName
        self.squadMarketValue = squadMarketValue
        self.crestURL = crestURL
    }
}

class Links: Codable {
    let linksSelf, fixtures, players: Fixtures
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case fixtures, players
    }
    
    init(linksSelf: Fixtures, fixtures: Fixtures, players: Fixtures) {
        self.linksSelf = linksSelf
        self.fixtures = fixtures
        self.players = players
    }
}

class Fixtures: Codable {
    let href: String
    
    init(href: String) {
        self.href = href
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

