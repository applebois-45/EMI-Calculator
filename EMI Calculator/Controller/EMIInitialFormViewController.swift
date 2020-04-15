//
//  EMIInitialFormViewController.swift
//  Indialends
//
//  Created by Raju Kumar on 08/04/20.
//  Copyright © 2020 IndiaLends. All rights reserved.
//

import UIKit
import CoreData

class EMIInitialFormViewController: UIViewController {

    @IBOutlet weak var requiredAmountLbl: UILabel!
    @IBOutlet weak var requiredAmountTxtField: TextField!
    
    @IBOutlet weak var tenureLbl: UILabel!
    @IBOutlet weak var tenureYearsTxtField: UITextField!
    @IBOutlet weak var tenureMonthsTxtField: UITextField!

    
    @IBOutlet weak var roiLbl: UILabel!
    @IBOutlet weak var roiTxtField: UITextField!
    
    @IBOutlet weak var calculateBtn: UIButton!
    @IBOutlet weak var loanDetailContainerView: UIView!
    @IBOutlet weak var loanDetailView: UIView!
    
    @IBOutlet weak var monthlyEmiLbl: UILabel!
    
    @IBOutlet weak var totalPrincipleLbl: UILabel!
    @IBOutlet weak var totalPrincipleValueLbl: UILabel!
    @IBOutlet weak var totalInterestLbl: UILabel!
    @IBOutlet weak var totalInterestValueLbl: UILabel!
    @IBOutlet weak var totalPayableLbl: UILabel!
    @IBOutlet weak var totalPayableValueLbl: UILabel!
    @IBOutlet weak var applyNowBtn: UIButton!
    @IBOutlet weak var reloadBtn: UIButton!
    @IBOutlet weak var yearsPlaceholderLbl: UILabel!
    
    @IBOutlet weak var tenureYearsView: UIView!
    @IBOutlet weak var tenureMonthsView: UIView!
    @IBOutlet weak var roiView: UIView!
    
    
    var selectedTextField = UITextField()
    var amount = 0
    var years = 0
    var months = 0
    var roi:Float = 0.0
    var emi = 0.0
    var id = 0
    var selectedTxtField = UITextField()
    var isHistory = false
    override func viewDidLoad() {
        super.viewDidLoad()
        loanDetailContainerView.isHidden = true
        loanDetailView.layer.cornerRadius = 4
        loanDetailView.clipsToBounds = true
        loanDetailView.layer.borderColor = UIColor(red: 218/255, green: 223/255, blue: 234/255, alpha: 1).cgColor//UIColor(displayP3Red: 85/255, green: 87/255, blue: 92/255, alpha: 1).cgColor
        loanDetailView.layer.borderWidth = 1
        
        applyNowBtn.layer.cornerRadius = applyNowBtn.layer.frame.height/2
        applyNowBtn.clipsToBounds = true
        
        calculateBtn.layer.cornerRadius = calculateBtn.layer.frame.height/2
        calculateBtn.clipsToBounds = true
        
        tenureYearsTxtField.delegate = self
        tenureMonthsTxtField.delegate = self
        roiTxtField.delegate = self
        requiredAmountTxtField.delegate = self
        
        requiredAmountTxtField.font = UIFont(name:"OpenSans-SemiBold",size:14)
        requiredAmountTxtField.textColor = UIColor(red: 60/255, green: 55/255, blue: 77/255, alpha: 1)
        
        tenureYearsTxtField.font = UIFont(name:"OpenSans-SemiBold",size:14)
        tenureYearsTxtField.textColor = UIColor(red: 60/255, green: 55/255, blue: 77/255, alpha: 1)
        
        tenureMonthsTxtField.font = UIFont(name:"OpenSans-SemiBold",size:14)
        tenureMonthsTxtField.textColor = UIColor(red: 60/255, green: 55/255, blue: 77/255, alpha: 1)
        
        roiTxtField.font = UIFont(name:"OpenSans-SemiBold",size:14)
        roiTxtField.textColor = UIColor(red: 60/255, green: 55/255, blue: 77/255, alpha: 1)
        // Do any additional setup after loading the view.
        setupTextField()
         requiredAmountTxtField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        tenureMonthsTxtField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        tenureYearsTxtField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        roiTxtField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        isHistory = false
        reloadBtn.setImage(UIImage(named: "reloadField"), for: .normal)
        checkforEmpty()
        retrieveData()
    }
    func setupTextField(){
        requiredAmountTxtField.layer.cornerRadius = 4
        requiredAmountTxtField.clipsToBounds = true
        requiredAmountTxtField.layer.borderColor = UIColor(red: 218/255, green: 223/255, blue: 234/255, alpha: 1).cgColor
        requiredAmountTxtField.layer.borderWidth = 1
        
        tenureYearsView.layer.cornerRadius = 4
        tenureYearsView.clipsToBounds = true
        tenureYearsView.layer.borderColor = UIColor(red: 218/255, green: 223/255, blue: 234/255, alpha: 1).cgColor
        tenureYearsView.layer.borderWidth = 1
        tenureYearsTxtField.leftViewMode = .never
        tenureYearsTxtField.rightViewMode = .never
        
        tenureMonthsView.layer.cornerRadius = 4
        tenureMonthsView.clipsToBounds = true
        tenureMonthsView.layer.borderColor = UIColor(red: 218/255, green: 223/255, blue: 234/255, alpha: 1).cgColor
        tenureMonthsView.layer.borderWidth = 1
        
        roiView.layer.cornerRadius = 4
        roiView.clipsToBounds = true
        roiView.layer.borderColor = UIColor(red: 218/255, green: 223/255, blue: 234/255, alpha: 1).cgColor
        roiView.layer.borderWidth = 1
        
        requiredAmountLbl.textColor = UIColor(red: 80/255, green: 89/255, blue: 123/255, alpha: 1)
        
        tenureLbl.textColor = UIColor(red: 80/255, green: 89/255, blue: 123/255, alpha: 1)
        
        roiLbl.textColor = UIColor(red: 80/255, green: 89/255, blue: 123/255, alpha: 1)

    }

    @IBAction func calculateBtnAction(_ sender: Any) {
         selectedTxtField.resignFirstResponder()
        calculateBtn.isHidden = true
        loanDetailContainerView.isHidden = false
        updatelblVal()
        createData()
        reloadBtn.setImage(UIImage(named: "reloadField"), for: .normal)
       isHistory = false

    }
    
    @IBAction func getDetailEMIAction(_ sender: Any) {
        let vc = EMIDetailViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func applyBtnAction(_ sender: Any) {
        selectedTxtField.resignFirstResponder()

    }
    @IBAction func historyBtnAction(_ sender: Any) {
        
        let vc = EMIHistoryViewController()
        self.navigationController?.pushViewController(vc, animated: false)
        selectedTxtField.resignFirstResponder()

    }
    
    @IBAction func reloadTextfield(_ sender: Any) {
        if isHistory {
            let vc = EMIHistoryViewController()
            self.navigationController?.pushViewController(vc, animated: false)
            selectedTxtField.resignFirstResponder()
        }else{
            calculateBtn.isHidden = false
            loanDetailContainerView.isHidden = true
            selectedTxtField.resignFirstResponder()
        }

    }
    
    @IBAction func yearsActionBtn(_ sender: Any) {
        tenureYearsTxtField.becomeFirstResponder()
    }
    
    @IBAction func monthsActionBtn(_ sender: Any) {
        tenureMonthsTxtField.becomeFirstResponder()
    }
    @IBAction func roiActionBtn(_ sender: Any) {
        roiTxtField.becomeFirstResponder()
    }
    @IBAction func backButton(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: false)
        selectedTxtField.resignFirstResponder()
        NotificationCenter.default.removeObserver(self);
        
    }
    
    

    func checkforEmpty(){
        
        if !requiredAmountTxtField.text!.isEmpty{
            if !tenureMonthsTxtField.text!.isEmpty || !tenureMonthsTxtField.text!.isEmpty{
                if !roiTxtField.text!.isEmpty{
                    calculateBtn.backgroundColor = UIColor(red: 28/255, green: 175/255, blue: 253/255, alpha: 1)
                    calculateBtn.isEnabled = true
                    return
                }
        
            }
        }
        calculateBtn.isEnabled = false
        calculateBtn.backgroundColor = UIColor(red: 218/255, green: 223/255, blue: 234/255, alpha: 1)
    }
    // MARK:  Textfield delegate
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if textField == requiredAmountTxtField {

            requiredAmountTxtField.text = moneyFormatter(text:  requiredAmountTxtField.text ?? "")
//             textInAmount(string: converMoneyToString(str:  ILDefinesSwift.properHandlingofOptional(param: textFieldAmount.text)))
        }
        checkforEmpty()
    }
}
extension EMIInitialFormViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
//    func textFieldDidEndEditing(_ textField: UITextField) {
//         checkforEmpty()
//    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        selectedTxtField = textField
        setupTextField()
        switch textField{
        case requiredAmountTxtField:
            requiredAmountTxtField.layer.borderColor = UIColor(red: 28/255, green: 175/255, blue: 253/255, alpha: 1).cgColor
            requiredAmountLbl.textColor = UIColor(red: 28/255, green: 175/255, blue: 253/255, alpha: 1)
            
        case tenureMonthsTxtField:
        tenureMonthsView.layer.borderColor = UIColor(red: 28/255, green: 175/255, blue: 253/255, alpha: 1).cgColor
        tenureLbl.textColor = UIColor(red: 28/255, green: 175/255, blue: 253/255, alpha: 1)
            
        case tenureYearsTxtField:
        tenureYearsView.layer.borderColor = UIColor(red: 28/255, green: 175/255, blue: 253/255, alpha: 1).cgColor
        tenureLbl.textColor = UIColor(red: 28/255, green: 175/255, blue: 253/255, alpha: 1)
            
        case roiTxtField:
        roiView.layer.borderColor = UIColor(red: 28/255, green: 175/255, blue: 253/255, alpha: 1).cgColor
        roiLbl.textColor = UIColor(red: 28/255, green: 175/255, blue: 253/255, alpha: 1)
        
        default:
            setupTextField()
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tenureYearsTxtField || textField == tenureMonthsTxtField{
        let maxLength = 2
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        tenureYearsTxtField.updateConstraints()
//        checkforEmpty()
        return newString.length <= maxLength
        }else{
//            checkforEmpty()
            return true
        }
    }

}

extension EMIInitialFormViewController{
    func converMoneyToString(str : String) -> String {
        
        let strWithoutRuppes = str.replacingOccurrences(of: "₹ ", with: "")
        return strWithoutRuppes.replacingOccurrences(of: ",", with: "")

    }
    
    // MARK: MONEY FORMATTER
    func moneyFormatter(text : String) -> String {
        
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_IN")
        formatter.numberStyle = .decimal
        let txt = text.replacingOccurrences(of: "₹ ", with: "")
        if let number = Int(txt.replacingOccurrences(of: ",", with: "")) {
            
            if let formattedTipAmount = formatter.string(from: number as NSNumber) {
                return "₹ " + formattedTipAmount
            }
            
        }
        
        return ""
    }
    
    func updatelblVal() {
        guard let amount = Int(converMoneyToString(str: requiredAmountTxtField.text ?? "")) else {return}
        self.amount = amount
        guard let roi = Float(roiTxtField.text ?? "") else{return}
        let tmonths = totalMonth(years: tenureYearsTxtField.text, months: tenureMonthsTxtField.text)
        let emi = emiCalculator(p: amount, r: roi, n: tmonths)
        self.emi = emi
        self.roi = roi
           monthlyEmiLbl.text = moneyFormatter(text: "\(Int(emi))")
        
        let totalEmi = totalAmntPyable(principle: emi, tenureMonth: tmonths)
           
        let totInt = totalEmi - Double(amount)
       
           totalInterestValueLbl.text = moneyFormatter(text: "\(Int(totInt))")
           
           totalPrincipleValueLbl.text = moneyFormatter(text: "\(amount)")
           
           totalPayableValueLbl.text = moneyFormatter(text: "\(amount + Int(totInt))")
           
       }
    
    func totalMonth(years:String?,months:String?) -> Int{
        var totalMonths = 0
        if let yrs = Int(years ?? "0") {
            self.years = yrs
            totalMonths = (yrs*12)
        }
        if let mnts = Int(months ?? "0"){
        //                print(yrs,mnts)
            self.months = mnts
            totalMonths = totalMonths + mnts
        }
        return totalMonths
    }
    func totalAmntPyable(principle:Double,tenureMonth:Int) -> Double {
           
            return principle*Double.init(tenureMonth)
          
       }
    
       func emiCalculator(p:Int,r:Float,n:Int) -> Double {
           
           if (r == 0 || n == 0)
           {
            //   //ILUtility.alertView(self, "Fill All Data")
               return 0.0;
           }
           
           var r1 : Float = r/(12*100);
           
           r1 = r1+1;
           
           let p1 : Float = Float.init(p)
           
               return  Double((p1 * ((r1-1) * powf(r1,Float(n))))/((powf(r1,Float(n)))-1));
           
       }

}
//for coreData
extension EMIInitialFormViewController{
    
    func createData(){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let emiHistoryEntity = NSEntityDescription.entity(forEntityName: "EmiHistory", in: managedContext)!
        
//        for i in 1...5 {
            
            let emiHistory = NSManagedObject(entity: emiHistoryEntity, insertInto: managedContext)
            emiHistory.setValue("\(self.emi)", forKeyPath: "emi")
            emiHistory.setValue("\(self.amount)", forKey: "loanAmount")
            emiHistory.setValue("\(self.roi)", forKey: "roi")
            emiHistory.setValue("\(self.months)", forKeyPath: "tenureMonth")
            emiHistory.setValue("\(self.years)", forKey: "tenureYear")
        emiHistory.setValue(Int64(self.id+1), forKey: "id")
//        }
        
        do {
            try managedContext.save()
           retrieveData()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func retrieveData() {
            
            //As we know that container is set up in the AppDelegates so we need to refer that container.
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
            //We need to create a context from this container
            let managedContext = appDelegate.persistentContainer.viewContext
            
            //Prepare the request of type NSFetchRequest  for the entity
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EmiHistory")
            
    //        fetchRequest.fetchLimit = 1
    //        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur")
    //        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
    //
            do {
                let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
                for index in 0..<result.count{
                    print(result[index])
                    print(result[index].value(forKey: "id") as! Int64)
                    if index == result.count-1{
                        print(result[index].value(forKey: "id") as! Int64)
                        self.id = Int(result[index].value(forKey: "id") as! Int64)
                        isHistory = true
                        reloadBtn.setImage(UIImage(named: "history.png"), for: .normal)
                    }
                }
                
            } catch {
                
                print("Failed")
            }
        }

}

class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

 
