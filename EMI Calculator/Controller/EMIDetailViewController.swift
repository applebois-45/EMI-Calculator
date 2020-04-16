//
//  EMIDetailViewController.swift
//  EMI Calculator
//
//  Created by Raju Kumar on 11/04/20.
//  Copyright © 2020 Indialends. All rights reserved.
//

import UIKit

class EMIDetailViewController: UIViewController {

    @IBOutlet weak var itemList: UITableView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var applyBtn: UIButton!
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    var emi:Float = 0
    var tenureYrs = 0
    var tenureMonths = 0
    var principleamount:Float = 0.0
    var roi:Float = 0.0
    
    var paidPrincipal:Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        applyBtn.layer.cornerRadius = applyBtn.layer.frame.height/2
        applyBtn.clipsToBounds = true
        
        itemList.register(UINib(nibName: "EMIDetailHeaderCell", bundle: nil), forCellReuseIdentifier: "EMIDetailHeaderCell")
        itemList.register(UINib(nibName: "EMIDetailCell", bundle: nil), forCellReuseIdentifier: "EMIDetailCell")
        
        itemList.layer.cornerRadius = 4
        itemList.layer.borderWidth = 1
        itemList.layer.borderColor = UIColor(red: 218/255, green: 223/255, blue: 234/255, alpha: 1).cgColor
        itemList.clipsToBounds = true
        itemList.delegate = self
        itemList.dataSource = self
        itemList.isScrollEnabled = false
        
        
    }


    @IBAction func savePdf(_ sender: Any) {
        
    }
    @IBAction func backButton(_ sender: Any) {
        self.popVC()
//        self.navigationController?.popViewController(animated: false)
        NotificationCenter.default.removeObserver(self);
        
    }
    

}
extension EMIDetailViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableviewHeight.constant = CGFloat(48 * (((tenureYrs*12 ) + tenureMonths) + 1))
        self.view.layoutIfNeeded()
        return ((tenureYrs*12 ) + tenureMonths)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EMIDetailCell") as? EMIDetailCell else {return UITableViewCell()}
        cell.monthLbl.text = "\(indexPath.row + 1)"
        getMothlyEmiDetail(cell: cell)
//        if indexPath.row == ((tenureYrs*12 ) + tenureMonths) - 1 {
//            cell.balanceLbl.text = "0.00"
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EMIDetailHeaderCell") as? EMIDetailHeaderCell
        return cell
    }
    
    func getMothlyEmiDetail(cell:EMIDetailCell){
        let interest:Float =  ((roi/100)/12) * principleamount
        paidPrincipal = emi - interest
        principleamount = principleamount - paidPrincipal
        
        cell.interestLbl.text = String(format: "%.2f", interest)//"\(interest)"
        cell.principalLbl.text = String(format: "%.2f", paidPrincipal)//"\(paidPrincipal)"
        cell.balanceLbl.text = String(format: "%.2f", principleamount)//"\(principleamount)"


    }
}
