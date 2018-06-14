//
//  PollaTableViewCell.swift
//  Polla Ulima
//
//  Created by Anton Tchistiakov on 6/14/18.
//  Copyright © 2018 Anton Tchistiakov. All rights reserved.
//

import UIKit

class PollaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var team1Label: UILabel!
    @IBOutlet weak var team2Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
