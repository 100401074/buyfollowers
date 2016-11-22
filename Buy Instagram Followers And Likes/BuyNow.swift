//
//  BuyNow.swift
//  Buy Instagram Followers And Likes
//
//  Created by Santhej Kallada on 16/10/16.
//  Copyright © 2016 Kallada. All rights reserved.
//

import UIKit
import AlamofireImage
import StoreKit
import SwiftyStoreKit


class BuyNow: UIViewController {
    
    var quantity : String = ""
    var productName : String = ""
    var index : Int? = nil

    @IBOutlet var proceedBtn: UIButton!
    @IBOutlet var userImage: UIImageView!
    
    @IBOutlet var buynow_btn: UIButton!
    @IBOutlet var username: UITextField!
    @IBOutlet var email: UITextField!
    
    let productIdentifiers: [String] = ["1000InstagramFollowers","2000InstagramFollowers","3000InstagramFollowers","5000InstagramFollowers","7000InstagramFollowers","10000InstagramFollowers"]
    
    @IBAction func proceedBtnClicked(_ sender: AnyObject) {
        //Retrieve Product Info
        SwiftyStoreKit.purchaseProduct(productIdentifiers[index!]) { result in
            switch result {
            case .success(let productId):
                print("Purchase Success: \(productId)")
                self.verifyReceipt()
                
                
            case .error(let error):
                print("Purchase Failed: \(error)")
            }
        }
        
        
        
        
        
        
        
        
    }//proceedbtn
    
    

    
    func verifyReceipt()
    {
        SwiftyStoreKit.verifyReceipt(password: "your-shared-secret") { result in
            switch result {
            case .success(let receipt):
                // Verify the purchase of Consumable or NonConsumable
                
                let purchaseResult = SwiftyStoreKit.verifyPurchase(
                    productId: self.productIdentifiers[self.index!],
                    inReceipt: receipt
                )
                
            
                
                switch purchaseResult {
                case .purchased(let expiresDate):
                    print("Product is purchased.")
                    self.performSegue(withIdentifier: "gotoOrderConfirmed", sender: self)
                case .notPurchased:
                    print("The user has never purchased this product")
                }
            case .error(let error):
                print("Receipt verification failed: \(error)")
                
                
            }
        }
    }//verifyReceipt
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoOrderConfirmed" {
            if let destination = segue.destination as? OrderConfirmed {
                destination.index = index!
                destination.email = email.text!
                destination.username = username.text!
            }
        }
    }
    func refreshReceipt() {
        
        SwiftyStoreKit.refreshReceipt { result in
            switch result {
            case .success(let receiptData):
                
                print("Receipt refresh success: \(receiptData.base64EncodedString) ") //\(receiptData.base64EncodedString)
            case .error(let error):
                print("Receipt refresh failed: \(error)")
            }
        }
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
   
    
    @IBAction func buyNowClicked(_ sender: AnyObject) {
        dismissKeyboard()
        
        if(username.text == "")
        {
            let alert = UIAlertController(title: "Invalid Username", message: "Username Cannot Be Left Blank", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        if(email.text == "")
        {
            let alert = UIAlertController(title: "Invalid Email", message: "Email Cannot Be Left Blank", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        if(username.text != "") && (email.text != "")
        {
        let url=getInstaprofilepicURL()
        }
      
        
    }//buynowbtn Clicked
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Quantity:\(quantity)")
        proceedBtn.setTitle("",for: .normal)
        
        buynow_btn.backgroundColor = UIColor.clear
        buynow_btn.layer.cornerRadius = 5
        buynow_btn.layer.borderWidth = 1
        buynow_btn.layer.borderColor = UIColor.blue.cgColor
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back1.png")!)

        
        
        print("Index Value:\(productIdentifiers[index!])")
        
        // Do any additional setup after loading the view.
    }
    
    func getInstaprofilepicURL() -> String
    {
        var tmpurl = "https://www.instagram.com/\(username.text!)"
        let url1 = NSURL(string: tmpurl)
        var url=""
        var invalid_username = false
        let task = URLSession.shared.dataTask(with: url1! as URL) {(data, response, error) in
            var html_code=NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            var html_code1: String = html_code as! String
            invalid_username = html_code1.contains("The link you followed may be broken, or the page may have been removed.")
            var profile_private = html_code1.contains("\"is_private\": true")
            
            print("Invalid Username: \(invalid_username) Profile Private: \(profile_private)")
            
            if((invalid_username))
            {
                
            }//if profile private or invalid username
            
            else
            {
        
            let tmp = "og:image\" content=\""
            var contentarray = html_code1.components(separatedBy: tmp)
            contentarray = contentarray[1].components(separatedBy: "/>")
            url = contentarray[0]
            //print("Image Code:\(url)")
            url = url.replacingOccurrences(of: "/>", with: "")
            url = url.replacingOccurrences(of: "\"", with: "")
            }
            
            DispatchQueue.main.async {
                
                if(invalid_username)
                {
                    let alert = UIAlertController(title: "Invalid Username", message: "The Given Username Does Not Exist.Please Check and Re-enter again.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                else
                {
                    if(profile_private)
                    {
                        let alert = UIAlertController(title: "Private Profile", message: "Your order can be delivered only if your profile is public.Kindly make the profile public for the next 48 Hrs.Once the order is delivered you can switch it to private again.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "I understand.", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
               
                    if url != nil
                {
                    print("BIF:URL is \(url)")
                    url=url.replacingOccurrences(of: " ", with: "")
                    var tmp_url = NSURL(string: url)
                    print("Value of tmp_url:\(tmp_url)")
                    
                    
                self.userImage.af_setImage(withURL: tmp_url as URL!)
                    self.proceedBtn.setTitle("Click Here To Continue With Your Purchase",for: .normal)
                    self.proceedBtn.backgroundColor = UIColor.clear
                    self.proceedBtn.layer.cornerRadius = 5
                    self.proceedBtn.layer.borderWidth = 1
                    self.proceedBtn.layer.borderColor = UIColor.black.cgColor
                }
                else
                {
                    print("BIF:Code Did Not Work")
                }
                }//main else
                
                //  self.userImage.af_setImage(withURL: downloadURL as URL)
            }

            
           // print("HTML Code:\(html_code1)")
            
            
            
        }
        task.resume()
        
        return url
        
    }//End of getInstaprofilepic()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
