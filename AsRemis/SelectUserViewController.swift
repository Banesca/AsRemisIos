//
//  SelectUserViewController.swift
//  AsRemis
//
//  Created by Luis Fernando Bustos Ramírez on 9/24/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

class SelectUserViewController: UIViewController,UIGestureRecognizerDelegate {
    
    @IBOutlet weak var newDriverView: UIView!
    @IBOutlet weak var newClientView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Registro de Usuario!"
        // Do any additional setup after loading the view.
        
        let clientTap = UITapGestureRecognizer(target: self, action: #selector(self.newClientTap(sender:)))
        clientTap.delegate = self
        newClientView.addGestureRecognizer(clientTap)
        
        
        let driverTap = UITapGestureRecognizer(target: self, action: #selector(self.newClientTap(sender:)))
        driverTap.delegate = self
        newDriverView.addGestureRecognizer(driverTap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func newClientTap(sender: UITapGestureRecognizer? = nil) {
        var isDriver = true
        if sender?.view == newDriverView{
            isDriver = true
        }else{
            isDriver = false
        }
        
        let destViewController : CreateUserViewController = self.storyboard!.instantiateViewController(withIdentifier: "CreateUserViewController") as! CreateUserViewController
        destViewController.isDriver = isDriver
        
        self.navigationController?.pushViewController(destViewController, animated: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
