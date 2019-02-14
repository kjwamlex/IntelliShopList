//
//  ListTableViewController.swift
//  VisionShop
//
//  Created by 김준우 on 2017-08-09.
//  Copyright © 2017 김준우. All rights reserved.
//

import UIKit
var itemTitle: [String] = []
var itemPrice: [String] = []
var itemImage: [String] = []

var selectedIndexPathRow: Int!

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet var itemImageView: UIImageView!
    
    @IBOutlet var itemLabel: UILabel!
    
    @IBOutlet var itemPrice: UILabel!
    @IBOutlet var shadowView: UIView!
}

class ListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var listTableView: UITableView!
    @IBOutlet var tabBar: UIView!
    @IBOutlet var homeImage: UIImageView!
    @IBOutlet var homeScreen: UIImageView!
    @IBOutlet var addLaunchScreen: UIImageView!
    @IBOutlet var addImage: UIImageView!
    @IBOutlet var yourListImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.scrollsToTop = true
        listTableView.contentOffset.y = 0

    }
    override func viewDidAppear(_ animated: Bool) {
        
        canceledInHome = false
        canceledInYourList = false
        if cancelLaunchAddViewController == true {
            self.addLaunchScreen.frame = CGRect(x:  0, y: 0 , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            self.addLaunchScreen.alpha  = 1
            self.addImage.frame = CGRect(x:  0, y: 0 , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            self.addImage.alpha = 0
            self.addLaunchScreen.frame = CGRect(x:  0, y: 0 , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            self.addLaunchScreen.alpha  = 1
            self.homeImage.transform = CGAffineTransform.init(translationX: 0, y: 100)
            self.yourListImage.transform = CGAffineTransform.init(translationX: 0, y: 100)
            
            self.listTableView.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            self.navigationController?.navigationBar.alpha = 0
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.homeImage.transform = CGAffineTransform.init(translationX: 0, y: 0)
                self.yourListImage.transform = CGAffineTransform.init(translationX: 0, y: 0)
                
            }, completion: nil)
            
            DispatchQueue.main.asyncAfter(deadline: .now() , execute: {
                
                UIView.animate(withDuration: 0.65, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                    
                    self.listTableView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                    self.listTableView.alpha = 1
                    self.navigationController?.navigationBar.alpha = 1
                    self.addImage.frame = CGRect(x:  (UIScreen.main.bounds.width/2) - 17.5, y: (UIScreen.main.bounds.height) - 47 , width: 35, height: 35)
                    self.addImage.alpha  = 1
                    self.addLaunchScreen.frame = CGRect(x:  (UIScreen.main.bounds.width/2) - 17.5 , y: (UIScreen.main.bounds.height) - 47 , width: 35, height: 35)
                    self.addLaunchScreen.alpha  = 0
                }, completion: nil)
                
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                    self.homeImage.transform = CGAffineTransform.init(translationX: 0, y: 0)
                    self.yourListImage.transform = CGAffineTransform.init(translationX: 0, y: 0)
                    
                }, completion: nil)
                
                
            })
        } else if cancelLaunchAddViewController == false {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.listTableView.transform = CGAffineTransform.init(translationX: 0, y: 0)
            self.listTableView.alpha =  1
            //self.navigationController?.navigationBar.alpha = 1

        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.yourListImage.transform = CGAffineTransform.init(translationX: 0, y: 0)

        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            
            self.addImage.transform = CGAffineTransform.init(translationX: 0, y: 0)
            
        }, completion: nil)
        UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.homeImage.transform = CGAffineTransform.init(translationX: 0, y: 0)

            
        }, completion: nil)
        }
        cancelLaunchAddViewController = false
listTableView.reloadData()
        
        listTableView.scrollsToTop = true
        listTableView.contentOffset.y = 0
        }
    
    
  
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        listTableView.scrollsToTop = true
        listTableView.contentOffset.y = 0

        if UIScreen.main.bounds.height >= 665 && UIScreen.main.bounds.height <= 667{
            addLaunchScreen.image = UIImage(named:"CameraLaunchScreen.png")
            
            
        } else if UIScreen.main.bounds.height >= 730 && UIScreen.main.bounds.height <= 740 {
            addLaunchScreen.image = UIImage(named:"CameraLaunchScreen.png")
            
            
        } else if UIScreen.main.bounds.height >= 560 && UIScreen.main.bounds.height <= 570 {
            addLaunchScreen.image = UIImage(named:"cameraLaunchView2x.png")
            
            
        } else if UIScreen.main.bounds.height >= 811 {

            addLaunchScreen.image = UIImage(named:"Camera@3xiPhoneX.png")

        }

        itemTitle.removeAll()
        itemPrice.removeAll()
        itemImage.removeAll()
        itemForDeleteName.removeAll()

        for firstElement in itemsListDatas {
            
            if firstElement.count == 0 {
                
                itemsListDatas = itemBackUp

            }
            
        
            for secondElement in firstElement {
                
                print(secondElement[0])
                itemTitle.append(secondElement[0])
                //itemTitle.reverse()
                itemPrice.append(secondElement[1])
               // itemPrice.reverse()
                itemImage.append(secondElement[2])
               // itemImage.reverse()
                itemForDeleteName.append(secondElement[0])
            }
            
        }
        
        itemTitle.reverse()
        itemPrice.reverse()
        itemImage.reverse()
       //x self.navigationController?.navigationBar.alpha = 0
        homeScreen.alpha = 0
        addLaunchScreen.alpha = 0
        listTableView.transform = CGAffineTransform.init(translationX: 0, y: 200)
        self.listTableView.alpha =  0
        print(itemTitle)
        print(itemPrice)
        self.homeImage.transform = CGAffineTransform.init(translationX: 0, y: 100)
        self.addImage.transform = CGAffineTransform.init(translationX: 0, y: 100)
        self.yourListImage.transform = CGAffineTransform.init(translationX: 0, y: 100)
        if UIScreen.main.bounds.height >= 665 && UIScreen.main.bounds.height <= 667{
            homeScreen.image = UIImage(named:"HomeScreen.png")
            
            
        } else if UIScreen.main.bounds.height >= 730 && UIScreen.main.bounds.height <= 740 {
            homeScreen.image = UIImage(named:"homeiPhone3x.png")
            
            
        } else if UIScreen.main.bounds.height >= 560 && UIScreen.main.bounds.height <= 570 {
            homeScreen.image = UIImage(named:"HomeScreeniPhone2x4inch.png")
            
            
        } else if UIScreen.main.bounds.height == 812 {
            
            homeScreen.image = UIImage(named:"Home@3xiPhoneX.png")
            
        } else if UIScreen.main.bounds.height == 480 {
            homeScreen.image = UIImage(named:"Home@2xSmall.png")

        } 
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var totalCellCount: Int!
        for firstElement in itemsListDatas {
            
            for secondElement in firstElement {
                
                totalCellCount = firstElement.count
                
            }
            
        }
        
        return totalCellCount
    }
    
    @IBAction func goToHomeViewController() {
        
        
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.yourListImage.transform = CGAffineTransform.init(translationX: 0, y: 100)

            
        }, completion: nil)
        UIView.animate(withDuration: 0.3, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.addImage.transform = CGAffineTransform.init(translationX: 0, y: 100)

            
        }, completion: nil)

        
        UIView.animate(withDuration: 0.2) {
            self.listTableView.alpha = 0
            
        }
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {

            self.homeImage.alpha  = 0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.65, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {

            self.listTableView.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            self.navigationController?.navigationBar.alpha = 0
            self.homeImage.frame = CGRect(x:  0, y: 0 , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            self.homeImage.alpha  = 0
            if UIScreen.main.bounds.height == 480.0 {
                self.homeScreen.frame = CGRect(x:  0, y: 17 , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height )
                
            } else {
                self.homeScreen.frame = CGRect(x:  0, y: 0 , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                
                
            }

            self.homeScreen.alpha  = 1

        }, completion: nil)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.65, execute: {
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as UIViewController
            
            self.present(viewController, animated: false, completion: nil)
            
        })
        
        
        
    }
    
    @IBAction func goToAddViewController() {
        //addLaunchScreen
        canceledInYourList = true
        canceledInHome = false
        UIView.animate(withDuration: 0.2) {
            self.listTableView.alpha = 0
            self.tabBar.alpha = 0
            
        }
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            //self.mainHomeTableView.transform = CGAffineTransform.init(translationX: 0, y: -200)
            //self.mainHomeTableView.alpha =  0//(-UIScreen.main.bounds.width/4)-12 //(-UIScreen.main.bounds.height/3)-12
            self.yourListImage.alpha  = 0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.65, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.listTableView.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            self.tabBar.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            self.navigationController?.navigationBar.alpha = 0
            self.addImage.frame = CGRect(x:  0, y: 0 , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            self.addImage.alpha  = 0
            self.addLaunchScreen.frame = CGRect(x:  0, y: 0 , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            self.addLaunchScreen.alpha  = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.homeImage.transform = CGAffineTransform.init(translationX: 0, y: 100)
            self.yourListImage.transform = CGAffineTransform.init(translationX: 0, y: 100)
            
        }, completion: nil)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
            
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddViewController") as UIViewController
            
            self.present(viewController, animated: false, completion: nil)
            
        })
        
        
        
    }
    
    
    @IBAction func goToSearchViewController() {
        
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as UIViewController
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemNameForDetail = itemTitle[indexPath.row]
        itemPriceForDetail = itemPrice[indexPath.row]
        selectedIndexPathRow = indexPath.row
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let itemCell = listTableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        
        
        itemCell.itemImageView.layer.cornerRadius = 25
        itemCell.itemImageView.clipsToBounds = true

        itemCell.itemLabel.text = itemTitle[indexPath.row]
        
        if itemPrice[indexPath.row] == "Add items to your list." && itemTitle[indexPath.row] == "Add items" {
            
            itemCell.itemPrice.text = "\(itemPrice[indexPath.row])"

        } else {
            itemCell.itemPrice.text = "$\(itemPrice[indexPath.row])"

        }
    
    
        
        if itemCell.itemLabel.text == "Add items" {
            itemCell.itemImageView.image = UIImage(named: "IntelliShopBetterIcon.png")

            
        } else {
        let fileManager = FileManager.default
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(itemImage[indexPath.row])
        if fileManager.fileExists(atPath: imagePAth){
            itemCell.itemImageView.image = UIImage(contentsOfFile: imagePAth)
        }else{
            print("No Image")
        }
        }
        itemCell.shadowView.clipsToBounds = false
        itemCell.shadowView.layer.shadowColor = UIColor.black.cgColor
        itemCell.shadowView.layer.shadowOpacity = 1
        itemCell.shadowView.layer.shadowOffset = CGSize.zero
        itemCell.shadowView.layer.shadowRadius = 15
        itemCell.shadowView.layer.shadowPath = UIBezierPath(roundedRect: itemCell.shadowView.bounds , cornerRadius: 0).cgPath

        return itemCell
    }
    
    func getImage(){

    }
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
    
}
