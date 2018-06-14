//
//  Fixture.swift
//  Polla Ulima
//
//  Created by Anton Tchistiakov on 6/14/18.
//  Copyright © 2018 Anton Tchistiakov. All rights reserved.
//

import Foundation

class Fixture: Codable {
    let codigo: Int
    let equipo1, equipo2: String
    var score: [Int]?
    
    init(codigo: Int, equipo1: String, equipo2: String) {
        self.codigo = codigo
        self.equipo1 = equipo1
        self.equipo2 = equipo2
    }
    
    init(codigo: Int, equipo1: String, equipo2: String, score: [Int]) {
        self.codigo = codigo
        self.equipo1 = equipo1
        self.equipo2 = equipo2
        self.score = score
    }
}
