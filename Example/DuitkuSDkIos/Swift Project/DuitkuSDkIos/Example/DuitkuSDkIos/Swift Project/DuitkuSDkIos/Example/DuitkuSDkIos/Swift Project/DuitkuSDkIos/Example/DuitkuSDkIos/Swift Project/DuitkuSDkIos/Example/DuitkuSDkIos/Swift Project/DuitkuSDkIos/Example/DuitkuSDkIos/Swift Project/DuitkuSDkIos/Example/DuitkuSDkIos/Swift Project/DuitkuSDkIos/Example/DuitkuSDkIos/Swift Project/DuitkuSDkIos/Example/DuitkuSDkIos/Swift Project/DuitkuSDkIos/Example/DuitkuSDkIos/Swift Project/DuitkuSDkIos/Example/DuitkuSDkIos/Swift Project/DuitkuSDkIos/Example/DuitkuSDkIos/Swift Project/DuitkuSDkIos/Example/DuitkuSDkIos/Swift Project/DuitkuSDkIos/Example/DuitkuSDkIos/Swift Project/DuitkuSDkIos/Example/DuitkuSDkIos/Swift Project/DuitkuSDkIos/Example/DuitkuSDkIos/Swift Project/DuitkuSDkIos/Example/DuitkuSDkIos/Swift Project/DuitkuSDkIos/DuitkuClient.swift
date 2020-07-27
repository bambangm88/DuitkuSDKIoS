//
//  tes.swift
//  MakeSDK
//
//  Created by Bambang Maulana on 07/07/20.
//  Copyright © 2020 Bambang Maulana. All rights reserved.
//

import Foundation
import UIKit

class DuitkuClient: UIViewController {
    
       
    var code : String = ""
    var status : String  = "";
    var amount : String  = "";
    var reference  : String = "";
    var topUpNotif : String  = "";

    func onSuccess_(status : String , reference : String , amount: String , code : String  ){
       
    }
    func onPending_(status : String , reference : String , amount: String , code : String  ){
       
    }
    func onCanceled_(status : String , reference : String , amount: String , code : String  ){
       
    }
    
    
    func runPayment (context : UIViewController){
        
        let helper = Helper()
        
        if(self.code == helper.localizedString(forKey: "success")){
            onSuccess_(status: status, reference: reference, amount: amount, code: code)
        } else if(self.code == helper.localizedString(forKey: "pending")){
            onPending_(status: status, reference: reference, amount: amount, code: code)
        } else if(self.code == helper.localizedString(forKey: "canceled")){
            onCanceled_(status: status, reference: reference, amount: amount, code: code)
        } else if(self.code == helper.localizedString(forKey: "canceled")){
            onCanceled_(status: status, reference: reference, amount: amount, code: code)
        } else{
            
        }
        
    }
    
    func startPayment(context : UIViewController) {

                

    }
    
    
    

}
