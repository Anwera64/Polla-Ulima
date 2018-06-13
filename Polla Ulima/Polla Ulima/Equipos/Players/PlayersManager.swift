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
        let url = URL(string: urlString)
        guard url != nil else {
            print("wrong player url")
            return
        }
        
        URLSession(configuration: .default).dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            if let d = data, let players = try? JSONDecoder().decode(Players.self, from: d) {
                DispatchQueue.main.async {
                    self.delegate?.onPlayersReturned(players: players.players)
                }
            }
        }).resume()
    }
}

protocol PlayersDelegate {
    func onPlayersReturned(players: [Player])
}
