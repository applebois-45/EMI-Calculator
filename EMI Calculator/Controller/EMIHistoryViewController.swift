//
//  EMIHistoryViewController.swift
//  EMI Calculator
//
//  Created by Raju Kumar on 12/04/20.
//  Copyright © 2020 Indialends. All rights reserved.
//

import UIKit

class EMIHistoryViewController: UIViewController {

   @IBOutlet weak var itemList: UITableView!
   @IBOutlet weak var titleLbl: UILabel!
   @IBOutlet weak var applyBtn: UIButton!
   @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    
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
    @IBAction func deleteBtnAction(_ sender: Any) {
            
    }


}

extension EMIHistoryViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableviewHeight.constant = 80 * 5
        self.view.layoutIfNeeded()
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") as? HistoryCell else {return UITableViewCell()}
//        cell.monthLbl.text = "\(indexPath.row + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
