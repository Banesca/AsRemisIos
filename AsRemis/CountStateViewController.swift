//
//  CountStateViewController.swift
//  AsRemis
//
//  Created by Luis Fernando Bustos Ramírez on 9/24/17.
//  Copyright © 2017 Luis Fernando Bustos Ramírez. All rights reserved.
//

import UIKit

class CountStateViewController: BaseViewController{
    
    @IBOutlet weak var totalPaymentImg: UIImageView!
    @IBOutlet weak var totalPaymentLbl: UILabel!
    @IBOutlet weak var currentAccountImg: UIImageView!
    @IBOutlet weak var currentAccountLbl: UILabel!
    @IBOutlet weak var totalToPayImg: UIImageView!
    @IBOutlet weak var totalToPayLbl: UILabel!
    @IBOutlet weak var totalCurrentValueImg: UIImageView!
    @IBOutlet weak var totalCurrentValueLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSlideMenuButton()
        // Do any additional setup after loading the view, typically from a nib.
        totalPaymentImg.layer.cornerRadius = totalPaymentImg.bounds.size.height/2
        totalPaymentImg.clipsToBounds = true
        currentAccountImg.layer.cornerRadius = currentAccountImg.bounds.size.height/2
        currentAccountImg.clipsToBounds = true
        totalToPayImg.layer.cornerRadius = totalToPayImg.bounds.size.height/2
        totalToPayImg.clipsToBounds = true
        totalCurrentValueImg.layer.cornerRadius = totalCurrentValueImg.bounds.size.height/2
        totalCurrentValueImg.clipsToBounds = true
        self.requestInformation()
        self.hideKeyboardWhenTappedAround()

        navigationItem.title = "Bienvenido!"
    }
    
    func requestInformation(){
        let http = Http()
        var idValue = ""
        if SingletonsObject.sharedInstance.userSelected?.driver != nil{
            idValue = (SingletonsObject.sharedInstance.userSelected?.user?.idDriver?.stringValue)!
        }else{
            idValue = (SingletonsObject.sharedInstance.userSelected?.user?.idClient?.stringValue)!
        }
        http.listLiquidationDriver(idValue, completion: { (liquidationDriver) -> Void in
            self.totalPaymentLbl.text = "Total Pagos: \(liquidationDriver?.liquidation ?? "0.0")"
            self.currentAccountLbl.text = "Saldo Cuenta: \(liquidationDriver?.ingreso ?? "0.0")"
            self.totalToPayLbl.text = "Total Monto A Pagar: \(liquidationDriver?.egreso ?? "0.0")"
            self.totalCurrentValueLbl.text = "Total Monto a Favor: \(liquidationDriver?.ingresoProcess ?? "0.0")"
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
