//
//  FirstViewController.swift
//  Buy Instagram Followers And Likes
//
//  Created by Santhej Kallada on 13/10/16.
//  Copyright © 2016 Kallada. All rights reserved.
//

import UIKit


class FirstViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var prices : [String] = ["14.99","34.99","64.99","99.99","149.99","174.99"]
    var images : [String] = ["1.png","2.png","3.png","4.png","5.png","6.png"]
    var product_quantity : [String] = ["1000","3000","5000","10000","15000","20000"]
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back1.png")!)

        
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return images.count
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell : collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! collectionCell
        cell.orderCell.text = "Order Now"
        cell.priceCell.text = "$"+prices[indexPath.row]
        cell.imageCell.image = UIImage(named: images[indexPath.row])
        
        cell.layer.cornerRadius=10 //set corner radius here
        cell.layer.borderColor = UIColor.black.cgColor  // set cell border color here
        cell.layer.borderWidth = 3
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Following Image was clicked: \(images[indexPath.row])")
        performSegue(withIdentifier: "gotoproductPage", sender: indexPath.row)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoproductPage" {
            if let destination = segue.destination as? productPage {
                let index = sender as! Int
                destination.quantity = product_quantity[index]
                destination.imageName = images[index]
                destination.index = index
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

