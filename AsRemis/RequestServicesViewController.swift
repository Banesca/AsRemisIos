//
//  RequestServicesViewController.swift
//  AsRemis
//
//  Created by Luis F. Bustos Ramirez on 25/10/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit
import GooglePlaces
import CoreLocation

protocol RequestServicesDelegate {
    func hideRequest()
    func increaseHeightOfRequestView(_ increase: Bool)
}

class RequestServicesViewController: UIViewController {

    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var searchPlaceBtn: UIButton!
    @IBOutlet weak var carImg: UIImageView!
    @IBOutlet weak var typeVehicleBtn: UIButton!
    @IBOutlet weak var aireplaneImg: UIImageView!
    @IBOutlet weak var checkboxBtn: UIButton!
    @IBOutlet weak var tripInfoLbl: UILabel!
    @IBOutlet weak var requestBtn: UIButton!
    
    @IBOutlet weak var airplaneView: UIView!
    @IBOutlet weak var flyTimeLbl: UILabel!
    @IBOutlet weak var flyTimeBtn: UIButton!
    @IBOutlet weak var flyTimeTxtField: UITextField!
    @IBOutlet weak var flyAirportLbl: UILabel!
    @IBOutlet weak var flyAirportTxtField: UITextField!
    @IBOutlet weak var flyAirplaneLbl: NSLayoutConstraint!
    @IBOutlet weak var flyAirplaneTxtField: UITextField!
    @IBOutlet weak var flyNumberLbl: UILabel!
    @IBOutlet weak var flyNumberTxtField: UITextField!
    
    var optionsVehicles = [FleetTypeEntity]()
    var fleetSelected = FleetTypeEntity()
    var destination: GMSPlace?
    var includeInformation = false
    
    var delegate: RequestServicesDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchPlaceBtn.layer.cornerRadius = 0.5
        searchPlaceBtn.layer.borderColor = UIColor.lightGray.cgColor
        searchPlaceBtn.layer.borderWidth = 1
        searchPlaceBtn.clipsToBounds = true
        
        typeVehicleBtn.layer.cornerRadius = 0.5
        typeVehicleBtn.layer.borderColor = UIColor.lightGray.cgColor
        typeVehicleBtn.layer.borderWidth = 1
        typeVehicleBtn.clipsToBounds = true
        
        checkboxBtn.layer.borderColor = UIColor.lightGray.cgColor
        checkboxBtn.layer.borderWidth = 1
        checkboxBtn.clipsToBounds = true
        
        airplaneView.isHidden = true
        
        getVehicleType()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func searchPlaceAction(_ sender: Any) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    
    @IBAction func selectVehicleType(_ sender: Any) {
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
    
    @IBAction func checkBoxAction(_ sender: Any) {
        if includeInformation{
            checkboxBtn.backgroundColor = .white
            checkboxBtn.setImage(nil, for: .normal)
            includeInformation = false
        }else{
            checkboxBtn.backgroundColor = UIColor.cyan
            checkboxBtn.setImage(UIImage.init(named: "ic_check_white_48pt"), for: .normal)
            includeInformation = true
        }
        airplaneView.isHidden = !includeInformation
        delegate?.increaseHeightOfRequestView(includeInformation)
    
    }
    
    @IBAction func flyTimeAction(_ sender: Any) {
        let selector = SelectorViewController(nibName: "SelectorViewController", bundle: nil)
        selector.modalTransitionStyle = .crossDissolve
        selector.modalPresentationStyle = .overCurrentContext
        selector.delegate = self
        selector.selectorDate = false
        self.present(selector, animated: true, completion: nil)
    }
    
    @IBAction func requestAction(_ sender: Any) {
        let userLocation = SingletonsObject.sharedInstance.userPosition
        let placeOrigin = PlaceEntity(name: "", latitude: "\(userLocation?.coordinate.latitude ?? 0.0 )", longitude: "\(userLocation?.coordinate.longitude ?? 0.0 )")
        
        let placeDestino = PlaceEntity(name: (destination?.name)!, latitude: "\(destination?.coordinate.latitude ?? 0.0 )", longitude: "\(destination?.coordinate.longitude ?? 0.0)")
        
        let travel = TravelEntity()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let myStringafd = formatter.string(from:  Date())
        
        travel.dateTravel = myStringafd
        if includeInformation{
            travel.airlineCompany = flyAirplaneTxtField.text
            travel.flyNumber = flyNumberTxtField.text
            travel.hoursAribo = flyTimeBtn.titleLabel?.text
        }
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
                self.delegate?.hideRequest()
            }else{
                showError()
            }
        })
        
        
    }

}

extension RequestServicesViewController{
    func getVehicleType(){
        let http = Http.init()
        http.fleetType({(fleets) -> Void in
            for fleet in fleets!{
                self.optionsVehicles.append(fleet)
                if self.fleetSelected.vehiclenType == ""{
                    self.fleetSelected = fleet
                    self.typeVehicleBtn.setTitle("Tipo De Vehiculo: \(fleet.vehiclenType ?? "")", for: .normal)
                }
            }
        })
    }
}

extension RequestServicesViewController: AlertPickerDelegate{
    func indexSelected(_ index: Int, andTag: Int) {
        fleetSelected = optionsVehicles[index]
        self.typeVehicleBtn.setTitle("Tipo De Vehiculo: \(optionsVehicles[index].vehiclenType ?? "")", for: .normal)
    }
}

extension RequestServicesViewController: SelectorDateDelegate{
    func dateSelected(_ date: Date) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd/mm/yyyy"
        let timeString = dateformatter.string(from: date)
        flyTimeBtn.setTitle(timeString, for: UIControlState.normal)
    }
    func timeSelected(_ time: Date) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "hh:mm a"
        let timeString = dateformatter.string(from: time)
        flyTimeBtn.setTitle(timeString, for: UIControlState.normal)
    }
}
extension RequestServicesViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        dismiss(animated: true, completion: nil)
        destination = place
        searchPlaceBtn.setTitle(place.name, for: .normal)
        searchPlaceBtn.setTitleColor(.black, for: .normal)
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



