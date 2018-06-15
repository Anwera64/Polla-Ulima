//
//  PollaViewController.swift
//  Polla Ulima
//
//  Created by Anton Tchistiakov on 6/14/18.
//  Copyright © 2018 Anton Tchistiakov. All rights reserved.
//

import UIKit

class PollaViewController: UIViewController, PollaGambleDelegate {
    
    public static let identifier = "PollaViewController"
    public var fixtureCode: Int!
    private var manager: PollaGambleManager!
    
    public var team1, team2: String!

    @IBOutlet var team1Label: UILabel!
    @IBOutlet var team2Label: UILabel!
    @IBOutlet var inputScore1: UITextField!
    @IBOutlet var inputScore2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        manager = PollaGambleManager(delegate: self)
        team1Label.text = team1
        team2Label.text = team2
        title = "Apuesta"
    }

    @IBAction func onSaveClick(_ sender: Any) {
        guard let pre = UserDefaults.standard.object(forKey: "USER"), let user = pre as? String else {
            let alert = AlertUtil.simpleAlert(title: "Aviso", detail: "Tienes que ingresar un usuario.")
             present(alert, animated: true)
            return
        }
        
        guard let score1String = inputScore1.text?.trimmed(), let score2String = inputScore2.text?.trimmed() else {
            let alert = AlertUtil.simpleAlert(title: "Error", detail: "Tienes que ingresar los goles a cada equipo.")
            present(alert, animated: true)
            return
        }
        
        guard let score1 = Int(score1String), let score2 = Int(score2String) else {
            let alert = AlertUtil.simpleAlert(title: "Error", detail: "Tienes que ingresar un valor valido para los goles.")
            present(alert, animated: true)
            return
        }
        
        let winner = score1 > score2 ? team1Label.text! : team2Label.text!
        manager.saveGamble(user: user, idFixture: fixtureCode, winner: winner, score1: score1, score2: score2)
    }
    
    func onPostComplete() {
        navigationController?.popViewController(animated: true)
    }
    
}
