//
//  productPage.swift
//  Buy Instagram Followers And Likes
//
//  Created by Santhej Kallada on 15/10/16.
//  Copyright © 2016 Kallada. All rights reserved.
//

import UIKit

class productPage: UIViewController {
    
    var quantity : String = ""
    var imageName : String = ""
    var index : Int? = nil

    @IBOutlet var desc: UITextView!
    @IBOutlet var buynow_btn: UIButton!
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var heading: UILabel!
    @IBAction func buybtn_Clicked(_ sender: AnyObject) {
        performSegue(withIdentifier: "gotoBuyNow", sender: self)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        heading.text = "Buy " + quantity + " Followers"
        productImage.image = UIImage(named: imageName)
        
        buynow_btn.backgroundColor = UIColor.clear
        buynow_btn.layer.cornerRadius = 5
        buynow_btn.layer.borderWidth = 1
        buynow_btn.layer.borderColor = UIColor.black.cgColor
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back1.png")!)
        



        
        
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoBuyNow" {
            if let destination = segue.destination as? BuyNow {
                destination.quantity = quantity
                destination.index = index
            }
        }
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
