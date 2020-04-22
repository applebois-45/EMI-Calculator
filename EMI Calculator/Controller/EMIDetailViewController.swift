//
//  EMIDetailViewController.swift
//  EMI Calculator
//
//  Created by Raju Kumar on 11/04/20.
//  Copyright © 2020 Indialends. All rights reserved.
//

import UIKit
import PDFKit

class EMIDetailViewController: UIViewController {

    @IBOutlet weak var itemList: UITableView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var applyBtn: UIButton!
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
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
//    override func viewWillAppear(_ animated: Bool) {
//        scrollView.scrollTo(direction: .Bottom)
//    }
    override func viewDidAppear(_ animated: Bool) {
        scrollView.scrollTo(direction: .Bottom)
    }

    @IBAction func savePdf(_ sender: Any) {
        let pdfPath = itemList.exportAsPdfFromView()
        print(pdfPath)
//        view.addSubview(pdfView)
        let pdfURl = URL(fileURLWithPath: pdfPath)
        guard let document = PDFDocument(url: pdfURl) else{return}
//            pdfView.document = document
//        }
        
               
        // Create the Array which includes the files you want to share
       var filesToShare = [Any]()
       
               // Add the path of the file to the Array
        filesToShare.append(pdfURl)
       
               // Make the activityViewContoller which shows the share-view
       let activityViewController = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)
       
               // Show the share-view
       self.present(activityViewController, animated: true, completion: nil)
        
//        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
//            self.pdfView.removeFromSuperview()
//            self.dismiss(animated: true, completion: nil)
//        }
        
    }
    @IBAction func backButton(_ sender: Any) {
        self.popVC()
//        self.navigationController?.popViewController(animated: false)
        NotificationCenter.default.removeObserver(self);
        
    }
    
    var pdfView = PDFView()

    override func viewDidLayoutSubviews() {
        pdfView.frame = view.frame
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

extension UITableView{
    
    func exportAsPdfFromView() -> String {
        
        let pdfPageFrame = self.bounds
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageFrame, nil)
        UIGraphicsBeginPDFPageWithInfo(pdfPageFrame, nil)
        guard let pdfContext = UIGraphicsGetCurrentContext() else { return "" }
        self.layer.render(in: pdfContext)
        UIGraphicsEndPDFContext()
        return self.saveViewPdf(data: pdfData)
        
    }
    // Save pdf file in document directory
    func saveViewPdf(data: NSMutableData) -> String {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDirectoryPath = paths[0]
        let pdfPath = docDirectoryPath.appendingPathComponent("emiDetails.pdf")
        if data.write(to: pdfPath, atomically: true) {
            return pdfPath.path
        } else {
            return ""
        }
    }
}
