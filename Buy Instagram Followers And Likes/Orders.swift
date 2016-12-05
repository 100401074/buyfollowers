//
//  Orders.swift
//  Buy Instagram Followers And Likes
//
//  Created by Santhej Kallada on 26/10/16.
//  Copyright © 2016 Kallada. All rights reserved.
//

import UIKit
import CoreData

class Orders: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tmp : String = ""
    var productNames: [String] = []
    var usernames: [String] = []
    var order_nos: [String] = []
    var selected_orderno = ""
    var selected_ordername = ""
    var selected_username = ""
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tmp code
        _ = instantfans()
       // obj.deleteAllData()
        
        
        //end tmp code
        getDataFromDatabase()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back1.png")!)
        

        // Do any additional setup after loading the view.
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return order_nos.count
    }

    
   
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = order_nos[indexPath.row] + "-"+productNames[indexPath.row]
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected_orderno = order_nos[indexPath.row]
        selected_ordername = productNames[indexPath.row]
        selected_username = usernames[indexPath.row]
        performSegue(withIdentifier: "orderstatus_page", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "orderstatus_page" {
            if let destination = segue.destination as? OrderStatus {
                destination.tmp = "Reached Order Status Page"
                destination.order_no = selected_orderno
                destination.ordername = selected_ordername
                destination.username = selected_username
                
            }
        }//if
    }
    
    
    
    //Getting Data From Database
    func getDataFromDatabase()
    {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Orders")
    request.returnsObjectsAsFaults = false
    
    do {
    let results = try context.fetch(request)
    if results.count > 0
    {
    for result in results as! [NSManagedObject]
    {
   // let username = result.value(forKey: "order_no") as? String
        productNames.append((result.value(forKey: "product_name") as? String)!)
   // let password =  result.value(forKey: "product_name") as? String
        order_nos.append((result.value(forKey: "order_no") as? String)!)
        usernames.append((result.value(forKey: "username") as? String)!)
    
    //print("Username:\(username) Password:\(password)")
    
    
    }//for
    }
    else
    {
    print("No Data Available")
    }
    } catch
    {
    print("Error While Getting Data")
    }
    }//func

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
