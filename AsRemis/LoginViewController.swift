//
//  LoginViewController.swift
//  AsRemis
//
//  Created by Luis F. Bustos Ramirez on 27/09/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var asRemisImg: UIImageView!
    @IBOutlet weak var mailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var createAccountBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "AsRemis!"
        
        self.navigationController?.navigationBar.barTintColor = UIColor.GrayAsRemis
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(_ sender: Any) {
        let user = UserEntity.init(userName: mailTxtField.text!, userPass: passwordTxtField.text!, idTypeAuth: 2)
        let http = Http.init()
        http.checkVersion(SingletonsObject.sharedInstance.appCurrentVersion as String, completion: { (isValidVersion) -> Void in
            if isValidVersion{
                http.loginUser(user, completion: { (userJson) -> Void in
                    if userJson != nil && userJson?.user?.emailUser != ""{
                        self.handleResponse(userJson!)
                    }else{
                        let alertController = UIAlertController(title: "User not found", message: "User name or password are incorrenct, please try again", preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                            (result : UIAlertAction) -> Void in
                            print("OK")
                        }
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                })
            }else{
                let alertController = UIAlertController(title: "New update available", message: "Please update your aplication to continue using", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    (result : UIAlertAction) -> Void in
                    print("OK")
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        })
        
    }
    
    func handleResponse(_ user: UserFullEntity){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        SingletonsObject.sharedInstance.userSelected = user
        var driverId = NSNumber.init(value: 0)
        if user.user?.idDriver != nil{
            driverId = (user.user?.idDriver)!
        }
        let token = TokenEntity.init(tokenFB: "", idUser: (user.user?.idUser)!, idDriver: driverId, latVersionApp: SingletonsObject.sharedInstance.appCurrentVersion as String)
        
        let http = Http.init()
        http.getToken(token, completion: { (isValidToken) -> Void in
            if isValidToken{
                //SocketServices().prepareSocket(GlobalMembers().masterIp, userId: (user.user?.idUser)!, urlBase: GlobalMembers().urlDeveloper)
            }else{
                
            }
        })
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entityName = "UserEntityManaged"
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)!
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        if let result = try? managedContext.fetch(fetchRequest) {
            for object in result {
                managedContext.delete(object)
            }
        }
        
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        person.setValue(user.user?.emailUser, forKeyPath: "mail")
        person.setValue(user.user?.userPass, forKeyPath: "password")
        person.setValue(user.user?.firstNameUser, forKeyPath: "username")
        person.setValue(user.user?.idDriver, forKeyPath: "isDriver")
        
        do {
            try managedContext.save()
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = mainStoryboard.instantiateViewController(withIdentifier: "MainMenuNavigationController")
            UIApplication.shared.keyWindow?.rootViewController = viewController;
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
