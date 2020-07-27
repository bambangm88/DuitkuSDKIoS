//
//  ViewController.swift
//  DuitkuSDkIos
//
//  Created by bambangm88 on 07/20/2020.
//  Copyright (c) 2020 bambangm88. All rights reserved.
//

import UIKit
import DuitkuSDkIos

class ViewController: UIViewController {
    
    @IBOutlet weak var cardIpod: UIView!
    
    @IBOutlet weak var Corousel: UIView!
    @IBOutlet weak var CardSepatu: UIView!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.isNavigationBarHidden = true
        
        Helper.setCardViewShadow(cardItem: self.cardIpod, radius: 1, opacity: 0.1)
        Helper.setCardViewShadow(cardItem: self.Corousel, radius: 1, opacity: 0.1)
        Helper.setCardViewShadow(cardItem: self.CardSepatu, radius: 1, opacity: 0.1)
        
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSepatu(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier:"order") as!Order
        vc.product = "sepatu"
        vc.detail = "All New Sepatu Casual"
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    @IBAction func btnIpod(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier:"order") as!Order
        vc.product = "ipod"
        vc.detail = "All New Sepatu Casual"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

       

}

