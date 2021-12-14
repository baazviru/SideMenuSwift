//
//  FirstVC.swift
//  sideMenu
//
//  Created by virendra kumar on 31/08/21.
//

import UIKit

class FirstVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func openMenu(_ sender:UIButton){
          TabBarVC.shared?.openSideMenu()
       
    }


}
