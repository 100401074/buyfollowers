//
//  Contact Us.swift
//  Buy Instagram Followers And Likes
//
//  Created by Santhej Kallada on 26/10/16.
//  Copyright © 2016 Kallada. All rights reserved.
//

import UIKit

class Contact_Us: UIViewController {
    
    var tmp : String = ""

    @IBOutlet var emailContent: UITextView!
    
    @IBAction func sendMail_clicked(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Message Sent", message: "Our Support Team Will Get Back To You In 24 Hours", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        emailContent.layer.borderWidth = 5.0
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back1.png")!)
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)

      
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
