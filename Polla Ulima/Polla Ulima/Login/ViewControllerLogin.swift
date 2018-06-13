//
//  ViewControllerLogin.swift
//  Polla Ulima
//
//  Created by Anton Tchistiakov on 6/12/18.
//  Copyright © 2018 Anton Tchistiakov. All rights reserved.
//

import UIKit

class ViewControllerLogin: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginButton()
    }
    
    private func setupLoginButton() {
        loginButton.addTarget(self, action: #selector(navigateToTabBar), for: .touchUpInside)
    }
    
    @objc func navigateToTabBar() {
        guard let user = inputTextField.text?.trimmed() else {
            let alert = UIAlertController(title: "Aviso", message: "Tienes que ingresar un usuario", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(action)
            present(alert, animated: true)
            return
        }
        
        // Crear los viewControllers
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pollaTableViewController = storyboard.instantiateViewController(withIdentifier: PollaTableViewController.identifier) as! PollaTableViewController
        pollaTableViewController.user = user
        pollaTableViewController.tabBarItem.title = "Polla"
        
        let equiposViewController = storyboard.instantiateViewController(withIdentifier: EquiposViewController.identifier) as! UINavigationController
        equiposViewController.tabBarItem.title = "Equipos"
        
        // Crear el tab bar controller
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [equiposViewController, pollaTableViewController]
        
        present(tabBarController, animated: true)
    }

}

extension String {
    
    func trimmed() -> String? {
        let trimmed = self.trimmingCharacters(in: .whitespaces)
        return trimmed.count > 0 ? trimmed : nil
    }
}
