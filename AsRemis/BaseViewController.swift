//
//  BaseViewController.swift
//  DrawerTest
//
//  Created by Luis F. Bustos Ramirez on 25/09/17.
//  Copyright © 2017 RoadTrack. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var listOfViews = [Dictionary<String,String>]()
    var listOfActions = [Dictionary<String,String>]()

    let btnProfile = UIButton(type: UIButtonType.system)
    let btnLogOut = UIButton(type: UIButtonType.system)

    var topConstraintP = NSLayoutConstraint()
    var topConstraintL = NSLayoutConstraint()
    
    func addSlideMenuButton(){
        let btnShowMenu = UIButton(type: UIButtonType.system)
        btnShowMenu.setImage(self.defaultMenuImage(), for: UIControlState())
        btnShowMenu.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnShowMenu.addTarget(self, action: #selector(BaseViewController.onSlideMenuButtonPressed(_:)), for: UIControlEvents.touchUpInside)
        updateArrayMenuOptions()
        let customBarItem = UIBarButtonItem(customView: btnShowMenu)
        self.navigationItem.leftBarButtonItem = customBarItem;
        
        self.navigationController?.navigationBar.barTintColor = UIColor.GrayAsRemis
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        prepareNavigationRight()
    }
    
    func defaultMenuImage() -> UIImage {
        var defaultMenuImage = UIImage()
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 30, height: 22), false, 0.0)
        
        UIColor.black.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 3, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 10, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 17, width: 30, height: 1)).fill()
        
        UIColor.white.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 4, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 11,  width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 18, width: 30, height: 1)).fill()
        
        defaultMenuImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return defaultMenuImage;
    }
    
    func updateArrayMenuOptions(){
        listOfViews = [Dictionary<String,String>]()
        listOfViews.append(["title":"Mi Ubicacion", "icon":"ic_map", "viewController":"GetRideViewController"])
        listOfViews.append(["title":"Historial", "icon":"ic_library_books", "viewController":"HistoryViewController"])
        listOfViews.append(["title":"Tarjeta", "icon":"ic_credit_card", "viewController":"CreditCardViewController"])
        listOfViews.append(["title":"Estado de cuenta", "icon":"ic_attach_money", "viewController":"CountStateViewController"])
        listOfViews.append(["title":"Notificaciones", "icon":"ic_add_alert", "viewController":"NotificationsViewController"])
        listOfViews.append(["title":"Reservas", "icon":"ic_assignment_ind", "viewController":"RequestViewController"])
        listOfViews.append(["title":"Chat", "icon":"ic_question_answer", "viewController":"ChatViewController"])
        
        listOfActions = [Dictionary<String,String>]()
        listOfActions.append(["title":"Reportar Falla", "icon":"ic_send", "viewController":"ReportFixViewController"])
    }
    
    @objc func onSlideMenuButtonPressed(_ sender : UIButton){
        if (sender.tag == 10)
        {
            // To Hide Menu If it already there
            self.slideMenuItemSelectedAtIndex(-1);
            
            sender.tag = 0;
            
            let viewMenuBack : UIView = view.subviews.last!
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                var frameMenu : CGRect = viewMenuBack.frame
                frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
                viewMenuBack.frame = frameMenu
                viewMenuBack.layoutIfNeeded()
                viewMenuBack.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                viewMenuBack.removeFromSuperview()
            })
            
            return
        }
        
        sender.isEnabled = false
        sender.tag = 10
        
        let menuVC : MenuViewController = self.storyboard!.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        menuVC.btnMenu = sender
        menuVC.arrayMenuOptions = listOfViews
        menuVC.arraySecondMenuOptions = listOfActions
        menuVC.delegate = self
        self.view.addSubview(menuVC.view)
        self.addChildViewController(menuVC)
        menuVC.view.layoutIfNeeded()
        menuVC.view.frame=CGRect(x: 0 - UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            menuVC.view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
            sender.isEnabled = true
        }, completion:nil)
        
        
    }
   }

extension BaseViewController{
    
    func prepareNavigationRight(){
        let btnRightMenu = UIButton(type: UIButtonType.system)
        btnRightMenu.setImage(UIImage(named:"ic_more_vert_white"), for: UIControlState())
        btnRightMenu.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnRightMenu.addTarget(self, action: #selector(BaseViewController.seeRightMenu(_:)), for: UIControlEvents.touchUpInside)
        let customBarRightItem = UIBarButtonItem(customView: btnRightMenu)
        
        let btnAssignment = UIButton(type: UIButtonType.system)
        btnAssignment.setImage(UIImage(named:"ic_add_alert_white"), for: UIControlState())
        btnAssignment.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnAssignment.addTarget(self, action: #selector(BaseViewController.assignmentAction(_:)), for: UIControlEvents.touchUpInside)
        let customBarRightItem2 = UIBarButtonItem(customView: btnAssignment)
        
        let btnAlert = UIButton(type: UIButtonType.system)
        btnAlert.setImage(UIImage(named:"ic_assignment_ind_white"), for: UIControlState())
        btnAlert.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnAlert.addTarget(self, action: #selector(BaseViewController.alertAction(_:)), for: UIControlEvents.touchUpInside)
        let customBarRightItem3 = UIBarButtonItem(customView: btnAlert)
        
        self.navigationItem.rightBarButtonItems = [customBarRightItem, customBarRightItem2, customBarRightItem3]
        
        prepareRightMenu()
        requestNotifications(btn: btnAssignment)
    }
    
    
    
    
    func requestNotifications(btn:UIButton){
        let http = Http()
        var idValue = ""
        if SingletonsObject.sharedInstance.userSelected?.driver != nil{
            idValue = (SingletonsObject.sharedInstance.userSelected?.user?.idDriver?.stringValue)!
        }else{
            idValue = (SingletonsObject.sharedInstance.userSelected?.user?.idClient?.stringValue)!
        }
        http.getNotification(idValue, completion: { (notifications) -> Void in
            if notifications != nil{
                let total = notifications?.count ?? 0
                if total > 0{
                    let label = UILabel(frame: CGRect(x: 15, y: -5, width: 20, height: 20))
                    label.textAlignment = .center
                    label.font = label.font.withSize(10)
                    label.layer.cornerRadius = 10
                    label.backgroundColor = .red
                    label.textColor = .white
                    label.text = "\(notifications?.count ?? 0)"
                    label.clipsToBounds = true
                    
                    btn.addSubview(label)
                }
            }
        })
    }
    
    
    func prepareRightMenu(){
        
        btnProfile.setTitle("Ver perfil", for: UIControlState.normal)
        btnProfile.tintColor = .black
        btnProfile.backgroundColor = .lightGray
        btnProfile.addTarget(self, action: #selector(BaseViewController.seeProfile(_:)), for: UIControlEvents.touchUpInside)
        btnProfile.translatesAutoresizingMaskIntoConstraints = false
        btnProfile.isHidden = true
        btnProfile.alpha = 0
        self.view.addSubview(btnProfile)
        topConstraintP = NSLayoutConstraint(item: btnProfile, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0)
        let rightConstraintP = NSLayoutConstraint(item: btnProfile, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -20)
        let widthConstraintP = NSLayoutConstraint(item: btnProfile, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        let heightConstraintP = NSLayoutConstraint(item: btnProfile, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        
        btnLogOut.setTitle("Log out", for: UIControlState.normal)
        btnLogOut.tintColor = .black
        btnLogOut.backgroundColor = .lightGray
        btnLogOut.addTarget(self, action: #selector(BaseViewController.logOutMenu(_:)), for: UIControlEvents.touchUpInside)
        btnLogOut.translatesAutoresizingMaskIntoConstraints = false
        btnLogOut.isHidden = true
        self.btnLogOut.alpha = 0
        self.view.addSubview(btnLogOut)
        topConstraintL = NSLayoutConstraint(item: btnLogOut, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0)
        let rightConstraintL = NSLayoutConstraint(item: btnLogOut, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -20)
        let widthConstraintL = NSLayoutConstraint(item: btnLogOut, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        let heightConstraintL = NSLayoutConstraint(item: btnLogOut, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        
        self.view.addConstraints([rightConstraintP, widthConstraintP, heightConstraintP, topConstraintP])
        self.view.addConstraints([rightConstraintL, widthConstraintL, heightConstraintL, topConstraintL])
        
        
    }
    
    @objc func assignmentAction(_ sender : UIButton){
        self.openViewControllerBasedOnIdentifier("NotificationsViewController")
    }
    
    @objc func alertAction(_ sender : UIButton){
        self.openViewControllerBasedOnIdentifier("RequestViewController")
    }
    
    @objc func seeRightMenu(_ sender : UIButton){
        if btnLogOut.isHidden{
            UIView.animate(withDuration: 0.6, animations: { () -> Void in
                self.btnLogOut.isHidden = false
                self.btnProfile.isHidden = false
                self.btnLogOut.alpha = 1
                self.btnProfile.alpha = 1
                self.topConstraintP.constant = 80
                self.topConstraintL.constant = 140
                self.view.layoutIfNeeded()
            }, completion: { (finished) -> Void in
                
            })
        }else{
            UIView.animate(withDuration: 0.6, animations: { () -> Void in
                self.topConstraintP.constant = 0
                self.topConstraintL.constant = 0
                self.btnLogOut.alpha = 0
                self.btnProfile.alpha = 0
                self.view.layoutIfNeeded()
            }, completion: { (finished) -> Void in
                self.btnLogOut.isHidden = true
                self.btnProfile.isHidden = true
            })
        }
    }
    
    @objc func seeProfile(_ sender : UIButton){
        seeRightMenu(sender)
        self.openViewControllerBasedOnIdentifier("UserViewController")
    }
    
    @objc func logOutMenu(_ sender : UIButton){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginNavigationController")
        UIApplication.shared.keyWindow?.rootViewController = viewController;
    }

}


extension BaseViewController: SlideMenuDelegate {
    
    func slideMenuItemSelectedAtIndex(_ index: Int32) {
        if(index >= 0){
            let topViewController : UIViewController = self.navigationController!.topViewController!
            print("View Controller is : \(topViewController) \n", terminator: "")
            let newVC = listOfViews[Int(index)]["viewController"]!
            self.openViewControllerBasedOnIdentifier(newVC)
        }
    }
    
    func presentItemSelectedAtIndex(_ index : Int32){
        let topViewController : UIViewController = self.navigationController!.topViewController!
        let newVC = listOfActions[Int(index)]["viewController"]!
        let destViewController : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: newVC)
        
        if (topViewController.restorationIdentifier! == destViewController.restorationIdentifier!){
            let btnShowMenu = self.navigationItem.leftBarButtonItem?.customView?.viewWithTag(10) as! UIButton
            btnShowMenu.sendActions(for: .touchUpInside)
        } else {
            let btnShowMenu = self.navigationItem.leftBarButtonItem?.customView?.viewWithTag(10) as! UIButton
            btnShowMenu.sendActions(for: .touchUpInside)
            
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = kCATransitionMoveIn
            transition.subtype = kCATransitionFromRight
            view.window!.layer.add(transition, forKey: kCATransition)
            self.present(destViewController, animated: false, completion: nil)
            //self.present(destViewController, animated: true, completion: nil)
        }
    }
    
    func openViewControllerBasedOnIdentifier(_ strIdentifier:String){
        let destViewController : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: strIdentifier)
        
        let topViewController : UIViewController = self.navigationController!.topViewController!
        
        if (topViewController.restorationIdentifier! == destViewController.restorationIdentifier!){
            if ((self.navigationItem.leftBarButtonItem?.customView?.viewWithTag(10)) != nil){
                let btnShowMenu = self.navigationItem.leftBarButtonItem?.customView?.viewWithTag(10) as! UIButton
                btnShowMenu.sendActions(for: .touchUpInside)
            }
        } else {
            self.navigationController!.pushViewController(destViewController, animated: true)
        }
    }
}
