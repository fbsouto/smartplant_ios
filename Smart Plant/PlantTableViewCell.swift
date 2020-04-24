//
//  PlantTableViewCell.swift
//  Smart Plant
//
//  Created by Fellipe Souto on 18/04/20.
//  Copyright © 2020 Fellipe Souto. All rights reserved.
//

import UIKit

class PlantTableViewCell: UITableViewCell {

    @IBOutlet weak var namePlant: UILabel!
    @IBOutlet weak var umidadeSolo: UILabel!
    @IBOutlet weak var statusSolo: UILabel!
    @IBOutlet var tempAr: UILabel!
    @IBOutlet var umidadeAr: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
