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
        // Do any additional setup after loading the view.
    }

    @IBAction func calculateBtnAction(_ sender: Any) {
        calculateBtn.isHidden = true
        loanDetailContainerView.isHidden = false
    }
    
    @IBAction func getDetailEMIAction(_ sender: Any) {
        let vc = EMIDetailViewController()
        self.navigationController?.pushViewController(vc, animated: false)
//        self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func applyBtnAction(_ sender: Any) {
    }
    @IBAction func historyBtnAction(_ sender: Any) {
        
        let vc = EMIHistoryViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
}

class EmiTextField: UITextField{
    
    func setTextField(){
        
    }
}
