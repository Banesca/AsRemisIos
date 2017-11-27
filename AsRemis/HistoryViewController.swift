//
//  HistoryViewController.swift
//  AsRemis
//
//  Created by Luis Fernando Bustos Ramírez on 9/24/17.
//  Copyright © 2017 Luis Fernando Bustos Ramírez. All rights reserved.
//

import UIKit

class HistoryViewController: BaseViewController , UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var historyTV: UITableView!
    var isDriver = false
    var historiTravels = [InfoTravelEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSlideMenuButton()
        navigationItem.title = "Bienvenido!"
        getHistoricList()
        historyTV.delegate = self
        historyTV.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getHistoricList(){
        let http = Http()
        if SingletonsObject.sharedInstance.userSelected?.driver != nil{
            let idValue = (SingletonsObject.sharedInstance.userSelected?.user?.idDriver?.stringValue)!
            http.getAllTravel(idValue, completion: {(travels) -> Void in
                if travels != nil{
                    for travel in travels!{
                        self.historiTravels.append(travel)
                    }
                    self.historyTV.reloadData()
                }
            })
        }else{
            let idValue = (SingletonsObject.sharedInstance.userSelected?.user?.idUser?.stringValue)!
            http.travelsByIdUser(idValue, completion: {(travels) -> Void in
                if travels != nil{
                    for travel in travels!{
                        self.historiTravels.append(travel)
                    }
                    self.historyTV.reloadData()
                }
            })
        }
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historiTravels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
        
        let backgroundView = cell.viewWithTag(100)!
        backgroundView.layer.cornerRadius = 5
        backgroundView.layer.borderColor = UIColor.lightGray.cgColor
        backgroundView.layer.borderWidth = 2
        backgroundView.clipsToBounds = true
        
        let entity = historiTravels[indexPath.row]
        
        let idLbl = cell.viewWithTag(101) as! UILabel
        idLbl.text = entity.codTravel
        let dirLbl = cell.viewWithTag(102) as! UILabel
        dirLbl.text = entity.nameOrigin
        
        let statusLbl = cell.viewWithTag(103) as! UILabel
        
        if SingletonsObject.sharedInstance.userSelected?.driver != nil{
            statusLbl.text = entity.totalAmount
            statusLbl.textColor = .green
        }else{
            statusLbl.textColor = .red
            statusLbl.text = entity.nameStatusTravel
        }
        
        //cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

}
