//
//  EquiposManager.swift
//  Polla Ulima
//
//  Created by Anton Tchistiakov on 6/12/18.
//  Copyright © 2018 Anton Tchistiakov. All rights reserved.
//

import Foundation

class EquiposManager {
    private var delegate: EquiposDelegate?
    private let urlString = "http://api.football-data.org/v1/competitions/467/teams"
    public var teams: [Team]?
    
    init(delegate: EquiposDelegate) {
        self.delegate = delegate
    }

    func getTeams() {
        guard let url = URL(string: urlString) else {
            print("wrong url")
            return
        }
        
        URLSession(configuration: .default).dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            if let d = data {
                if let apiData = try? JSONDecoder().decode(TeamApiData.self, from: d) {
                    self.teams = apiData.teams
                    DispatchQueue.main.async {
                        self.delegate?.equiposReady()
                    }
                }
            }
        }).resume()
    }
}

protocol EquiposDelegate {
    func equiposReady()
}
