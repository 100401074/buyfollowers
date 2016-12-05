//
//  OrderStatus.swift
//  Buy Instagram Followers And Likes
//
//  Created by Santhej Kallada on 26/10/16.
//  Copyright © 2016 Kallada. All rights reserved.
//

import UIKit

class OrderStatus: UIViewController {
    
    var tmp : String = ""
    var order_no = ""
    var start_count = ""
    var status = ""
    var remains = ""
    var ordername = ""
    var username = ""
    var obj = instantfans()

    @IBOutlet var status_text: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back1.png")!)
        
        //start_count = obj.jsonResult1?["start_count"] as! String
        //status = obj.jsonResult1?["status"] as! String
       // remains = obj.jsonResult1?["remains"] as! String
        obj.order_status(id: order_no)
        
        while(obj.status == "")
        {
            
        }
        
        status_text.text = "" +
            "Order Name: \(ordername) \n" +
            "Username         : \(username) \n" +
            "Start Count          :\(obj.start_count) Followers \n" +
            "Status              \t  :\(obj.status) \n" +
            "Remaining           :\(obj.remains)\n" +
        "\n \nPlease Contact Us using the button below in case you have any queries about your order"
        
        print("Order Status:\(obj.status)")
        
        


        // Do any additional setup after loading the view.
    }
    
    
    
    

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
