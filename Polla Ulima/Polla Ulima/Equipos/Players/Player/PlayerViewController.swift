//
//  PlayerViewController.swift
//  Polla Ulima
//
//  Created by Anton Tchistiakov on 6/13/18.
//  Copyright © 2018 Anton Tchistiakov. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {
    
    public var position: String!
    public var number: Int!
    public var birthday: String!
    public var name: String!
    
    static public let identifier = "PlayerViewController"
    
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        positionLabel.text = position
        numberLabel.text = String(number)
        birthdayLabel.text = birthday
        title = name
    }
}
