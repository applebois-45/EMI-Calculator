//
//  ViewController.swift
//  EMI Calculator
//
//  Created by Vineet Singh on 08/04/20.
//  Copyright © 2020 Indialends. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Hello world")
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        let vc = EMIInitialFormViewController()
        self.navigationController?.pushViewController(vc, animated: false)
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: false, completion: nil)
        
    }
}

