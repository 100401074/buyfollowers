//
//  OrderConfirmed.swift
//  Buy Instagram Followers And Likes
//
//  Created by Santhej Kallada on 07/11/16.
//  Copyright © 2016 Kallada. All rights reserved.
//

import UIKit

class OrderConfirmed: UIViewController {
    
    var index : Int? = nil
    var email : String = ""
    var username : String = ""
    var quantity : Int? = nil
    var order_no : String = ""
    
    
    
    
    let productIdentifiers: [String] = ["1000 Instagram Followers","2000 Instagram Followers","3000 Instagram Followers","5000 Instagram Followers","7000 Instagram Followers","10000 Instagram Followers"]
    
    //continue from http://mmadandroid.com/AppStore/buyinstafollowersSwift/send.php?email='santhejkalladacom'

    override func viewDidLoad() {
        super.viewDidLoad()
        print(productIdentifiers[index!])
        print("Order Made For \(username)")
        var obj = instantfans()
        obj.add(username: username, quantity: "100",productName: productIdentifiers[index!])
        sendEmail()
        // Do any additional setup after loading the view.
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //func email
    func sendEmail()
    {
        var request = URLRequest(url: URL(string: "http://mmadandroid.com/AppStore/buyinstafollowersSwift/send.php")!)
        request.httpMethod = "POST"
        let postString = "email=\(email)&username=\(username)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        task.resume()
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
