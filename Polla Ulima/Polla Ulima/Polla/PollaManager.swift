//
//  PollaManager.swift
//  Polla Ulima
//
//  Created by Anton Tchistiakov on 6/14/18.
//  Copyright © 2018 Anton Tchistiakov. All rights reserved.
//

import Foundation

class PollaManager {
    private let baseURL = "https://script.google.com/macros/s/AKfycby9X8MFw4jAENilmKyvKi8p5_5HGhM_vsYHhHD6W8_5iQhfhTg/exec"
    private var delegate: PollaDelegate!
    
    init(delegate: PollaDelegate) {
        self.delegate = delegate
    }
    
    func getTeams() {
        if let url = URL(string: baseURL) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            URLSession(configuration: .default).dataTask(with: request, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                if let json = data, let fixtures = try? JSONDecoder().decode([Fixture].self, from: json) {
                    DispatchQueue.main.async {
                        self.delegate?.onGetComplete(fixtures)
                    }
                }
            }).resume()
        }
    }
}

protocol PollaDelegate {
    func onGetComplete(_ fixtures: [Fixture])
}
