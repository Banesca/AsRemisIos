//
//  SelectorViewController.swift
//  AsRemis
//
//  Created by Luis F. Bustos Ramirez on 25/10/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

protocol SelectorDateDelegate {
    func dateSelected(_ date : Date)
    func timeSelected(_ time : Date)
}

class SelectorViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    var selectorDate = true
    
    var delegate : SelectorDateDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        if selectorDate {
            datePicker.datePickerMode = .date
        }
        else {
            datePicker.datePickerMode = .time
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func acceptAction(_ sender: Any) {
        
        if selectorDate {
            delegate?.dateSelected(datePicker.date)
        }
        else {
            delegate?.timeSelected(datePicker.date)
        }
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

