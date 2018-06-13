//
//  PlayersTableViewController.swift
//  Polla Ulima
//
//  Created by Anton Tchistiakov on 6/13/18.
//  Copyright © 2018 Anton Tchistiakov. All rights reserved.
//

import UIKit

class PlayersTableViewController: UITableViewController, PlayersDelegate {

    private var manager: PlayersManager!
    private var players: [Player]?
    
    var url: String!
    
    static let identifier: String = "PlayersTableViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
        manager = PlayersManager(urlString: url, delegate: self)
        manager.getPlayers()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let players = players {
            return players.count
        } else {
            return 0
        }
    }
    
    func onPlayersReturned(players: [Player]) {
        self.players = players
        tableView.reloadData()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath)
        // Configure the cell...
        if let players = players {
             cell.textLabel?.text = players[indexPath.row].name
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let playerView = storyboard.instantiateViewController(withIdentifier: PlayerViewController.identifier) as! PlayerViewController
        playerView.position = players?[indexPath.row].position
        playerView.birthday = players?[indexPath.row].dateOfBirth
        playerView.number = players?[indexPath.row].name
        
        navigationController?.pushViewController(playerView, animated: true)
    }
}
