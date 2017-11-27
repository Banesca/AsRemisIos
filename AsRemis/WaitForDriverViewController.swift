//
//  WaitForDriverViewController.swift
//  AsRemis
//
//  Created by Luis F. Bustos Ramirez on 25/10/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

protocol WaitForDriverDelegate {
    
}

class WaitForDriverViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var cancelTrip: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //cancelTrip.layer.cornerRadius = cancelTrip.bounds.size.height/2
        //cancelTrip.clipsToBounds = true
        activityIndicator.startAnimating()
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        let tripCanceled = TripCanceledViewController(nibName: "TripCanceledViewController", bundle: nil)
        tripCanceled.delegate = self
        tripCanceled.modalTransitionStyle = .crossDissolve
        tripCanceled.modalPresentationStyle = .overCurrentContext
        self.present(tripCanceled, animated: true, completion: nil)
    }
}

extension WaitForDriverViewController : TripCanceledDelegate{
    func hideCanceledView() {
        self.dismiss(animated: false, completion: nil)
    }
}
