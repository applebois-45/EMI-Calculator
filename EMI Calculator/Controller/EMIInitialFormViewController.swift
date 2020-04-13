//
//  EMIInitialFormViewController.swift
//  Indialends
//
//  Created by Raju Kumar on 08/04/20.
//  Copyright © 2020 IndiaLends. All rights reserved.
//

import UIKit

class EMIInitialFormViewController: UIViewController {

    @IBOutlet weak var requiredAmountLbl: UILabel!
    @IBOutlet weak var requiredAmountTxtField: UITextField!
    
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
    @IBOutlet weak var reloadBtn: NSLayoutConstraint!
    @IBOutlet weak var yearsPlaceholderLbl: UILabel!
    
    @IBOutlet weak var tenureYearsView: UIView!
    @IBOutlet weak var tenureMonthsView: UIView!
    @IBOutlet weak var roiView: UIView!
    
    
    var selectedTextField = UITextField()
    var years = 0
    var months = 0
    var roi = 0
    
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

//        requiredAmountLbl.textColor = UIColor(red: 80/255, green: 89/255, blue: 123/255, alpha: 1)

        
        
        
        

    }

    @IBAction func calculateBtnAction(_ sender: Any) {
        calculateBtn.isHidden = true
        loanDetailContainerView.isHidden = false
    }
    
    @IBAction func getDetailEMIAction(_ sender: Any) {
        let vc = EMIDetailViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func applyBtnAction(_ sender: Any) {
    }
    @IBAction func historyBtnAction(_ sender: Any) {
        
        let vc = EMIHistoryViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func reloadTextfield(_ sender: Any) {
        
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

}
extension EMIInitialFormViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
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
        
        return newString.length <= maxLength
        }else{
            return true
        }
    }

}


