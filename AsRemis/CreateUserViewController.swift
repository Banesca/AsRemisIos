//
//  CreateUserViewController.swift
//  AsRemis
//
//  Created by Luis Fernando Bustos Ramírez on 9/24/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

class CreateUserViewController: UIViewController{
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var nextQuestionBtn: UIButton!
    @IBOutlet weak var lastQuestionBtn: UIButton!
    @IBOutlet weak var userDetailsTV: UITableView!
    
    var indexSelected = 0
    var isDriver = false
    var statusInfoArr = [Dictionary<String,String>]()
    var submenuInfoArr = [Dictionary<String,String>]()
    
    var optionsMenu1 = [BrandEntity]()
    var optionsMenu2 = [ModelByBrand]()
    var optionsMenu3 = [FleetTypeEntity]()
    var optionsMenu4 = [EnterpriceEntity]()
    var optionsMenu5 = [CompanyAcountEntity]()
    var optionsMenu6 = [CenterAcountEntity]()
    
    var brandSelected = BrandEntity()
    var modelSelected = ModelByBrand()
    var fleetSelected = FleetTypeEntity()
    var enterprice = EnterpriceEntity()
    var company = CompanyAcountEntity()
    var center = CenterAcountEntity()
    var domainSelected = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isDriver{
            navigationItem.title = "Nuevo Chofer!"
        }else{
            navigationItem.title = "Nuevo Cliente!"
        }
        self.prepareNewInfoUser()
        
        let progress = Float(indexSelected)/Float(statusInfoArr.count-1)
        progressView.setProgress(progress, animated: true)
        
        userDetailsTV.register(UINib(nibName: "CreateUserTableViewCell", bundle: nil), forCellReuseIdentifier: "CreateUserTableViewCell")
        userDetailsTV.register(UINib(nibName: "CreateUserSubmenuTableViewCell", bundle: nil), forCellReuseIdentifier: "CreateUserSubmenuTableViewCell")
        userDetailsTV.delegate = self
        userDetailsTV.dataSource = self
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func lastQuestionAction(_ sender: Any) {
        if indexSelected > 0{
            indexSelected -= 1
            let progress = Float(indexSelected)/Float(statusInfoArr.count-1)
            progressView.setProgress(progress, animated: true)
            userDetailsTV.reloadData()
        }
    }

    @IBAction func nextQuestionAction(_ sender: Any) {
        if indexSelected < statusInfoArr.count - 1{
            indexSelected += 1
            let progress = Float(indexSelected)/Float(statusInfoArr.count-1)
            progressView.setProgress(progress, animated: true)
            userDetailsTV.reloadData()
        }else{
            createUser()
        }
    }
    
    func prepareNewInfoUser(){
        statusInfoArr = [Dictionary<String,String>]()
        submenuInfoArr = [Dictionary<String,String>]()
        if(isDriver){
            statusInfoArr.append(["title":"Nombre/Apellido","information":""])
            statusInfoArr.append(["title":"Nro. Chofer","information":""])
            statusInfoArr.append(["title":"Telefono","information":""])
            statusInfoArr.append(["title":"Vehiculo","information":""])
            statusInfoArr.append(["title":"Email","information":""])
            statusInfoArr.append(["title":"Contraseña","information":""])
            statusInfoArr.append(["title":"Confirmar","information":""])
            
            submenuInfoArr.append(["title":"Marca","information":"Seleccionar"])
            submenuInfoArr.append(["title":"Modelo","information":"Seleccionar"])
            submenuInfoArr.append(["title":"Categoría","information":"Seleccionar"])
            
            self.getBOInfoForDriver()
        }else{
            statusInfoArr.append(["title":"Nombre","information":""])
            statusInfoArr.append(["title":"Apellido","information":""])
            statusInfoArr.append(["title":"Telefono","information":""])
            statusInfoArr.append(["title":"Email","information":""])
            statusInfoArr.append(["title":"Contraseña","information":""])
            statusInfoArr.append(["title":"CUETA/C.Costo","information":""])
            statusInfoArr.append(["title":"Confirmar","information":""])
            
            submenuInfoArr.append(["title":"Empresa","information":"Seleccionar"])
            submenuInfoArr.append(["title":"Cuenta","information":"Seleccionar"])
            submenuInfoArr.append(["title":"Centro Costo","information":"Seleccionar"])
        }
    }
    
    
    func showAlertMessage(){
        let alertController = UIAlertController(title: "Información incompleta", message: "Favor de rellenar todos los campos", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            print("OK")
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func errorInUserCreated(){
        let alertController = UIAlertController(title: "Error al crear el usuario", message: "Favor de revisar los datos", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            print("OK")
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func createUserSuccessfull(){
        let alertController = UIAlertController(title: "Exito", message: "Se creo la cuenta exitosamente", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginNavigationController")
            UIApplication.shared.keyWindow?.rootViewController = viewController;
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func createUser(){
        let http = Http.init()
        if isDriver{
            let name = statusInfoArr[0]["information"]! as String
            let nroChof = statusInfoArr[1]["information"]! as String
            let phone = statusInfoArr[2]["information"]! as String
            let email = statusInfoArr[4]["information"]! as String
            let pass = statusInfoArr[5]["information"]! as String
            
            if (name.count > 0 && nroChof.count > 0 && phone.count > 0 && email.count > 0 && pass.count > 0) {
                let client = UserCreateEntity(driverWith: name, nrDriver: nroChof, phone: phone, email: email, password: pass)
                client.isVehicleProvider = 1
                client.isRequestMobil = 1
                let fleet = FleetTypeEntity(brand: modelSelected.idVehicleBrandAsigned!, model: modelSelected.nameVehicleModel!, type: fleetSelected.idVehicleType!, domainS: domainSelected)
                http.addPluDriver(client, fleet: fleet, completion: { (response) -> Void in
                    if response!{
                        self.createUserSuccessfull()
                    }else{
                        self.errorInUserCreated()
                    }
                })
            }else{
                showAlertMessage()
            }
        }else{
            let name = statusInfoArr[0]["information"]! as String
            let last = statusInfoArr[1]["information"]! as String
            let phone = statusInfoArr[2]["information"]! as String
            let email = statusInfoArr[3]["information"]! as String
            let pass = statusInfoArr[4]["information"]! as String
            
            if (name.count > 0 && last.count > 0 && phone.count > 0 && email.count > 0 && pass.count > 0) {
                let client = UserCreateEntity(clientWith: name, lastName: last, phone: phone, email: email, password: pass)
                client.idCompanyKf = Int(company.idCompanyAcount!)! as NSNumber //submenuInfoArr[0]["information"]!
                client.idCompanyAcount = Int(company.idCompanyAcount!)! as NSNumber
                client.idCostCenter = Int(center.idCostCenter!)! as NSNumber
                http.addClient(client, completion: { (response) -> Void in
                    if response!{
                        self.createUserSuccessfull()
                    }else{
                        self.errorInUserCreated()
                    }
                })
            }else{
                showAlertMessage()
            }
        }
    }
    
}

extension CreateUserViewController{
    //MARK: Methods for clientWS
    func validateMail(){
        let http = Http.init()
        let email = statusInfoArr[3]["information"]! as String
        if (email.count > 5) {
            http.validatorDomaint(email, completion: { (enterprices) -> Void in
                if enterprices != nil{
                    for enterprice in enterprices!{
                        self.optionsMenu4.append(enterprice)
                    }
                }
            })
        }
    }
    
    func getCompaniesFor(enterprice:EnterpriceEntity){
        self.enterprice = enterprice
        let http = Http.init()
        http.getAcountByidCompany(enterprice.idCompanyClient!, completion: { (companies) -> Void in
            if companies != nil{
                for company in companies!{
                    self.optionsMenu5.append(company)
                }
            }
        })
    }
    
    func getCostFor(company:CompanyAcountEntity){
        self.company = company
        let http = Http.init()
        http.costCenterByidAcount(company.idCompanyAcount!, completion: { (costs) -> Void in
            if costs != nil{
                for cost in costs!{
                    self.optionsMenu6.append(cost)
                }
            }
        })
    }
    
}

extension CreateUserViewController{
    //MARK: Methods for driverWS
    func getBOInfoForDriver(){
        let http = Http.init()
        http.brand({ (brands) -> Void in
            if brands != nil{
                for brand in brands!{
                    self.optionsMenu1.append(brand)
                }
            }
        })
    }
    
    func getBrandModel(brand:BrandEntity){
        brandSelected = brand
        let http = Http.init()
        http.byidBrand(brand.idVehicleBrand!, completion: {(models) -> Void in
            if models != nil{
                for model in models!{
                    self.optionsMenu2.append(model)
                }
            }
        })
    }
    
    func getFleetType(model:ModelByBrand){
        modelSelected = model
        let http = Http.init()
        http.fleetType({(fleets) -> Void in
            if fleets != nil{
                for fleet in fleets!{
                    self.optionsMenu3.append(fleet)
                }
            }
        })
    }
}

extension CreateUserViewController: UITableViewDataSource, UITableViewDelegate {
    //MARK: Table View data sources
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusInfoArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexSelected != -1 && indexSelected == indexPath.row){
            let title = statusInfoArr[indexPath.row]["title"]
            if title == "CUETA/C.Costo" || title == "Vehiculo"{
                if isDriver{
                    return 350
                }else{
                    return 300
                }
            }else{
                return 125
            }
        }
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexSelected != -1 && indexSelected == indexPath.row){
            let title = statusInfoArr[indexPath.row]["title"]
            if title == "CUETA/C.Costo" || title == "Vehiculo"{
                let cell = tableView.dequeueReusableCell(withIdentifier: "CreateUserSubmenuTableViewCell", for: indexPath) as! CreateUserSubmenuTableViewCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.numberLbl.text = "\(indexPath.row+1)"
                cell.titleLbl.text = statusInfoArr[indexPath.row]["title"]!
                cell.titleLbl1.text = submenuInfoArr[0]["title"]!
                cell.titleLbl2.text = submenuInfoArr[1]["title"]!
                cell.titleLbl3.text = submenuInfoArr[2]["title"]!
                cell.valueBtn1.setTitle(submenuInfoArr[0]["information"], for: UIControlState.normal)
                cell.valueBtn2.setTitle(submenuInfoArr[1]["information"], for: UIControlState.normal)
                cell.valueBtn3.setTitle(submenuInfoArr[2]["information"], for: UIControlState.normal)
                cell.domainTxtField.text = domainSelected
                if !isDriver{
                    cell.domainTxtField.isHidden = true
                }else{
                    cell.domainTxtField.isHidden = false
                }
                cell.delegate = self
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "CreateUserTableViewCell", for: indexPath) as! CreateUserTableViewCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.numberLbl.text = "\(indexPath.row+1)"
                cell.valueTxtField.text = statusInfoArr[indexPath.row]["information"]!
                cell.titleLbl.text = statusInfoArr[indexPath.row]["title"]!
                if(cell.titleLbl.text == "Contraseña"){
                    cell.valueTxtField.isSecureTextEntry = true
                }else{
                    cell.valueTxtField.isSecureTextEntry = false
                }
                if(cell.titleLbl.text == "Telefono"){
                    cell.valueTxtField.keyboardType = .numberPad
                }else{
                    if(cell.titleLbl.text == "Email"){
                        cell.valueTxtField.keyboardType = .emailAddress
                    }else{
                        cell.valueTxtField.keyboardType = .default
                    }
                }
                
                if(indexPath.row == statusInfoArr.count - 1){
                    cell.valueTxtField.isHidden = true
                }else{
                    cell.valueTxtField.isHidden = false
                }
                cell.delegate = self
                return cell
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DisableCell", for: indexPath)
            let lblNumber = cell.viewWithTag(101) as! UILabel
            lblNumber.layer.cornerRadius = lblNumber.bounds.size.height/2
            lblNumber.clipsToBounds = true
            let lblTitle = cell.viewWithTag(102) as! UILabel
            
            lblTitle.text = statusInfoArr[indexPath.row]["title"]!
            lblNumber.text = "\(indexPath.row+1)"
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //tableView.cellForRow(at: indexPath).
        //let progress = Float(indexPath.row)/Float(statusInfoArr.count-1)
        //progressView.setProgress(progress, animated: true)
        //indexSelected = indexPath.row
        //userDetailsTV.reloadData()
    }
}

extension CreateUserViewController: CreateUserCellDelegate{
    func continueAction(_ valueTxt: String) {
        if indexSelected < statusInfoArr.count - 1{
            if !isDriver && indexSelected == 3{
                //Falta crear un loading
                statusInfoArr[indexSelected]["information"]! = valueTxt
                indexSelected += 1
                let progress = Float(indexSelected)/Float(statusInfoArr.count-1)
                progressView.setProgress(progress, animated: true)
                userDetailsTV.reloadData()
                validateMail()
            }else{
                statusInfoArr[indexSelected]["information"]! = valueTxt
                indexSelected += 1
                let progress = Float(indexSelected)/Float(statusInfoArr.count-1)
                progressView.setProgress(progress, animated: true)
                userDetailsTV.reloadData()
            }
        }else{
            createUser()
        }
    }
}

extension CreateUserViewController: CreateUserSubmenuCellDelegate{
    func continueAction(_ firstValue: String, secondValue: String, tirthValue: String) {
        submenuInfoArr[0]["information"]! = firstValue
        submenuInfoArr[1]["information"]! = secondValue
        submenuInfoArr[2]["information"]! = tirthValue
        indexSelected += 1
        let progress = Float(indexSelected)/Float(statusInfoArr.count-1)
        progressView.setProgress(progress, animated: true)
        userDetailsTV.reloadData()
    }
    
    func domainValue(_ domain: String) {
        domainSelected = domain
    }
    
    func actionSelected(_ index: Int) {
        let picker = AlertPickerSelectorViewController(nibName: "AlertPickerSelectorViewController", bundle: nil)
        picker.delegate = self
        picker.modalTransitionStyle = .crossDissolve
        picker.modalPresentationStyle = .overCurrentContext
        picker.tag = index
        if !isDriver{
            switch index {
            case 1:
                var arrTemp = [String]()
                for enterprice in optionsMenu4{
                    arrTemp.append(enterprice.nameClientCompany!)
                }
                picker.arrOptions = arrTemp
                break
            case 2:
                var arrTemp = [String]()
                for company in optionsMenu5{
                    arrTemp.append(company.nrAcount!)
                }
                picker.arrOptions = arrTemp
                break
            default:
                var arrTemp = [String]()
                for cost in optionsMenu6{
                    arrTemp.append(cost.costCenter!)
                }
                picker.arrOptions = arrTemp
            }
        }else{
            switch index {
            case 1:
                var arrTemp = [String]()
                for brand in optionsMenu1{
                    arrTemp.append(brand.nameVehicleBrand!)
                }
                picker.arrOptions = arrTemp
                break
            case 2:
                var arrTemp = [String]()
                for model in optionsMenu2{
                    arrTemp.append(model.nameVehicleModel!)
                }
                picker.arrOptions = arrTemp
                break
            default:
                var arrTemp = [String]()
                for fleet in optionsMenu3{
                    arrTemp.append(fleet.vehiclenType!)
                }
                picker.arrOptions = arrTemp
            }
        }
        self.present(picker, animated: true, completion: nil)
    }
}

extension CreateUserViewController: AlertPickerDelegate{
    func indexSelected(_ index: Int, andTag: Int) {
        if isDriver{
            switch andTag {
            case 1:
                getBrandModel(brand: optionsMenu1[index])
                submenuInfoArr[0]["information"] = optionsMenu1[index].nameVehicleBrand
                break
            case 2:
                getFleetType(model: optionsMenu2[index])
                submenuInfoArr[1]["information"] = optionsMenu2[index].nameVehicleModel
                break
            default:
                fleetSelected = optionsMenu3[index]
                submenuInfoArr[2]["information"] = optionsMenu3[index].vehiclenType
            }
        }else{
            switch andTag {
            case 1:
                getCompaniesFor(enterprice: optionsMenu4[index])
                submenuInfoArr[0]["information"] = optionsMenu4[index].nameClientCompany
                break
            case 2:
                getCostFor(company: optionsMenu5[index])
                submenuInfoArr[1]["information"] = optionsMenu5[index].nrAcount
                break
            default:
                center = optionsMenu6[index]
                submenuInfoArr[2]["information"] = optionsMenu6[index].costCenter
            }
        }
        userDetailsTV.reloadData()
    }
}
