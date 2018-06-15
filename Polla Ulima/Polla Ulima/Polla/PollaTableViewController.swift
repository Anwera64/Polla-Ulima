//
//  PollaTableViewController.swift
//  Polla Ulima
//
//  Created by Anton Tchistiakov on 6/12/18.
//  Copyright © 2018 Anton Tchistiakov. All rights reserved.
//

import UIKit

class PollaTableViewController: UITableViewController, PollaDelegate {

    private var manager: PollaManager!
    static var identifier = "PollaTableViewController"
    private var fixtures: [Fixture]?
    
    var user: String!
    
    override func viewDidLoad() {
        manager = PollaManager(delegate: self)
        title = "Polla"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        manager!.getTeams()
    }
    
    func onGetComplete(_ fixtures: [Fixture]) {
        self.fixtures = fixtures
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let fixtures = fixtures {
            return fixtures.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fixtureCell", for: indexPath) as! PollaTableViewCell
        // Configure the cell...
        if let fixtures = fixtures {
            cell.team1Label.text = fixtures[indexPath.row].equipo1
            cell.team2Label.text = fixtures[indexPath.row].equipo2
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pollaView = storyboard.instantiateViewController(withIdentifier: PollaViewController.identifier) as! PollaViewController
        pollaView.team1 = fixtures?[indexPath.row].equipo1
        pollaView.team2 = fixtures?[indexPath.row].equipo2
        pollaView.fixtureCode = fixtures?[indexPath.row].codigo
        
        navigationController?.pushViewController(pollaView, animated: true)
    }
    
}
