//
//  ServicesActiveViewController.swift
//  AsRemis
//
//  Created by Luis F. Bustos Ramirez on 02/10/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

protocol ServicesActiveDelegate {
    func showDetail()
}

class ServicesActiveViewController: UIViewController {
    
    var delegate : ServicesActiveDelegate?
    var isDriver = false
    
    @IBOutlet weak var servicesImg: UIImageView!
    @IBOutlet weak var servicesBtn: UIButton!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var servicesImgWidthConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isDriver{
            servicesImgWidthConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func getServices(_ sender: Any) {
        delegate?.showDetail()
    }

}

