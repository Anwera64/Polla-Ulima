//
//  ViewController.swift
//  Polla Ulima
//
//  Created by Anton Tchistiakov on 6/11/18.
//  Copyright © 2018 Anton Tchistiakov. All rights reserved.
//

import UIKit
import Darwin

class EquiposViewController: UITableViewController, EquiposDelegate {
    private var manager: EquiposManager!
    private let sections = 1
    public var teams: [Team]?
    
    static let identifier: String = "EquiposViewController"
    
    override func viewDidAppear(_ animated: Bool) {
        manager = EquiposManager(delegate: self)
        manager.getTeams()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let teams = teams {
            return teams.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = self.tableView.dequeueReusableCell(withIdentifier: "Celda", for: indexPath) as! EquiposTableViewCell
        if let teams = teams {
            celda.nameLabel.text = teams[indexPath.row].name
            celda.rankingLabel.text = /*String(arc4random_uniform(100))*/ String(indexPath.row)
            if let stringURL = teams[indexPath.row].crestURL, let url = URL(string: stringURL) {
                celda.crestView.load(URLRequest(url: url))
            }
        }
        return celda
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let playersTableViewController = storyboard.instantiateViewController(withIdentifier: PlayersTableViewController.identifier) as! PlayersTableViewController
        playersTableViewController.url = teams?[indexPath.row].playerLink
        
        self.navigationController?.pushViewController(playersTableViewController, animated: true)
    }
    
    func equiposReady(teams: [Team]) {
        self.teams = teams
        self.tableView.reloadData()
        print("Reloading Data")
    }
    
    func imageReady(imageData: Data, index: IndexPath) {
    }
    
}

