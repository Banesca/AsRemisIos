//
//  SettingsCreditCardViewController.swift
//  AsRemis
//
//  Created by Luis F. Bustos Ramirez on 28/09/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

class SettingsCreditCardViewController: UIViewController {

    @IBOutlet weak var cardNameTxtField: UITextField!
    @IBOutlet weak var cardNameLbl: UILabel!
    @IBOutlet weak var securityIDTxtField: UITextField!
    @IBOutlet weak var securityIDLbl: UILabel!
    @IBOutlet weak var expirationMonthTxtField: UITextField!
    @IBOutlet weak var expirationYearTxtField: UITextField!
    @IBOutlet weak var expirationDateLbl: UILabel!
    @IBOutlet weak var fullNameTxtField: UITextField!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var cardTypeBtn: UIButton!
    @IBOutlet weak var cardTypeLbl: UILabel!
    @IBOutlet weak var idTxtField: UITextField!
    @IBOutlet weak var idLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Configurar Tarjeta"
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func creditCardTypeAction(_ sender: Any) {
        
        let alertController = UIAlertController(title: nil, message: "Tipo de tarjeta", preferredStyle: .actionSheet)
        
        let visaTxt = "Visa"
        let visaAction = UIAlertAction(title: visaTxt, style: .default, handler: { (alert: UIAlertAction!) -> Void in
            //  Do some action here.
            self.cardTypeBtn.setTitle(visaTxt, for: .normal)
        })
        
        let masterTxt = "Mastercard"
        let mastercardAction = UIAlertAction(title: masterTxt, style: .default, handler: { (alert: UIAlertAction!) -> Void in
            //  Do some destructive action here.
            self.cardTypeBtn.setTitle(masterTxt, for: .normal)
        })
        
        let amexTxt = "American Express"
        let americanAction = UIAlertAction(title: amexTxt, style: .default, handler: { (alert: UIAlertAction!) -> Void in
            //  Do some destructive action here.
            self.cardTypeBtn.setTitle(amexTxt, for: .normal)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert: UIAlertAction!) -> Void in
            //  Do something here upon cancellation.
        })
        
        alertController.addAction(visaAction)
        alertController.addAction(mastercardAction)
        alertController.addAction(americanAction)
        alertController.addAction(cancelAction)
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.barButtonItem = sender as? UIBarButtonItem
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func continueAction(_ sender: Any) {
        
    }
}


