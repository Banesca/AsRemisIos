//
//  TripCanceledViewController.swift
//  AsRemis
//
//  Created by Luis F. Bustos Ramirez on 25/10/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

protocol TripCanceledDelegate {
    func hideCanceledView()
}
class TripCanceledViewController: UIViewController {

    @IBOutlet weak var reasonTableView: UITableView!
    @IBOutlet weak var messageTitleLbl: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var reasons = [ReasonEntity]()
    var delegate : TripCanceledDelegate?
    var indexSelected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        reasonTableView.delegate = self
        reasonTableView.dataSource = self
        reasonTableView.register(UINib(nibName: "TripCanceledTableViewCell", bundle: nil), forCellReuseIdentifier: "TripCanceledTableViewCell")
        getReasons()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getReasons(){
        let http = Http.init()
        http.obtIdMotivo(completion:  { (response) -> Void in
            for reason in response!{
                self.reasons.append(reason)
            }
            self.reasonTableView.reloadData()
        })
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        let idClient = (SingletonsObject.sharedInstance.userSelected?.user?.idClient?.stringValue)!
        let reasonSelected = reasons[indexSelected]
        let http = Http.init()
        http.cancelByClient(Id: idClient, idReasonCancelKf: (reasonSelected.idReason?.stringValue)!, completion: { (response) -> Void in
            self.dismiss(animated: true, completion: nil)
            self.delegate?.hideCanceledView()
        })
    }

}

extension TripCanceledViewController:  UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reasons.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripCanceledTableViewCell", for: indexPath) as! TripCanceledTableViewCell
        
        var imageForReason = ""
        if indexSelected == indexPath.row{
            imageForReason = "ic_lens"
        }else{
             imageForReason = "ic_panorama_fish_eye"
        }
        cell.cancelImg.image = UIImage.init(named: imageForReason)
        let reason = reasons[indexPath.row]
        cell.titleLbl.text = reason.reason
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexSelected = indexPath.row
        reasonTableView.reloadData()
    }
    
}
