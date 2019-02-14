//
//  DetailsViewControllerForSearchViewController.swift
//  IntelliShopList
//
//  Created by 김준우 on 2017-08-22.
//  Copyright © 2017 김준우. All rights reserved.
//

import UIKit

import AVFoundation
import SafariServices

var itemNameFromSearchViewController: String!
var itemPriceFromSearchViewController: String!
var itemImageFromSearchViewController: String!
class DetailsViewControllerForSearchViewController: UIViewController {
    
    @IBOutlet var itemNameDetailView: UILabel!
    @IBOutlet var itemPriceDetailView: UILabel!
    @IBOutlet var itemImageDetailView: UIImageView!
    @IBOutlet var doneImage: UIImageView!
    
    @IBOutlet var deleteThisButton: UIButton!
    @IBOutlet var searchOnlineButton: UIButton!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var imageViewConstraintWidth: NSLayoutConstraint!
    @IBOutlet var imageViewConstraintHeight: NSLayoutConstraint!

    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.doneImage.alpha = 0
        self.deleteThisButton.layer.cornerRadius = 10
        self.deleteThisButton.clipsToBounds = true
        self.searchOnlineButton.layer.cornerRadius = 10
        self.searchOnlineButton.clipsToBounds = true
        self.doneButton.layer.cornerRadius = 10
        self.doneButton.clipsToBounds = true
        imageViewConstraintHeight.constant = UIScreen.main.bounds.width
        if UIScreen.main.bounds.height == 480.0 {
            imageViewConstraintHeight.constant = UIScreen.main.bounds.width - 50
            print("iPhoneX")
            
        }
  
    }
    
    override func viewDidLoad() {
        itemNameDetailView.text = itemNameFromSearchViewController
        itemPriceDetailView.text = "$\(itemPriceFromSearchViewController!)"
        requestedItemCellForDetail = itemTitleHome.index(of: itemNameFromSearchViewController)!

        
        let fileManager = FileManager.default
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(itemImageHome[requestedItemCellForDetail])
        if fileManager.fileExists(atPath: imagePAth){
            itemImageDetailView.image = UIImage(contentsOfFile: imagePAth)
        }else{
            print("No Image")
        }
        print(UIScreen.main.bounds.height)
        
        
        
        
    }
    
    @IBAction func doneWithThisItem() {
        
        
        
        AudioServicesPlaySystemSound(1519)
        changedData = true
        UIView.animate(withDuration: 0.3) {
            self.itemNameDetailView.alpha = 0
            self.itemPriceDetailView.alpha = 0
            self.doneImage.alpha = 1
            
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
        if let i = itemForDeleteName.index(of: itemNameDetailView.text!) {
            print(i)
            for var firstItem in itemsListDatas {
                firstItem.remove(at: i)
                itemsListDatas.removeAll()
                
                itemsListDatas.append(firstItem)
                
                for secondItem in firstItem {
                    
                    itemImage.append(secondItem[2])
                    
                }
            }
        }
        
        changedData = true
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
        prefixedSearchKeyword = itemNameDetailView.text!
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
