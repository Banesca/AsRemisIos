//
//  TripCanceledTableViewCell.swift
//  AsRemis
//
//  Created by Luis Fernando Bustos Ramírez on 11/24/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

class TripCanceledTableViewCell: UITableViewCell {
    @IBOutlet weak var cancelImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
