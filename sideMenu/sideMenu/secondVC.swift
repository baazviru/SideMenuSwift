//
//  secondVC.swift
//  sideMenu
//
//  Created by virendra kumar on 31/08/21.
//

import UIKit

class secondVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backAction(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}
