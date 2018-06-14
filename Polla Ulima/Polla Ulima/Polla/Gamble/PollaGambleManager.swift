//
//  PollaGambleManager.swift
//  Polla Ulima
//
//  Created by Anton Tchistiakov on 6/14/18.
//  Copyright © 2018 Anton Tchistiakov. All rights reserved.
//

import Foundation

class PollaGambleManager {
    private let baseURL = "https://script.google.com/macros/s/AKfycby9X8MFw4jAENilmKyvKi8p5_5HGhM_vsYHhHD6W8_5iQhfhTg/exec"
    
    private var delegate: PollaGambleDelegate?
    
    init(delegate: PollaGambleDelegate) {
        self.delegate = delegate
    }
    
    func saveGamble(user: String, idFixture: Int, winner: String, score1: Int, score2: Int) {
        let urlString = baseURL + "?usuario=\(user)&idpartido=\(idFixture)&ganador=\(winner)&golesequipo1=\(score1)&golesequipo2=\(score2)"
        guard let url = URL(string: urlString) else {
            print("wrong url")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession(configuration: .default).dataTask(with: request, completionHandler: { (data, response, error) in
            if error != nil {
                print("Error al realizar el post")
                return
            }
            
            DispatchQueue.main.async {
                self.delegate?.onPostComplete()
            }
        }).resume()
    }
}

protocol PollaGambleDelegate {
    func onPostComplete()
}
