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
            let alert = AlertUtil.simpleAlert(title: "Aviso", detail: "Tienes que ingresar un usuario.")
            present(alert, animated: true)
            return
        }
        
        let defaults = UserDefaults.standard
        defaults.set(user, forKey: "USER")
        
        // Crear los viewControllers
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let pollaNavigatorController = storyboard.instantiateViewController(withIdentifier: "PollaNavigationController") as! UINavigationController
        pollaNavigatorController.tabBarItem.title = "Polla"
        
        let equiposNavigationViewController = storyboard.instantiateViewController(withIdentifier: EquiposViewController.identifier) as! UINavigationController
        equiposNavigationViewController.tabBarItem.title = "Equipos"
        
        // Crear el tab bar controller
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [equiposNavigationViewController, pollaNavigatorController]
        
        present(tabBarController, animated: true)
    }

}

extension String {
    
    func trimmed() -> String? {
        let trimmed = self.trimmingCharacters(in: .whitespaces)
        return trimmed.count > 0 ? trimmed : nil
    }
}
