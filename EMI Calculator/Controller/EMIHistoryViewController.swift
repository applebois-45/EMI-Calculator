//
//  EMIHistoryViewController.swift
//  EMI Calculator
//
//  Created by Raju Kumar on 12/04/20.
//  Copyright © 2020 Indialends. All rights reserved.
//

import UIKit
import CoreData
class EMIHistoryViewController: UIViewController {

   @IBOutlet weak var itemList: UITableView!
   @IBOutlet weak var titleLbl: UILabel!
   @IBOutlet weak var applyBtn: UIButton!
   @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
   var id = 0
    var callBck : ((EMIHistoryModel) -> (Void))?
    var arrData = [EMIHistoryModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        applyBtn.layer.cornerRadius = applyBtn.layer.frame.height/2
        applyBtn.clipsToBounds = true
        
        itemList.register(UINib(nibName: "HistoryCell", bundle: nil), forCellReuseIdentifier: "HistoryCell")
        
//        itemList.layer.cornerRadius = 4
//        itemList.layer.borderWidth = 1
//        itemList.layer.borderColor = UIColor(red: 218/255, green: 223/255, blue: 234/255, alpha: 1).cgColor
        itemList.clipsToBounds = true
        itemList.delegate = self
        itemList.dataSource = self
        itemList.isScrollEnabled = false
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        arrData.removeAll()
        retrieveData()
    }
    @IBAction func deleteBtnAction(_ sender: Any) {
            let vc = EMIDeleteHistoryController()
        pushVC(vc)
//        self.navigationController?.pushViewController(vc, animated: false)
    }

    @IBAction func backButton(_ sender: Any) {
        
        self.popVC()
//        self.navigationController?.popViewController(animated: false)
        NotificationCenter.default.removeObserver(self);
        
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
}

extension EMIHistoryViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableviewHeight.constant = CGFloat(80 * (arrData.count ))
        self.view.layoutIfNeeded()
        return arrData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") as? HistoryCell else {return UITableViewCell()}
//        cell.monthLbl.text = "\(indexPath.row + 1)"
        let emiDecimalValue = Float( arrData[indexPath.row].emi ?? "0")
        cell.emiLbl.text = "EMI: " + String(format: "%.2f", emiDecimalValue!)
        let moneyStr = moneyFormatter(text: arrData[indexPath.row].loanAmount ?? "")
        var duration = 0.0
        if let yrs = Int(arrData[indexPath.row].tenureYear ?? "0") {
            duration = Double(yrs)
        }
        if let mnts = Int(arrData[indexPath.row].tenureMonth ?? "0"){
            let mnthInYrs = Double(mnts)/12
            duration = duration + mnthInYrs
        }
        let roundOffStr = String(format: "%.1f", duration)
        let emiDetail = moneyStr + " @ " + (arrData[indexPath.row].roi ?? "") + "% for "
        cell.emiDetailLbl.text = emiDetail  + " \(roundOffStr) years"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.callBck?(arrData[indexPath.row])
    }
    
}
 
//for coreData
extension EMIHistoryViewController{
    
    
    func retrieveData() {
            
            //As we know that container is set up in the AppDelegates so we need to refer that container.
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
            //We need to create a context from this container
            let managedContext = appDelegate.persistentContainer.viewContext
            
            //Prepare the request of type NSFetchRequest  for the entity
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EmiHistory")
            
            do {
                let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
                for index in 0..<result.count{
                    print(result[index])
                    print(result[index].value(forKey: "id") as! Int64)
                    
                    let emiHistoryModel = EMIHistoryModel()
                    emiHistoryModel.id = result[index].value(forKey: "id") as? Int64
                    emiHistoryModel.emi = result[index].value(forKey: "emi") as? String
                    emiHistoryModel.loanAmount = result[index].value(forKey: "loanAmount") as? String
                    emiHistoryModel.roi = result[index].value(forKey: "roi") as? String
                    emiHistoryModel.tenureMonth = result[index].value(forKey: "tenureMonth") as? String
                    emiHistoryModel.tenureYear = result[index].value(forKey: "tenureYear") as? String
                    self.arrData.append(emiHistoryModel)
                    if index == result.count-1{
                        print(result[index].value(forKey: "id") as! Int64)
                        self.id = Int(result[index].value(forKey: "id") as! Int64)
                    }
                }
                self.itemList.reloadData()
                
            } catch {
                
                print("Failed")
            }
        }

}

