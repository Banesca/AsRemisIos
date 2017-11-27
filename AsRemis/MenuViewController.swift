//
//  MenuViewController.swift
//  DrawerTest
//
//  Created by Luis F. Bustos Ramirez on 25/09/17.
//  Copyright © 2017 RoadTrack. All rights reserved.
//


import UIKit

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
    func presentItemSelectedAtIndex(_ index : Int32)
}

class MenuViewController: UIViewController {
    /**
     *  Array to display menu options
     */
    @IBOutlet var tblMenuOptions : UITableView!
    
    /**
     *  Transparent button to hide menu
     */
    @IBOutlet var btnCloseMenuOverlay : UIButton!
    
    /**
     *  Background Gray view
     */
    @IBOutlet weak var backgroundView: UIView!
    /**
     *  Array containing menu options
     */
    var arrayMenuOptions = [Dictionary<String,String>]()
    
    var arraySecondMenuOptions = [Dictionary<String,String>]()
    
    /**
     *  Menu button which was tapped to display the menu
     */
    var btnMenu : UIButton!
    
    /**
     *  Delegate of the MenuVC
     */
    var delegate : SlideMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblMenuOptions.delegate = self
        tblMenuOptions.dataSource = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(sender:)))
        tap.delegate = self
        backgroundView.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCloseMenuClick(_ button:UIButton!){
        btnMenu.tag = 0
        
        if (self.delegate != nil) {
            var index = Int32(button.tag)
            if(button == self.btnCloseMenuOverlay){
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
        }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
        })
    }
}


extension MenuViewController: UIGestureRecognizerDelegate{
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        btnMenu.sendActions(for: .touchUpInside)
    }
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        if arraySecondMenuOptions.count > 0{
            return 2
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 150
        }else{
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            let header = tableView.dequeueReusableCell(withIdentifier: "SectionHeader")
            //let imgIcon = header?.viewWithTag(101) as! UIImageView
            let nameLbl = header?.viewWithTag(102) as! UILabel
            nameLbl.text = SingletonsObject.sharedInstance.userSelected?.user?.firstNameUser
            let mailLbl = header?.viewWithTag(103) as! UILabel
            mailLbl.text = SingletonsObject.sharedInstance.userSelected?.user?.emailUser
            return header
        }else{
            return tableView.dequeueReusableCell(withIdentifier: "SubSectionHeader")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return arrayMenuOptions.count
        }else{
            return arraySecondMenuOptions.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        let imgIcon = cell.viewWithTag(101) as! UIImageView
        let lblTitle = cell.viewWithTag(102) as! UILabel
        
        if indexPath.section == 0{
            lblTitle.text = arrayMenuOptions[indexPath.row]["title"]!
            imgIcon.image = UIImage(named: arrayMenuOptions[indexPath.row]["icon"]!)
        }else{
            lblTitle.text = arraySecondMenuOptions[indexPath.row]["title"]!
            imgIcon.image = UIImage(named: arraySecondMenuOptions[indexPath.row]["icon"]!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            delegate?.slideMenuItemSelectedAtIndex(Int32(indexPath.row))
        }else{
            delegate?.presentItemSelectedAtIndex(Int32(indexPath.row))
        }
    }
}
