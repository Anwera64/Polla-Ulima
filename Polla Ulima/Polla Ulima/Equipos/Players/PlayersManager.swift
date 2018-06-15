//
//  PlayersManager.swift
//  Polla Ulima
//
//  Created by Anton Tchistiakov on 6/13/18.
//  Copyright © 2018 Anton Tchistiakov. All rights reserved.
//

import Foundation

class PlayersManager {
    private var urlString: String!
    private var delegate: PlayersDelegate!
    
    init(urlString: String, delegate: PlayersDelegate) {
        self.urlString = urlString
        self.delegate = delegate
    }
    
    public func getPlayers() {
        guard let url = URL(string: urlString) else {
            print("wrong player url")
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
            if let d = data {
                if let players = try? JSONDecoder().decode(Players.self, from: d) {
                    DispatchQueue.main.async {
                        self.delegate?.onPlayersReturned(players: players.players)
                    }
                }
            }
        }).resume()
    }
}

protocol PlayersDelegate {
    func onPlayersReturned(players: [Player])
}
