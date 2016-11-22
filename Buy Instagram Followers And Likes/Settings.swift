//
//  Settings.swift
//  Buy Instagram Followers And Likes
//
//  Created by Santhej Kallada on 25/10/16.
//  Copyright © 2016 Kallada. All rights reserved.
//

import UIKit

class Settings: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var pageNames = ["My Orders","Contact Us"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back1.png")!)


        // Do any additional setup after loading the view.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return pageNames.count
    }
    
    

   
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = pageNames[indexPath.row]
        //cell.textLabel?.alpha = 0.2
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Page Clicked:\(pageNames[indexPath.row])")
        if(pageNames[indexPath.row] == "Contact Us")
        {
        performSegue(withIdentifier: "contact_page", sender: self)
        }//if
        if(pageNames[indexPath.row] == "My Orders")
        {
            performSegue(withIdentifier: "orderPage", sender: self)
        }//if
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "contact_page" {
            if let destination = segue.destination as? Contact_Us {
                destination.tmp = "Reached Conact Us Page"
            }
        }
        if segue.identifier == "orderPage" {
            if let destination = segue.destination as? Orders {
                destination.tmp = "Reached Orders Page"
            }
        }
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
