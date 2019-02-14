//
//  detailHomeViewController.swift
//  IntelliShopList
//
//  Created by 김준우 on 2017-08-25.
//  Copyright © 2017 김준우. All rights reserved.
//



import UIKit
import SafariServices
import AVFoundation

class detailsHomeViewController: UIViewController {
    @IBOutlet var editInfo: UIButton!
    @IBOutlet var deleteThis:UIButton!
    @IBOutlet var searchOnline:UIButton!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var itemName: UILabel!
    @IBOutlet var itemPrice: UILabel!
    
    @IBOutlet var productImageView: UIImageView!
    
    @IBOutlet var iamgeViewConstraintHeight: NSLayoutConstraint!
    @IBOutlet var imageViewConstraintWidth: NSLayoutConstraint!
    @IBOutlet var imageDone: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.imageDone.alpha = 0
        self.deleteThis.layer.cornerRadius = 10
        self.deleteThis.clipsToBounds = true
        self.searchOnline.layer.cornerRadius = 10
        self.searchOnline.clipsToBounds = true
        self.doneButton.layer.cornerRadius = 10
        self.doneButton.clipsToBounds = true
        iamgeViewConstraintHeight.constant = UIScreen.main.bounds.width
        if UIScreen.main.bounds.height == 480.0 {
            iamgeViewConstraintHeight.constant = UIScreen.main.bounds.width - 50
            print("iPhoneX")
            
        }

 
    }
    
    override func viewDidLoad() {
        itemName.text = itemNameForDetailFromHome
        itemPrice.text = "$\(itemPriceForDetailFromHome!)"
        
        let fileManager = FileManager.default

        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(itemImagePathFromHome)
        if fileManager.fileExists(atPath: imagePAth){
            productImageView.image = UIImage(contentsOfFile: imagePAth)
            // myImage.image = UIImage(contentsOfFile: imagePAth)
        }else{
            productImageView.image = UIImage(named: "IMAC.jepg")
            
        }
        print(UIScreen.main.bounds.height)
        
        
        
    }
    
    @IBAction func doneWithThisItem() {
        
        

        
        AudioServicesPlaySystemSound(1519)
        
        UIView.animate(withDuration: 0.3) {
            self.itemName.alpha = 0
            self.itemPrice.alpha = 0
            self.imageDone.alpha = 1
            
        }
        
        for firstItem in itemsListDatas {
            
            if firstItem.count == 0 {
                
                itemsListDatas = itemBackUp
                
            }
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            
            AudioServicesPlaySystemSound(1519)
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            
            self.navigationController?.popViewController(animated: true)
        })
    }
    
    @IBAction func deleteThisItem() {
        
        AudioServicesPlaySystemSound(1521)
        itemImage.removeAll()
        if let i = itemForDeleteName.index(of: itemName.text!) {
            print(i)
            for var firstItem in itemsListDatas {
                firstItem.remove(at: i)
                
                if firstItem.count == 0 {
                    
                    itemsListDatas = itemBackUp
                    let MusicData = NSKeyedArchiver.archivedData(withRootObject: itemsListDatas)
                    UserDefaults.standard.set(itemsListDatas, forKey: "itemListDataArray")
                    UserDefaults.standard.synchronize()
                } else {
                    itemsListDatas.removeAll()
                    
                    itemsListDatas.append(firstItem)
                }
                
                for secondItem in firstItem {
                    if firstItem.count == 0 {
                        
                    } else {
                        itemImage.append(secondItem[2])
                    }
                }
            }
        }
        
        let MusicData = NSKeyedArchiver.archivedData(withRootObject: itemsListDatas)
        UserDefaults.standard.set(itemsListDatas, forKey: "itemListDataArray")
        UserDefaults.standard.synchronize()
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            
            self.navigationController?.popViewController(animated: true)
        })
    }
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    @IBAction func searchOnlineThroughSFViewController() {
        
        
        //https://www.amazon.ca/s/ref=nb_sb_noss_2/133-3171663-1909855?url=search-alias%3Daps&field-keywords=
        let something: String!
        let prefixedSearchKeyword: String!
        prefixedSearchKeyword = itemName.text!
        var secondFix: String!
        secondFix =  prefixedSearchKeyword.replacingOccurrences(of: " ", with: "%20")
        something =  "https://www.amazon.ca/s/ref=nb_sb_noss_2/133-3171663-1909855?url=search-alias%3Daps&field-keywords=\(secondFix!)"
        print(something)
        if let url = URL(string: something!) {
            let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
            present(vc, animated: true)
        }
        
        
    }
    
}

