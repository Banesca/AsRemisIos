//
//  CreateUserTableViewCell.swift
//  AsRemis
//
//  Created by Luis F. Bustos Ramirez on 28/09/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

protocol CreateUserCellDelegate {
    func continueAction(_ valueTxt : String)
}

class CreateUserTableViewCell: UITableViewCell {

    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var valueTxtField: UITextField!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var numberLbl: UILabel!
    
    var delegate: CreateUserCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        numberLbl.layer.cornerRadius = numberLbl.bounds.size.height/2
        numberLbl.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func continueAction(_ sender: Any) {
        let stringValue = (valueTxtField.text?.isEmpty)! ?  "" : valueTxtField.text
        delegate?.continueAction(stringValue! as String)
    }
    
}
