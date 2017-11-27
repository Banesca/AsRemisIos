//
//  MakeReservationViewController.swift
//  AsRemis
//
//  Created by Luis F. Bustos Ramirez on 25/10/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit
import GooglePlaces

protocol MakeReservationDelegate {
    func hideReservation()
}

class MakeReservationViewController: UIViewController {

    @IBOutlet weak var originTxtField: UITextField!
    @IBOutlet weak var originBtn: UIButton!
    @IBOutlet weak var destinationTxtField: UITextField!
    @IBOutlet weak var destinationBtn: UIButton!
    
    @IBOutlet weak var vehicleTypeBtn: UIButton!
    @IBOutlet weak var dateBtn: UIButton!
    @IBOutlet weak var hourBtn: UIButton!
    @IBOutlet weak var requestBtn: UIButton!
    
    var origin: GMSPlace?
    var destination: GMSPlace?
    var textOriginSelected = true
    
    var optionsVehicles = [FleetTypeEntity]()
    var fleetSelected = FleetTypeEntity()
    
    var delegate : MakeReservationDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        originTxtField.delegate = self
        destinationTxtField.delegate = self
        originBtn.layer.cornerRadius = 0.5
        originBtn.clipsToBounds = true
        destinationBtn.layer.cornerRadius = 0.5
        destinationBtn.clipsToBounds = true
        getVehicleType()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func locationAction(_ sender: UIButton) {
        if sender.tag == 99{
            textOriginSelected = true
        }else{
            textOriginSelected = false
        }
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    
    @IBAction func selectTypeVehicleAction(_ sender: Any) {
        let picker = AlertPickerSelectorViewController(nibName: "AlertPickerSelectorViewController", bundle: nil)
        picker.delegate = self
        picker.modalTransitionStyle = .crossDissolve
        picker.modalPresentationStyle = .overCurrentContext
        var arrTemp = [String]()
        for vehicle in optionsVehicles{
            arrTemp.append("Tipo De Vehiculo: \(vehicle.vehiclenType ?? "")")
        }
        picker.arrOptions = arrTemp
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func dateTimeAction(_ sender: UIButton) {
        let selector = SelectorViewController(nibName: "SelectorViewController", bundle: nil)
        selector.modalTransitionStyle = .crossDissolve
        selector.modalPresentationStyle = .overCurrentContext
        selector.delegate = self
        if sender == dateBtn{
            selector.selectorDate = true
        }else{
            selector.selectorDate = false
        }
        self.present(selector, animated: true, completion: nil)
    }

    @IBAction func requestAction(_ sender: Any) {
        let placeOrigin = PlaceEntity(name: (origin?.name)!, latitude: "\(origin?.coordinate.latitude ?? 0.0 )", longitude: "\(origin?.coordinate.longitude ?? 0.0)")
        
        let placeDestino = PlaceEntity(name: (destination?.name)!, latitude: "\(destination?.coordinate.latitude ?? 0.0 )", longitude: "\(destination?.coordinate.longitude ?? 0.0)")
        
        let travel = TravelEntity()
        
        travel.dateTravel = "\(dateBtn.titleLabel?.text ?? "") \(hourBtn.titleLabel?.text ?? "" )"
        
        travel.destination = placeDestino
        travel.origin = placeOrigin
        travel.idClientKf = SingletonsObject.sharedInstance.userSelected?.client?.idProfile
        travel.idTypeVehicle = fleetSelected.idVehicleType
        travel.isTravelComany = false
        
        if SingletonsObject.sharedInstance.userSelected?.client?.idProfile == "6"{
            travel.idUserCompanyKf = SingletonsObject.sharedInstance.userSelected?.client?.idUser
        }else{
            travel.idUserCompanyKf = 0
        }
        travel.isTravelSendMovil = true
        travel.terminal = ""
        
        let http = Http()
        http.addTravel(travel, completion: { (addTrip) -> Void in
            if addTrip{
                let alertController = UIAlertController(title: "Reserva Soicitada", message: "Reserva Soicitada", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    (result : UIAlertAction) -> Void in
                    print("OK")
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                self.clearView()
                self.delegate?.hideReservation()
            }else{
                self.showError()
            }
        })
    }
    
    func clearView(){
        dateBtn.setTitle("DD/MM/YYYY", for: UIControlState.normal)
        hourBtn.setTitle("HH:MM", for: UIControlState.normal)
        originTxtField.text = ""
        destinationTxtField.text = ""
    }
    
    func showError(){
        let alertController = UIAlertController(title: "Error", message: "No se pudo registrar tu viaje, favor de revisar tu información", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            print("OK")
        }
        alertController.addAction(okAction)
        
        let window = UIWindow.init(frame: UIScreen.main.bounds)
        window.rootViewController = UIViewController.init()
        window.windowLevel = UIWindowLevelAlert+1
        window.makeKeyAndVisible()
        window.rootViewController?.present(alertController, animated: true, completion: nil)
    }

}

extension MakeReservationViewController{
    func getVehicleType(){
        let http = Http.init()
        http.fleetType({(fleets) -> Void in
            for fleet in fleets!{
                self.optionsVehicles.append(fleet)
                if self.fleetSelected.vehiclenType == ""{
                    self.fleetSelected = fleet
                    self.vehicleTypeBtn.setTitle("Tipo De Vehiculo: \(fleet.vehiclenType ?? "")", for: .normal)
                }
            }
        })
    }
}

extension MakeReservationViewController: SelectorDateDelegate{
    func dateSelected(_ date: Date) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd/mm/yyyy"
        let timeString = dateformatter.string(from: date)
        dateBtn.setTitle(timeString, for: UIControlState.normal)
    }
    func timeSelected(_ time: Date) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "hh:mm a"
        let timeString = dateformatter.string(from: time)
        hourBtn.setTitle(timeString, for: UIControlState.normal)
    }
}

extension MakeReservationViewController: AlertPickerDelegate{
    func indexSelected(_ index: Int, andTag: Int) {
        fleetSelected = optionsVehicles[index]
        self.vehicleTypeBtn.setTitle(optionsVehicles[index].vehiclenType, for: .normal)
    }
}


extension MakeReservationViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension MakeReservationViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        dismiss(animated: true, completion: nil)
        if textOriginSelected{
            origin = place
            originBtn.setTitle(place.name, for: .normal)
            originBtn.setTitleColor(.black, for: .normal)
        }else{
            destination = place
            destinationBtn.setTitle(place.name, for: .normal)
            destinationBtn.setTitleColor(.black, for: .normal)
        }
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
