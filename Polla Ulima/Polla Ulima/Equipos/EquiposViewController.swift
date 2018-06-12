//
//  ViewController.swift
//  Polla Ulima
//
//  Created by Anton Tchistiakov on 6/11/18.
//  Copyright © 2018 Anton Tchistiakov. All rights reserved.
//

import UIKit

class EquiposViewController: UITableViewController, EquiposDelegate {
    private var manager: EquiposManager?
    private let sections = 1
    
    static let identifier: String = "EquiposViewController"
    
    override func viewDidAppear(_ animated: Bool) {
        manager = EquiposManager(delegate: self)
        manager?.getTeams()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let teams = manager?.teams {
            return teams.count
        } else {
            return 0
        }
    }

    func equiposReady() {
        tableView.reloadData()
        print("Reloading Data")
    }
    


}

