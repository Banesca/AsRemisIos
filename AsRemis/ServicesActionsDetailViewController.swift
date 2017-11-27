//
//  ServicesActionsDetailViewController.swift
//  AsRemis
//
//  Created by Luis F. Bustos Ramirez on 02/10/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

class ServicesActionsDetailViewController: UIViewController {
    
    @IBOutlet weak var servicesInformationTV: UITableView!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var subImg: UIImageView!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var subImg2: UIImageView!
    @IBOutlet weak var subLbl2: UILabel!
    @IBOutlet weak var viewForDriverHeightConstraint: NSLayoutConstraint!
    
    var isDriver = false
    var statusInfoArr = [Dictionary<String,String>]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getStatusInfoArr()
        servicesInformationTV.dataSource = self
        servicesInformationTV.delegate = self
        
        if isDriver{
            subImg.image = UIImage.init(named: "ic_settings_phone")
        }else{
            mainImg.isHidden = true
            subImg.isHidden = true
            infoLbl.isHidden = true
            subImg2.isHidden = true
            subLbl2.isHidden = true
            viewForDriverHeightConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getStatusInfoArr(){
        statusInfoArr = [Dictionary<String,String>]()
        if isDriver{
            statusInfoArr.append(["title":"No se cargo información", "icon":"ic_query_builder_48pt"])
            statusInfoArr.append(["title":"No se cargo información", "icon":"ic_directions_48pt"])
            statusInfoArr.append(["title":"No se cargo información", "icon":"ic_pin_drop"])
            statusInfoArr.append(["title":"No se cargo información", "icon":"ic_error"])
            
            
        }else{
            statusInfoArr.append(["title":"No se cargo información", "icon":"ic_query_builder_48pt"])
            statusInfoArr.append(["title":"No se cargo información", "icon":"ic_directions_48pt"])
            statusInfoArr.append(["title":"No se cargo información", "icon":"ic_query_builder_48pt"])
            statusInfoArr.append(["title":"No se cargo información", "icon":"ic_settings_phone_48pt"])
            statusInfoArr.append(["title":"No se cargo información", "icon":"ic_directions_car_48pt"])
   
        }
    }
    

}
extension ServicesActionsDetailViewController:  UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusInfoArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServicesCell", for: indexPath)
        let imgIcon = cell.viewWithTag(101) as! UIImageView
        let lblTitle = cell.viewWithTag(102) as! UILabel
        
        lblTitle.text = statusInfoArr[indexPath.row]["title"]!
        imgIcon.image = UIImage(named: statusInfoArr[indexPath.row]["icon"]!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
