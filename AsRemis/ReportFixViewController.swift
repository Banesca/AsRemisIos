//
//  ReportFIxViewController.swift
//  AsRemis
//
//  Created by Luis F. Bustos Ramirez on 28/09/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

class ReportFixViewController: UIViewController,UIGestureRecognizerDelegate{

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var reasonTxtField: UITextField!
    @IBOutlet weak var descriptionTxtField: UITextField!
    @IBOutlet weak var mailTxtField: UITextField!
    @IBOutlet weak var reportBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        tap.delegate = self
        backgroundView.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reportAction(_ sender: Any) {
        let reasonTxt = reasonTxtField.text
        let descriptionTxt = descriptionTxtField.text
        let mailTxt = mailTxtField.text
        if (!(reasonTxt?.isEmpty)! && !description.isEmpty && !(mailTxt?.isEmpty)!){
            let user = SingletonsObject.sharedInstance.userSelected?.user
            let report = ReporteEntity(userId: (user?.idUser)!, fullName: (user?.firstNameUser)!, correo: (user?.emailUser)!, correo2: mailTxt!, reason: reasonTxt!, company: "", message: descriptionTxt!, isTravelSendMovil: 1)
            let http = Http()
            http.failReport(report, completion: {(reportResponse) -> Void in
                if reportResponse == nil{
                    self.sendAlert()
                }
            })
        }else{
            self.sendAlert()
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func sendAlert(){
        let alertController = UIAlertController(title: "Correo no enviado", message: "No se pudo envíar el correo, favor de intentar mas tarde", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            print("OK")
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true, completion: nil)
    }
}
