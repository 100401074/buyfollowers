//
//  BuyNow.swift
//  Buy Instagram Followers And Likes
//
//  Created by Santhej Kallada on 16/10/16.
//  Copyright © 2016 Kallada. All rights reserved.
//

import UIKit
import AlamofireImage


class BuyNow: UIViewController {
    
    var quantity : String = ""
    var productName : String = ""

    @IBOutlet var proceedBtn: UIButton!
    @IBOutlet var userImage: UIImageView!
    
    
    @IBAction func proceedBtnClicked(_ sender: AnyObject) {
    }
   
    
    @IBAction func buyNowClicked(_ sender: AnyObject) {
        
        let url=getInstaprofilepicURL()
        print("URL Inside buyNOW Clicked:\(url)")
       // let downloadURL = NSURL(string: url)!
        //userImage.af_setImage(withURL: downloadURL as URL)
        
    }//buynowbtn Clicked
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Quantity:\(quantity)")
        proceedBtn.setTitle("",for: .normal)
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func getInstaprofilepicURL() -> String
    {
        let url1 = NSURL(string: "https://www.instagram.com/santhej_kallada/")
        var url=""
        let task = URLSession.shared.dataTask(with: url1! as URL) {(data, response, error) in
            var html_code=NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            var html_code1: String = html_code as! String
            let tmp = "og:image\" content=\""
            var contentarray = html_code1.components(separatedBy: tmp)
            contentarray = contentarray[1].components(separatedBy: "/>")
            url = contentarray[0]
            //print("Image Code:\(url)")
            url = url.replacingOccurrences(of: "/>", with: "")
            url = url.replacingOccurrences(of: "\"", with: "")
            
            
            DispatchQueue.main.async {
                
                print("BIF:URL Inside DispatchQueue:\(url)")
                if url != nil
                {
                    print("BIF:URL is \(url)")
                    url=url.replacingOccurrences(of: " ", with: "")
                    var tmp_url = NSURL(string: url)
                    print("Value of tmp_url:\(tmp_url)")
                    
                    
                self.userImage.af_setImage(withURL: tmp_url as URL!)
                    self.proceedBtn.setTitle("Click Here To Continue With Your Purchase",for: .normal)
                }
                else
                {
                    print("BIF:Code Did Not Work")
                }
                
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
