//
//  UserViewController.swift
//  AsRemis
//
//  Created by Luis F. Bustos Ramirez on 29/09/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userNameTxtField: UITextField!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var dniLbl: UILabel!
    @IBOutlet weak var dniTxtField: UITextField!
    @IBOutlet weak var mailLbl: UILabel!
    @IBOutlet weak var mailTxtField: UITextField!
    @IBOutlet weak var numTelLbl: UILabel!
    @IBOutlet weak var numTelTxtField: UITextField!
    
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Bienvenido!"
        imagePicker.delegate = self
        
        
        let user = SingletonsObject.sharedInstance.userSelected
        userNameTxtField.text = user?.user?.firstNameUser
        lastNameTxtField.text = user?.user?.lastNameUser
        
        if user?.driver != nil{
            numTelTxtField.text = user!.driver?.phoneNumber
            mailTxtField.text = user!.driver?.email
            dniTxtField.text = user?.driver?.dni
        }
        else{
            numTelTxtField.text = user!.client?.phoneNumber
            mailTxtField.text = user!.client?.email
            dniTxtField.text = user?.client?.dni
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(sender:)))
        tap.delegate = self
        imageView.addGestureRecognizer(tap)
        
        
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchPhoto(){
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camara", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.shootPhoto()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Galería", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoFromLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func searchPhotoAction(_ sender: Any) {
        searchPhoto()
    }
    
    @IBAction func photoFromLibrary() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        imagePicker.modalPresentationStyle = .popover
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func shootPhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            present(imagePicker,animated: true,completion: nil)
        } else {
            noCamera()
        }
    }

    func noCamera(){
        let alertVC = UIAlertController(
            title: "Sin Camara",
            message: "Lo sentimos, este dispositivo no cuenta con camara",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    @IBAction func updateUser(_ sender: Any) {
        let http = Http()
        var statusDriver = NSNumber.init(value: 0)
        let user = SingletonsObject.sharedInstance.userSelected
        if user?.driver != nil{
            statusDriver = (user?.driver?.idStatusDriverTravelKf)!
        }
        let profile = UserProfileEntity.init(withIdProfile: (user?.user?.idProfileUser?.stringValue)!, firstName: userNameTxtField.text!, lastName: lastNameTxtField.text!, dni: dniTxtField.text!, phone: numTelTxtField.text!, email: mailTxtField.text!, idUser: (user!.user?.idUser)!, idStatusDriver: statusDriver)
        http.updateClientLiteMobil(profile, completion: { (userUpdated) -> Void in
            if userUpdated != nil{
                let alertController = UIAlertController(title: "Datos actualizados", message: "Tus datos fueron actualizados", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    (result : UIAlertAction) -> Void in
                    print("OK")
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }else{
                let alertController = UIAlertController(title: "Error al actualizar", message: "No se pudieron actualizar tus datos, favor de intentar mas tarde", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    (result : UIAlertAction) -> Void in
                    print("OK")
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        })
    }
}
extension  UserViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
  
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension UserViewController: UIGestureRecognizerDelegate{
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        searchPhoto()
    }
}
