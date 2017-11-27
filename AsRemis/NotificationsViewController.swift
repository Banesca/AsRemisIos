
//
//  NotificationsViewController.swift
//  AsRemis
//
//  Created by Luis Fernando Bustos Ramírez on 9/24/17.
//  Copyright © 2017 Luis Fernando Bustos Ramírez. All rights reserved.
//

import UIKit

class NotificationsViewController: BaseViewController{
    
    @IBOutlet weak var notificationsTV: UITableView!
    var notificationsArr = [NotificationEntity]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSlideMenuButton()
        notificationsTV.dataSource = self
        notificationsTV.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.title = "Bienvenido!"
        requestNotifications()
    }
    
    func requestNotifications(){
        let http = Http()
        var idValue = ""
        if SingletonsObject.sharedInstance.userSelected?.driver != nil{
            idValue = (SingletonsObject.sharedInstance.userSelected?.user?.idDriver?.stringValue)!
        }else{
            idValue = (SingletonsObject.sharedInstance.userSelected?.user?.idClient?.stringValue)!
        }
        http.getNotification(idValue, completion: { (notifications) -> Void in
            if notifications != nil{
                if notifications!.count > 0{
                    self.notificationsArr = notifications!
                    self.notificationsTV.reloadData()
                }else{
                    self.showEmptyAlert()
                }
            }else{
                self.showEmptyAlert()
            }
        })
    }
    
    func showEmptyAlert(){
        let alertController = UIAlertController(title: "No hay resultados", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            print("OK")
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath)
        
        let backgroundView = cell.viewWithTag(100)!
        backgroundView.layer.cornerRadius = 5
        backgroundView.layer.borderColor = UIColor.lightGray.cgColor
        backgroundView.layer.borderWidth = 2
        backgroundView.clipsToBounds = true
        let titleLbl = cell.viewWithTag(101) as! UILabel
        titleLbl.textColor = .red
        titleLbl.text = notificationsArr[indexPath.row].title!
        let statusLbl = cell.viewWithTag(102) as! UILabel
        statusLbl.text = notificationsArr[indexPath.row].subTitle!
        let paymentLbl = cell.viewWithTag(103) as! UILabel
        paymentLbl.text = "\(notificationsArr[indexPath.row].idType!)"
        let totalToPayLbl = cell.viewWithTag(104) as! UILabel
        totalToPayLbl.text = "\(notificationsArr[indexPath.row].idNotification!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
