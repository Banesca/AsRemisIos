//
//  CreateUserSubmenuTableViewCell.swift
//  AsRemis
//
//  Created by Luis Fernando Bustos Ramírez on 10/24/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

protocol CreateUserSubmenuCellDelegate {
    func continueAction(_ firstValue : String, secondValue : String, tirthValue : String)
    func domainValue(_ domain: String)
    func actionSelected(_ index:Int)
}

class CreateUserSubmenuTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var titleLbl1: UILabel!
    @IBOutlet weak var valueBtn1: UIButton!
    @IBOutlet weak var titleLbl2: UILabel!
    @IBOutlet weak var valueBtn2: UIButton!
    @IBOutlet weak var titleLbl3: UILabel!
    @IBOutlet weak var valueBtn3: UIButton!
    @IBOutlet weak var numberLbl: UILabel!
    @IBOutlet weak var domainTxtField: UITextField!
    
    var delegate: CreateUserSubmenuCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        numberLbl.layer.cornerRadius = numberLbl.bounds.size.height/2
        numberLbl.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func optionSelectedAction(_ sender: UIButton) {
        if sender == valueBtn1{
            delegate?.actionSelected(1)
        }
        if sender == valueBtn2{
            delegate?.actionSelected(2)
        }
        if sender == valueBtn3{
            delegate?.actionSelected(3)
        }
    }
    
    @IBAction func continueAction(_ sender: Any) {
        delegate?.continueAction((valueBtn1.titleLabel?.text)!, secondValue: (valueBtn2.titleLabel?.text)!, tirthValue: (valueBtn3.titleLabel?.text)!)
        delegate?.domainValue(domainTxtField.text!)
    }
    
    
    
}
