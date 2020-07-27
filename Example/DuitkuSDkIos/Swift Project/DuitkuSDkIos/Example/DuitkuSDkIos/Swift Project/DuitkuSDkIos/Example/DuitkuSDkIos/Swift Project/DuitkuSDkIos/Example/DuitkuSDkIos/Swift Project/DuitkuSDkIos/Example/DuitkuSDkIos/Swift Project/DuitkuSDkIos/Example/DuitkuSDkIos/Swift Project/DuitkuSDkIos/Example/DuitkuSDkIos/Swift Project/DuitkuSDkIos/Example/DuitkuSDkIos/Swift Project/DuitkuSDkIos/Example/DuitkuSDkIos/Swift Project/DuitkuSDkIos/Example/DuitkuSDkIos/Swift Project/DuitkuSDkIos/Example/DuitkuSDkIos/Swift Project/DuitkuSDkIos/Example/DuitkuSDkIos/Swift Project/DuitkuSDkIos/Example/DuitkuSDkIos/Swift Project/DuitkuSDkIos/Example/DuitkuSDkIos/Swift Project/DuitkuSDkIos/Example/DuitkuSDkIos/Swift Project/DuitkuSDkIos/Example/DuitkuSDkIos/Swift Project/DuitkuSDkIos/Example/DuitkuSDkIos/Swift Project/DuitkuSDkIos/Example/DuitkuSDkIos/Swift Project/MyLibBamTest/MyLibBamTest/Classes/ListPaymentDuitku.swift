//
//  ViewController.swift
//  MakeSDK
//
//  Created by Bambang Maulana on 31/03/20.
//  Copyright © 2020 Bambang Maulana. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift



class ListPaymentDuitku: UIViewController  {


    @IBOutlet weak var CardLoading: UIView!
    
    @IBOutlet weak var LoadingDuitku: UIImageView!
    @IBOutlet weak var tablePayment: UITableView!
    
    @IBOutlet weak var CardError: UIView!
    @IBOutlet weak var ImageError: UIImageView!
    
    @IBOutlet weak var textError: UILabel!
    
    private var  listPayment_ = [listPayment]()
    
    private let helper = Helper()
    private var BaseRequest = [BaseRequestDuitku]()
    
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UtilDuitku.isFinished = false
        
        self.navigationController?.hidesBottomBarWhenPushed = true
        
        helper.setLoadingDuitku(Image: LoadingDuitku, view: CardLoading , hidden: false)
        helper.setErrorDuitku(Image: ImageError, view: CardError , hidden: true, textError: self.textError , message: "Server Error")
             
        if Helper.isConnectedToInternet() == false {
                    
           self.view.makeToast("Internet is not connected", duration: 3.0, position: .bottom)
           helper.setLoadingDuitku(Image: LoadingDuitku, view: CardLoading , hidden: true)
           helper.setErrorDuitku(Image: self.ImageError, view: self.CardError , hidden: false, textError: self.textError , message: "Internet is not connected")
           return
        }
              
        
        setStyleTablePayment()
        loadData()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = false
        
        if(Util.redirect && UtilDuitku.isFinished){
            print("ruuunnn deh")
            
            self.navigationController?.popViewController(animated: true)
            //self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)

        }
       
    }
    

      
    private func loadData(){
        
        
        let helper = Helper()
        let parameters = helper.paramListpayment()
        let url = BaseRequestDuitku.request_[0].baseUrlPayment + BaseRequestDuitku.request_[0].listPayment
           
        AF.request(url,method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                        
            switch response.result {
                case .success(let value):
                                        
                    helper.setLoadingDuitku(Image: self.LoadingDuitku, view: self.CardLoading , hidden: true)
                                       
                    let json = JSON(value)
                    
                    for i in 0 ..< json["paymentFee"].count{
                        
                        let paymentMethod = json["paymentFee"][i]["paymentMethod"].string!
                        let paymentName = json["paymentFee"][i]["paymentName"].string!
                        let paymentImage = json["paymentFee"][i]["paymentImage"].string!
                        let totalFee = json["paymentFee"][i]["totalFee"].string!
                        
                        self.listPayment_.append(listPayment(paymentMethod,paymentName,paymentImage,totalFee))
                                                        
                    }
                
                                       
                self.tablePayment.reloadData()

                case .failure(let error):
                
                    helper.setLoadingDuitku(Image: self.LoadingDuitku, view: self.CardLoading , hidden: true)
                    helper.setErrorDuitku(Image: self.ImageError, view: self.CardError , hidden: false , textError: self.textError , message: error.errorDescription!)
     
                    print(error)
            }
            
            
        }
          
        
    }
    
}




extension ListPaymentDuitku: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPayment_.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let list = listPayment_[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellPayment") as! TableViewCellPayment
        
        // insert to cell of list
        cell.setListPayment(list)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            //navigation to second controller
            let vc = storyboard?.instantiateViewController(withIdentifier:"CheckoutDuitkuStoryboard") as!CheckoutDuitku
      //  let vc = storyboard?.instantiateViewController(withIdentifier:"ciobaStoryboard") as!Coba
            // passing data to second controller
            let dataPayment = listPayment_[indexPath.row]
            vc.paymentMethod = dataPayment.paymentMethod
        
            
    
            self.navigationController?.hidesBottomBarWhenPushed = true
            self.navigationController!.setNavigationBarHidden(true, animated: true)
            self.navigationController!.pushViewController(vc, animated: true)



         
       
    }
    
    
    //set style of table
    func setStyleTablePayment() {
              self.tablePayment.dataSource = self
              self.tablePayment.delegate = self
              self.tablePayment.layer.shadowColor = UIColor.gray.cgColor
              self.tablePayment.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
              self.tablePayment.layer.shadowOpacity = 0.7
    }
    
 
    
    
    
}






