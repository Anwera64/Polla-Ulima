//
//  Team.swift
//  Polla Ulima
//
//  Created by Anton Tchistiakov on 6/12/18.
//  Copyright © 2018 Anton Tchistiakov. All rights reserved.
//

import Foundation

import Foundation

class Team {
    let playerLink: String?
    let name: String?
    let crestURL: String?
    
    init(playerLink: String?, name: String?, crestURL: String?) {
        self.playerLink = playerLink
        self.name = name
        self.crestURL = crestURL
    }
}


