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
    var content = ""
    var email = ""
    var subject = ""
    var name = ""

    @IBOutlet var emailContent: UITextView!
    @IBOutlet var namefield: UITextField!
    @IBOutlet var emailfield: UITextField!
    @IBOutlet var subjectfield: UITextField!
    
    @IBAction func sendMail_clicked(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Message Sent", message: "Our Support Team Will Get Back To You In 24 Hours", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        email = emailfield.text!
        subject = subjectfield.text!
        content = emailContent.text
        name = namefield.text!
        
        sendEmail()
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
    
    func sendEmail()
    {
        var request = URLRequest(url: URL(string: "http://mmadandroid.com/AppStore/buyinstafollowersSwift/support.php")!)
        request.httpMethod = "POST"
        let postString = "name=\(name)&email=\(email)&subject=\(subject)&content=\(content)"
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
