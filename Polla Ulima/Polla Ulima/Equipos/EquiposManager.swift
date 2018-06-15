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
    
    
    init(delegate: EquiposDelegate) {
        self.delegate = delegate
    }
    
    func getTeams() {
        guard let url = URL(string: urlString) else {
            print("wrong url")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("2423c7e6dd674d77b56206b654efe69a" , forHTTPHeaderField: "X-Auth-Token")
        
        URLSession(configuration: .default).dataTask(with: request, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            if let d = data, let json = (try? JSONSerialization.jsonObject(with: d, options: [])) as? [String: Any] {
                var teams: [Team] = Array()
                if let teamsJSON = json["teams"] as? [[String: Any]]  {
                    for team in teamsJSON {
                        let name = team["name"] as? String
                        let crestURL = team["crestUrl"] as! String
                        let links = team["_links"] as! [String: Any]
                        let playerLinks = links["players"] as! [String: Any]
                        let playerLink = playerLinks["href"] as? String
                        teams.append(Team(playerLink: playerLink!, name: name, crestURL: crestURL))
                    }
                }
                DispatchQueue.main.async {
                    self.delegate?.equiposReady(teams: teams)
                }
            }
        }).resume()
    }
    
    /*func getCrest(urlString: String, index: IndexPath) {
        guard let url = URL(string: urlString) else {
            print("wrong image url")
            return
        }
        
        URLSession(configuration: .default).dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            if let d = data {
                DispatchQueue.main.async {
                    self.delegate?.imageReady(imageData: d, index: index)
                }
            }
        }).resume()
    }*/
}

protocol EquiposDelegate {
    func equiposReady(teams: [Team])
}
