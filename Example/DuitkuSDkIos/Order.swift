//
//  Order.swift
//  DuitkuSDkIos_Example
//
//  Created by Bambang Maulana on 24/07/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import DuitkuSDkIos


class Order: DuitkuClient{

    @IBOutlet weak var imgOrder: UIImageView!
    public var product : String = ""
    public var detail : String = ""
    
    @IBOutlet weak var cardPayment: UIView!
    @IBOutlet weak var jumlah: UILabel!
    @IBOutlet weak var CardTitle: UIView!
    
    @IBOutlet weak var cardTotal: UIView!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var judul: UILabel!
    @IBOutlet weak var harga: UILabel!
    
    var param = [DuitkuKit]()
    var itemDetails_ = [ItemDetails]()
    
    
    
    override func viewDidLoad() {
               
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Order"
        
        
        Helper.setCardViewShadow(cardItem: self.CardTitle, radius: 1, opacity: 0.1)
        Helper.setCardViewShadow(cardItem: self.cardPayment, radius: 1, opacity: 0.1)
        Helper.setCardViewShadow(cardItem: self.cardTotal, radius: 1, opacity: 0.1)
        
        
        if product == "ipod" {
            var yourImage: UIImage = UIImage(named: "ipod")!
            imgOrder.image = yourImage
            judul.text = "All New Earphone K200"
            harga.text = "10000"
            total.text = "10000"
        }else if product == "sepatu" {
            var yourImage: UIImage = UIImage(named: "sepatu")!
            imgOrder.image = yourImage
            judul.text = "Casual Shoes MA500"
            harga.text = "250000"
            total.text = "250000"
        }
        
    //    imgOrder.image = UIImage(contentsOfFile: "ipod")//
        
    }

    @IBAction func purchase(_ sender: Any) {
        
             var amount = (total.text)!
             var harga_ = (harga.text)!
             var jumlah_ = (jumlah.text)!
             var product = (judul.text)!
           
        
        
        let refreshAlert = UIAlertController(title: "Purchase", message: "Lanjut Pembayaran", preferredStyle: UIAlertControllerStyle.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
     
            self.settingMerchant(amount: amount, product: product, price: harga_, quantity: jumlah_)
            self.startPayment(context: self)
            
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
             
        }))

        present(refreshAlert, animated: true, completion: nil)
        
        
        
        
        
        
        
           
    }
    
    @IBAction func btn_kurang(_ sender: Any) {
        

        
        var jumlahPesan : String = (self.jumlah.text)!
        var harga: String = (self.harga.text)!
        if Int(jumlahPesan)!  > 1 {
            
          var total_jumlah_pesanan : Int =  Int(jumlahPesan)! - 1
          self.jumlah.text = String(total_jumlah_pesanan)
          var totalharga :Int =  Int(harga)! * total_jumlah_pesanan
          self.total.text = String(totalharga)
            
        }else{
           Helper.showToast(message: "Minimal 1 Pembelanjaan", context: self)
        }
        
        
        
    }
    
    @IBAction func btn_tambah(_ sender: Any) {
        var jumlahPesan : String = (self.jumlah.text)!
        var harga: String = (self.harga.text)!
        if Int(jumlahPesan)!  < 10 {
              var total_jumlah_pesanan =  Int(jumlahPesan)! + 1
              self.jumlah.text = String(total_jumlah_pesanan)
              var totalharga :Int = Int(harga)! * total_jumlah_pesanan
              self.total.text = String(totalharga)
        }else{
              Helper.showToast(message: "Stok Kurang dari 10", context: self)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
          runPayment(context: self)
        
          self.navigationController?.isNavigationBarHidden = false
          self.navigationItem.title = "Order"
          
    }
    
    
    override func onSuccess_(status: String, reference: String, amount: String, code: String, merchantOrderId: String) {
        print("tes response" + status)
        Helper.showToast(message: status, context: self)
        clearSdkTask()
        
    }
    
    override func onPending_(status: String, reference: String, amount: String, code: String, merchantOrderId: String) {
       print("tes response" + status)
        Helper.showToast(message: status, context: self)
        clearSdkTask()
    }
    
    override func onCanceled_(status: String, reference: String, amount: String, code: String, merchantOrderId: String) {
        print("tes response" + status)
        Helper.showToast(message: status, context: self)
        clearSdkTask()
    }
    
    
    
    
    
    func settingMerchant(amount : String, product : String , price : String , quantity : String){
                
        Util.merchantNotification = true
        Util.redirect = false
        
        
        DuitkuKit.data(
              paymentAmount: amount
             ,productDetails: product
             ,email: "bambangm88@gmail.com"
             ,phoneNumber: "08979713464"
             ,additionalParam: ""
             ,merchantUserInfo: "Bambang"
             ,customerVaName: "Bambang Maulana"
             ,callbackUrl: "http://bambangm.com/callback"
             ,returnUrl: "http://bambangm.com/return"
             ,expiryPeriod: "60"
             ,firstName: "bambang"
             ,lastName: "maulana"
             ,alamat: "cigugur"
             ,city: "kuningan"
             ,postalCode: "45552"
             ,countryCode: "ID"
        )
        
        //star loop here
        ItemDetails.data(name: product, price: Int(price)!, quantity: Int(quantity)!) //optional
        //finish start loop
         
         // base url
        BaseRequestDuitku.data(
              baseUrlPayment: "http://182.23.85.8/sdkserver/api/sandbox/request/"
             ,requestTransaction: "transaksi"
             ,checkTransaction: "checktransaksi"
             ,listPayment: "listPayment"
         )
               

         //insert to object
         itemsKit.duitku = param
         itemsKit.itemDetail = itemDetails_
         
        
    }
    
    
    
    
    
    
}


