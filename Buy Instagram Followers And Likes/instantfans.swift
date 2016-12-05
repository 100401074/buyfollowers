//
//  instantfans.swift
//  Buy Instagram Followers And Likes
//
//  Created by Santhej Kallada on 21/11/16.
//  Copyright © 2016 Kallada. All rights reserved.
//

import Foundation
//
//  instantfans.swift
//  instantfans
//
//  Created by Santhej Kallada on 15/11/16.
//  Copyright © 2016 Kallada. All rights reserved.
//

import UIKit
import CoreData

class instantfans: UIViewController {
    var api = "a1ac77ba9bf6e89dc7ee68df72b4be88"
    var url = "http://instant-fans.com/api/v2"
    var serviceid = "200"
    var order_no = ""
    var jsonResult1: AnyObject? = nil
    var start_count = ""
    var status = ""
    var remains = ""
    
    
   
    func add(username: String,quantity: String,productName: String)
    {
        var request = URLRequest(url: URL(string: "http://instant-fans.com/api/v2")!)
        request.httpMethod = "POST"
        let postString = "key=a1ac77ba9bf6e89dc7ee68df72b4be88&action=add&service=200&quantity=\(quantity)&link=http://www.instagram.com/\(username)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response!)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            do {
                
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject // Added "as anyObject" to fix syntax error in Xcode 8 Beta 6
                
                
                print("JSON Result:\(jsonResult)")
                self.order_no = jsonResult["order"] as! String
                print("Order Number:\(self.order_no)")
                self.addToDatabase(productName: productName,username: username)
            }
            catch
            {
                print("Error is JSON Parsing")
            }
        }
        task.resume()
        
    }//add
    
    func order_status(id: String)
    {
        var request = URLRequest(url: URL(string: "http://instant-fans.com/api/v2")!)
        request.httpMethod = "POST"
        let postString = "key=a1ac77ba9bf6e89dc7ee68df72b4be88&action=status&order=\(id)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response!)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            
            print("responseString = \(responseString!)")
            
            
            do {
                
                self.jsonResult1 = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject // Added "as anyObject" to fix syntax error in Xcode 8 Beta 6
                
                print("Status:\(self.jsonResult1?["status"])")
                self.start_count = self.jsonResult1?["start_count"] as! String
                self.status = self.jsonResult1?["status"] as! String
                self.remains = self.jsonResult1?["remains"] as! String
            }
            catch
            {
                print("Error is JSON Parsing")
            }
            
        }
        task.resume()
    }//order_status
    
    
    func addToDatabase(productName: String,username: String)
    {
        //Add New Data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Orders", into: context)
        
        newUser.setValue(order_no, forKey: "order_no")
        newUser.setValue(productName, forKey: "product_name")
        newUser.setValue(username, forKey: "username")

        do {
            try context.save()
            print("Saved")
        } catch {
            print("Cannot Be Saved")
        }
    }
    
    func deleteAllData()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Orders")
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in  error : \(error) \(error.userInfo)")
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
