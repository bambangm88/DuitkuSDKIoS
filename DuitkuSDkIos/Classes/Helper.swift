//
//  Helper.swift
//  MakeSDK
//
//  Created by Bambang Maulana on 31/03/20.
//  Copyright © 2020 Bambang Maulana. All rights reserved.
//

import UIKit
import SystemConfiguration

class Helper {

    
    let alert = UIAlertController(title: nil, message: "⏳ Memuat..", preferredStyle: .alert)
    
    //Check Connection
    func isConnectedToNetwork() -> Bool {

           var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
           zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
           zeroAddress.sin_family = sa_family_t(AF_INET)

           let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
               $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                   SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
               }
           }

           var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
           if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
               return false
           }

           /* Only Working for WIFI
           let isReachable = flags == .reachable
           let needsConnection = flags == .connectionRequired

           return isReachable && !needsConnection
           */

           // Working for Cellular and WIFI
           let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
           let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
           let ret = (isReachable && !needsConnection)

           return ret

       }
    
    
    //show progress loading
    func showLoadingDialog(show : Bool , controller : UIViewController) {
                 if show {
                     let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
                     loadingIndicator.hidesWhenStopped = true
                    if #available(iOS 13.0, *) {
                       // loadingIndicator.activityIndicatorViewStyle = .medium
                    } else {
                        // Fallback on earlier versions
                    }
                     loadingIndicator.startAnimating()
                     alert.view.addSubview(loadingIndicator)
                     controller.present(alert, animated: true, completion: nil)
                 } else {
                     alert.dismiss(animated: true, completion: nil)
                 }
    }
    
    
    func paramRequest(paymentMethod:String) -> [String : Any] {
         
    let itemDetails = itemsKit.itemDetail.map { $0.convertToDictionary()}
    
                  let parameters =
                    ["paymentAmount":DuitkuKit.paymentAmount,
                                "paymentMethod":paymentMethod,
                                "productDetails":DuitkuKit.productDetails,
                                "email":DuitkuKit.email,
                                "phoneNumber":DuitkuKit.phoneNumber,
                                "additionalParam":DuitkuKit.additionalParam,
                                "merchantUserInfo":DuitkuKit.merchantUserInfo,
                                "customerVaName":DuitkuKit.customerVaName,
                                "callbackUrl":DuitkuKit.callbackUrl,
                                "returnUrl":DuitkuKit.returnUrl,
                                "expiryPeriod":DuitkuKit.expiryPeriod,
                                "itemDetails":itemDetails,
                                "customerDetail":[
                                                     "firstName": DuitkuKit.firstName,
                                                     "lastName": DuitkuKit.lastName,
                                                     "email": DuitkuKit.email,
                                                     "phoneNumber": DuitkuKit.phoneNumber,
                                                     "billingAddress": [
                                                         "firstName": DuitkuKit.firstName,
                                                         "lastName": DuitkuKit.lastName,
                                                         "address": DuitkuKit.alamat,
                                                         "city": DuitkuKit.city,
                                                         "postalCode": DuitkuKit.postalCode,
                                                         "phone": DuitkuKit.phoneNumber,
                                                         "countryCode": DuitkuKit.countryCode
                                                     ],
                                                     "shippingAddress": [
                                                        "firstName": DuitkuKit.firstName,
                                                        "lastName": DuitkuKit.lastName,
                                                        "address": DuitkuKit.alamat,
                                                        "city": DuitkuKit.city,
                                                        "postalCode": DuitkuKit.postalCode,
                                                        "phone": DuitkuKit.phoneNumber,
                                                        "countryCode": DuitkuKit.countryCode
                                                     ]
                                 
                                 ]
           ] as [String : Any]
        

                
        return parameters
    }

    
    func paramListpayment() -> [String : Any]  {
     
       let parameters = ["paymentAmount":DuitkuKit.paymentAmount]
         
         return parameters
     }
    
    
    func paramCheckTrx(reference : String) -> [String : Any]  {
      let parameters = ["reference":reference]
        
        return parameters
    }
    
        
    func setLoadingDuitku(Image:UIImageView, view:UIView , hidden:Bool){
       
        
        Image.loadGif(asset: "loadingduitku")
        
        view.isHidden = hidden
    }
    
    func setErrorDuitku(Image:UIImageView, view:UIView , hidden:Bool , textError : UILabel , message : String){
        
        Image.loadGif(asset: "error")
        view.isHidden = hidden
        textError.text = message
    }
    
    func localizedString(forKey key: String) -> String {
        var result = Bundle.main.localizedString(forKey: key, value: nil, table: nil)

        if result == key {
            result = Bundle.main.localizedString(forKey: key, value: nil, table: "stringRepo")
        }

        return result
    }
    
  


    func showToast(message : String, context: UIViewController) {

        let toastLabel = UILabel(frame: CGRect(x: context.view.frame.size.width/2 - 75, y: context.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        context.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
       
    
       
    
    

    
    





}

    
extension UIImage {
public class func gifX(asset: String) -> UIImage? {
  if let asset = NSDataAsset(name: asset) {
     return UIImage.gif(data: asset.data)
  }
  return nil
}

}
