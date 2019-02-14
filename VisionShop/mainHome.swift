//
//  mainHome.swift
//  VisionShop
//
//  Created by 김준우 on 2017-08-05.
//  Copyright © 2017 김준우. All rights reserved.
//

import UIKit


var productName = ["iPhone", "MacBook", "Macbook Pro", "apple", "Garbage Can"]

var intelligentContentHeaderArray = ["Recent","","","Maybe you forgot...","", ""]

var itemTitleHome:[String] = []

var itemPriceHome: [String] = []
var itemImageHome: [String] = []

var itemForDeleteName: [String] = []

var itemBackUp  = [[["Add items","Add items to your list.","","1000000000"],]]

var itemNameForDetailFromHome: String!
var itemPriceForDetailFromHome: String!
var itemImagePathFromHome: String!
var countries = ["United States", "Canada", "Korea", "China", "Japan"]

class IntelligenceFirstViewInHomeScreen: UITableViewCell {
    
    @IBOutlet var productImage: UIImageView!
    
    @IBOutlet var productName: UILabel!
    @IBOutlet var productPrice: UILabel!
    
    @IBOutlet var IntelligentContentHeader: UILabel!
    @IBOutlet var shadowView: UIView!
}
class IntelligenceFirstViewInHomeScreenCollectionViewItems: UITableViewCell {
    @IBOutlet var productImage: UIImageView!
    
    @IBOutlet var productName: UILabel!
    @IBOutlet var productPrice: UILabel!
    
}


class IntelligenceSecondViewInHomeScreenMissed: UITableViewCell {
    
    
}
class mainHomeViewControoler: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet var selectedCountry: UILabel!
    @IBOutlet var yourListImage: UIImageView!
    @IBOutlet var mainHomeTableView: UITableView!
    @IBOutlet var tabBar: UIView!
    @IBOutlet var yourListScreenImage: UIImageView!
    @IBOutlet var addScreenImage: UIImageView!
    @IBOutlet var addImage: UIImageView!
    @IBOutlet var homeImage: UIImageView!
    @IBOutlet var settingsView: UIView!
    @IBOutlet var pickingCountry: UIPickerView!
    var itemRecent: [String] = []
    var itemAddedTime: [String] = []
    var itemsHomeScreen = [[["","","",""]]]
    override func viewDidLoad() {
        super.viewDidLoad()
        changedData = false
        mainHomeTableView.separatorColor = UIColor.clear
        mainHomeTableView.tableFooterView = UIView()
        pickingCountry.delegate = self
        pickingCountry.dataSource = self
        
        
        for FirstElement in itemsListDatas {
            
            for secondElement in FirstElement {
                let currentDateTime = Date()
                itemsHomeScreen.append([secondElement])
                if currentDateTime.timeIntervalSinceReferenceDate - Double(secondElement[secondElement.count - 1])! >= 5 {
                    
                }
                
                
                
            }
        }
        
        
    }
    
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard
        
        if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
            //print("App already launched : \(isAppAlreadyLaunchedOnce)")
            
            let MusicDatasArraySaved = UserDefaults.standard.object(forKey: "itemListDataArray") as! [[[String]]]
            print(MusicDatasArraySaved)
            
            
            itemsListDatas.removeAll()
            
            itemsListDatas = MusicDatasArraySaved
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            itemsListDatas.removeAll()
            
            itemsListDatas = itemBackUp
            UserDefaults.standard.set(itemsListDatas, forKey: "itemListDataArray")
            UserDefaults.standard.synchronize()

            
            // print("App launched first time")
            return false
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        
        if UserDefaults.standard.string(forKey: "updated") == "UpdatedToStableVersion" {
            print("wasSynchronized")
            
            
        } else if UserDefaults.standard.string(forKey: "updated") != "UpdatedToStableVersion"{
            print("updated")
            UserDefaults.standard.set("UpdatedToStableVersion", forKey: "updated")
            UserDefaults.standard.synchronize()
            print("synchronized")
            print(UserDefaults.standard.string(forKey: "updated"))
            //
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IntroViewController") as UIViewController
            
            self.present(viewController, animated: false, completion: nil)
            

            
        }

        canceledInHome = false
        canceledInYourList = false
        if cancelLaunchAddViewController == true {
            self.addScreenImage.frame = CGRect(x:  0, y: 0 , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            self.addScreenImage.alpha  = 1
            self.addImage.frame = CGRect(x:  0, y: 0 , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            self.addImage.alpha = 0
            self.addScreenImage.frame = CGRect(x:  0, y: 0 , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            self.addScreenImage.alpha  = 1
            self.homeImage.transform = CGAffineTransform.init(translationX: 0, y: 100)
            self.yourListImage.transform = CGAffineTransform.init(translationX: 0, y: 100)
            
            self.mainHomeTableView.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            self.navigationController?.navigationBar.alpha = 0
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.homeImage.transform = CGAffineTransform.init(translationX: 0, y: 0)
                self.yourListImage.transform = CGAffineTransform.init(translationX: 0, y: 0)
                
            }, completion: nil)
            
            DispatchQueue.main.asyncAfter(deadline: .now() , execute: {
                
                UIView.animate(withDuration: 0.65, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                    
                    self.mainHomeTableView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                    self.navigationController?.navigationBar.alpha = 1
                    self.addImage.frame = CGRect(x:  (UIScreen.main.bounds.width/2) - 17.5, y: (UIScreen.main.bounds.height) - 47 , width: 35, height: 35)
                    self.addImage.alpha  = 1
                    self.addScreenImage.frame = CGRect(x:  (UIScreen.main.bounds.width/2) - 17.5 , y: (UIScreen.main.bounds.height) - 47 , width: 35, height: 35)
                    self.addScreenImage.alpha  = 0
                }, completion: nil)
                
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                    self.homeImage.transform = CGAffineTransform.init(translationX: 0, y: 0)
                    self.yourListImage.transform = CGAffineTransform.init(translationX: 0, y: 0)
                    
                }, completion: nil)
                
                
            })
        } else if cancelLaunchAddViewController == false {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.mainHomeTableView.transform = CGAffineTransform.init(translationX: 0, y: 0)
                self.mainHomeTableView.alpha =  1
            }, completion: nil)
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.homeImage.transform = CGAffineTransform.init(translationX: 0, y: 0)
                
            }, completion: nil)
            
            UIView.animate(withDuration: 0.3, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                
                self.addImage.transform = CGAffineTransform.init(translationX: 0, y: 0)
                
            }, completion: nil)
            UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                
                self.yourListImage.transform = CGAffineTransform.init(translationX: 0, y: 0)
                
            }, completion: nil)
            
            
        }
        cancelLaunchAddViewController = false
        
        

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    @IBAction func settingsViewShow() {
        UIView.animate(withDuration: 0.5) {
            self.settingsView.alpha = 1

        }
    }
    
    @IBAction func dismissSettingsView() {
        UIView.animate(withDuration: 0.5) {
            self.settingsView.alpha = 0
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        mainHomeTableView.reloadData()
        settingsView.alpha = 0
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        isAppAlreadyLaunchedOnce()

        itemTitleHome.removeAll()
        itemPriceHome.removeAll()
        itemImageHome.removeAll()
        itemAddedTime.removeAll()
        itemForDeleteName.removeAll()
        for firstElement in itemsListDatas {
            
            for secondElement in firstElement {
                
                print(secondElement[0])
                itemTitleHome.append(secondElement[0])
                itemPriceHome.append(secondElement[1])
                itemImageHome.append(secondElement[2])
                itemAddedTime.append(secondElement[3])
                itemForDeleteName.append(secondElement[0])
            }
            
            
            
        }
        if UIScreen.main.bounds.height >= 665 && UIScreen.main.bounds.height <= 667{
            addScreenImage.image = UIImage(named:"CameraLaunchScreen.png")
            
            
        } else if UIScreen.main.bounds.height >= 730 && UIScreen.main.bounds.height <= 740 {
            addScreenImage.image = UIImage(named:"CameraLaunchScreen.png")
            
            
        } else if UIScreen.main.bounds.height >= 560 && UIScreen.main.bounds.height <= 570 {
            addScreenImage.image = UIImage(named:"cameraLaunchView2x.png")
            
            
        } else if UIScreen.main.bounds.height >= 811 {
            
            addScreenImage.image = UIImage(named:"Camera@3xiPhoneX.png")
            print("iPhoneX")
            
        }
        
        
        if cancelLaunchAddViewController == true {
            
            
        } else if cancelLaunchAddViewController == false {
            self.homeImage.transform = CGAffineTransform.init(translationX: 0, y: 100)
            self.addImage.transform = CGAffineTransform.init(translationX: 0, y: 100)
            self.yourListImage.transform = CGAffineTransform.init(translationX: 0, y: 100)
            mainHomeTableView.transform = CGAffineTransform.init(translationX: 0, y: 200)
            self.mainHomeTableView.alpha =  0
            self.yourListScreenImage.alpha  = 0
            self.addScreenImage.alpha = 0
        }
        
        if UIScreen.main.bounds.height >= 665 && UIScreen.main.bounds.height <= 667{
            yourListScreenImage.image = UIImage(named:"YourListScreen.png")
            
            
        } else if UIScreen.main.bounds.height >= 730 && UIScreen.main.bounds.height <= 740 {
            yourListScreenImage.image = UIImage(named:"YourListScreeniPhone3x.png")

            
        } else if UIScreen.main.bounds.height >= 560 && UIScreen.main.bounds.height <= 570 {
            yourListScreenImage.image = UIImage(named:"YourListScreeniPhone2x4inch.png")

            
        } else if UIScreen.main.bounds.height >= 811 {
            
            yourListScreenImage.image = UIImage(named:"yourList@3XiPhoneX.png")
            print("iPhoneX")
            
        } else {
            
            yourListScreenImage.image = UIImage(named:"YourList@2xSmall.png")

        }


    }
    
    @IBAction func goToAddViewController() {
        canceledInHome = true
        canceledInYourList = false

        UIView.animate(withDuration: 0.2) {
            self.mainHomeTableView.alpha = 0
            self.tabBar.alpha = 0
            
        }
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            //self.mainHomeTableView.transform = CGAffineTransform.init(translationX: 0, y: -200)
            //self.mainHomeTableView.alpha =  0//(-UIScreen.main.bounds.width/4)-12 //(-UIScreen.main.bounds.height/3)-12
            self.yourListImage.alpha  = 0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.65, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.mainHomeTableView.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            self.tabBar.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            self.navigationController?.navigationBar.alpha = 0
            self.addImage.frame = CGRect(x:  0, y: 0 , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            self.addImage.alpha  = 0
            self.addScreenImage.frame = CGRect(x:  0, y: 0 , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            self.addScreenImage.alpha  = 1
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
    
    @IBAction func goToListViewController() {
        
        cancelLaunchAddViewController = false
        // view.bringSubview(toFront: yourListScreenImage)
        
        UIView.animate(withDuration: 0.2) {
            self.mainHomeTableView.alpha = 0
            self.tabBar.alpha = 0
        }
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            //self.mainHomeTableView.transform = CGAffineTransform.init(translationX: 0, y: -200)
            //self.mainHomeTableView.alpha =  0//(-UIScreen.main.bounds.width/4)-12 //(-UIScreen.main.bounds.height/3)-12
            self.yourListImage.alpha  = 0
            self.homeImage.transform = CGAffineTransform.init(translationX: 0, y: 100)
            
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            
            self.addImage.transform = CGAffineTransform.init(translationX: 0, y: 100)
            
        }, completion: nil)
        
        UIView.animate(withDuration: 0.65, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            //self.mainHomeTableView.transform = CGAffineTransform.init(translationX: 0, y: -200)
            //self.mainHomeTableView.alpha =  0//(-UIScreen.main.bounds.width/4)-12 //(-UIScreen.main.bounds.height/3)-12
            print(UIScreen.main.bounds.height)
            if UIScreen.main.bounds.height == 480.0 {
            self.yourListScreenImage.frame = CGRect(x:  0, y: 17 , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height )
                
            } else {
                self.yourListScreenImage.frame = CGRect(x:  0, y: 0 , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

                
            }
            self.yourListScreenImage.alpha  = 1
            
            
            self.mainHomeTableView.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            self.tabBar.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            self.navigationController?.navigationBar.alpha = 0
            self.yourListImage.frame = CGRect(x:  0, y: 0 , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            self.yourListImage.alpha  = 0
            //yourListScreenImage
        }, completion: nil)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.65, execute: {
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "YourListViewController") as UIViewController
            
            self.present(viewController, animated: false, completion: nil)
            
        })
        
        
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCountry.text = countries[row]
    }
    @IBAction func goToSearchViewController() {
        
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as UIViewController
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            let heightInt: CGFloat!

            if itemTitleHome.count >= 1  {
                heightInt = 300

                
            } else {
                heightInt = 0
                
            }
            return heightInt
        } else if indexPath.row == 1 {
            let heightInt: CGFloat!
            if  itemTitleHome.count >= 2   {
                heightInt = 300
            } else {
                heightInt = 0
                
            }
            
            return heightInt
            
        } else if indexPath.row == 2 {
            let heightInt: CGFloat!
            
            if  itemTitleHome.count >= 3  {
                heightInt = 300
                
            }else {
                
                heightInt = 0
                
            }
            
            return heightInt
            
            
        } else if indexPath.row == 3 {
            let heightInt: CGFloat!
            let currentDateTime = Date()

            if  itemTitleHome.count >= 4  &&  currentDateTime.timeIntervalSinceReferenceDate - Double(itemAddedTime[0])! >= 64800.0    {//64800
                
                heightInt = 300
                
            }else {
                
                heightInt = 0
                
            }
            
            return heightInt
            
        }else if indexPath.row == 4 {
            let heightInt: CGFloat!
            let currentDateTime = Date()

            if   itemTitleHome.count >= 5 &&  currentDateTime.timeIntervalSinceReferenceDate - Double(itemAddedTime[1])! >= 64800.0    {
                
                heightInt = 300
                
            }else {
                heightInt = 0
                
            }
            
            return heightInt
            
        } else if indexPath.row == 5 {
            let heightInt: CGFloat!
            let currentDateTime = Date()

            if itemTitleHome.count >= 6 &&  currentDateTime.timeIntervalSinceReferenceDate - Double(itemAddedTime[2])! >= 64800.0  {

                heightInt = 300
                
            }else {
                heightInt = 0
                
            }
            
            return heightInt
            
        } else {
            
            return 300
            
        }
        
    }
    
    var count: Int!
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainHomeTableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
        //var itemNameForDetailFromHome: String!
        //var itemPriceForDetailFromHome: String!
        if indexPath.row == 0 {
            itemNameForDetailFromHome = itemTitleHome[itemTitleHome.count - 1]
            itemPriceForDetailFromHome = itemPriceHome[itemPriceHome.count - 1]
            itemImagePathFromHome = itemImageHome[itemImageHome.count - 1]
            
        } else if indexPath.row == 1 {
            itemNameForDetailFromHome = itemTitleHome[itemTitleHome.count - 2]
            itemPriceForDetailFromHome = itemPriceHome[itemPriceHome.count - 2]
            itemImagePathFromHome = itemImageHome[itemImageHome.count - 2]

            
        } else if indexPath.row == 2 {
            itemNameForDetailFromHome = itemTitleHome[itemTitleHome.count - 3]
            itemPriceForDetailFromHome = itemPriceHome[itemPriceHome.count - 3]
            itemImagePathFromHome = itemImageHome[itemImageHome.count - 3]

            
        }else if indexPath.row == 3 {
            itemNameForDetailFromHome = itemTitleHome[0]
            itemPriceForDetailFromHome = itemPriceHome[0]
            itemImagePathFromHome = itemImageHome[0]

            
        }else if indexPath.row == 4 {
            itemNameForDetailFromHome = itemTitleHome[1]
            itemPriceForDetailFromHome = itemPriceHome[1]
            itemImagePathFromHome = itemImageHome[1]

            
        } else if indexPath.row == 5 {
            itemNameForDetailFromHome = itemTitleHome[2]
            itemPriceForDetailFromHome = itemPriceHome[2]
            itemImagePathFromHome = itemImageHome[2]

            
        }




        
    }
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = mainHomeTableView.dequeueReusableCell(withIdentifier: "RecentlyAddedIntelligenceCell", for: indexPath) as! IntelligenceFirstViewInHomeScreen
            
            if itemTitleHome.count >= 1  {
                cell.productName.text = itemTitleHome[itemTitleHome.count - 1]

                if cell.productName.text == "Add items" {
                    cell.productPrice.text = "\(itemPriceHome[itemPriceHome.count - 1])"
                    cell.IntelligentContentHeader.text = ""
                    cell.productImage.layer.cornerRadius = 25
                    cell.productImage.clipsToBounds = true
                    cell.productImage.image = UIImage(named: "IntelliShopBetterIcon.png")

                    
                    
                    cell.shadowView.clipsToBounds = false
                    cell.shadowView.layer.shadowColor = UIColor.black.cgColor
                    cell.shadowView.layer.shadowOpacity = 1
                    cell.shadowView.layer.shadowOffset = CGSize.zero
                    cell.shadowView.layer.shadowRadius = 25
                    cell.shadowView.layer.shadowPath = UIBezierPath(roundedRect: cell.shadowView.bounds , cornerRadius: 0).cgPath
                    //myImage.clipsToBounds = true
                    
                } else {
                let fileManager = FileManager.default
                let myImage = UIImageView(frame: cell.shadowView.bounds)

                let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(itemImageHome[itemImageHome.count - 1])
                if fileManager.fileExists(atPath: imagePAth){
                    cell.productImage.image = UIImage(contentsOfFile: imagePAth)
                   // myImage.image = UIImage(contentsOfFile: imagePAth)
                }else{
                    cell.productImage.image = UIImage(named: "IMAC.jepg")
                    
                }
                cell.productPrice.text = "$\(itemPriceHome[itemPriceHome.count - 1])"
                cell.IntelligentContentHeader.text = "Recent"
                cell.productImage.layer.cornerRadius = 25
                cell.productImage.clipsToBounds = true
                
                
                
                cell.shadowView.clipsToBounds = false
                cell.shadowView.layer.shadowColor = UIColor.black.cgColor
                cell.shadowView.layer.shadowOpacity = 1
                cell.shadowView.layer.shadowOffset = CGSize.zero
                cell.shadowView.layer.shadowRadius = 25
                cell.shadowView.layer.shadowPath = UIBezierPath(roundedRect: cell.shadowView.bounds , cornerRadius: 0).cgPath
                //myImage.clipsToBounds = true
                //myImage.layer.cornerRadius = 10
                //cell.shadowView.addSubview(myImage)
                    
                }
            }
            return cell
        } else if indexPath.row == 1 {
            
            let cell = mainHomeTableView.dequeueReusableCell(withIdentifier: "RecentlyAddedIntelligenceCell", for: indexPath) as! IntelligenceFirstViewInHomeScreen
            if  itemTitleHome.count >= 2   {
                let fileManager = FileManager.default
                let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(itemImageHome[itemImageHome.count - 2])
                if fileManager.fileExists(atPath: imagePAth){
                    cell.productImage.image = UIImage(contentsOfFile: imagePAth)
                }else{
                    cell.productImage.image = UIImage(named: "IMAC.jepg")
                }
                
                cell.productName.text = itemTitleHome[itemTitleHome.count - 2]
                cell.productPrice.text = "$\(itemPriceHome[itemPriceHome.count - 2])"
                cell.IntelligentContentHeader.text = ""
                cell.productImage.layer.cornerRadius = 25
                cell.productImage.clipsToBounds = true
                cell.shadowView.clipsToBounds = false
                cell.shadowView.layer.shadowColor = UIColor.black.cgColor
                cell.shadowView.layer.shadowOpacity = 1
                cell.shadowView.layer.shadowOffset = CGSize.zero
                cell.shadowView.layer.shadowRadius = 25
                cell.shadowView.layer.shadowPath = UIBezierPath(roundedRect: cell.shadowView.bounds , cornerRadius: 0).cgPath

            } else {
                
                cell.productName.text = ""
                cell.productPrice.text = ""
                cell.IntelligentContentHeader.text = ""
                cell.productImage.layer.cornerRadius = 25
                cell.productImage.clipsToBounds = true
                
            }
            
            return cell
            
            
        } else if indexPath.row == 2 {
            
            let cell = mainHomeTableView.dequeueReusableCell(withIdentifier: "RecentlyAddedIntelligenceCell", for: indexPath) as! IntelligenceFirstViewInHomeScreen
            if  itemTitleHome.count >= 3  {
                let fileManager = FileManager.default
                let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(itemImageHome[itemImageHome.count - 3])
                if fileManager.fileExists(atPath: imagePAth){
                    cell.productImage.image = UIImage(contentsOfFile: imagePAth)
                }else{
                    print("No Image")
                    cell.productImage.image = UIImage(named: "IMAC.jepg")
                    
                }
                
                cell.productName.text = itemTitleHome[itemTitleHome.count - 3]
                cell.productPrice.text = "$\(itemPriceHome[itemPriceHome.count - 3])"
                cell.IntelligentContentHeader.text = ""
                cell.productImage.layer.cornerRadius = 25
                cell.productImage.clipsToBounds = true
                cell.shadowView.clipsToBounds = false
                cell.shadowView.layer.shadowColor = UIColor.black.cgColor
                cell.shadowView.layer.shadowOpacity = 1
                cell.shadowView.layer.shadowOffset = CGSize.zero
                cell.shadowView.layer.shadowRadius = 25
                cell.shadowView.layer.shadowPath = UIBezierPath(roundedRect: cell.shadowView.bounds , cornerRadius: 0).cgPath

            }else {
                
                cell.productName.text = ""
                cell.productPrice.text = ""
                cell.IntelligentContentHeader.text = ""
                cell.productImage.layer.cornerRadius = 25
                cell.productImage.clipsToBounds = true
                
            }
            
            return cell
            
            
        } else if indexPath.row == 3 {
            
            let cell = mainHomeTableView.dequeueReusableCell(withIdentifier: "RecentlyAddedIntelligenceCell", for: indexPath) as! IntelligenceFirstViewInHomeScreen
            if  itemTitleHome.count >= 4   {
                
                let fileManager = FileManager.default
                let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(itemImageHome[0])
                if fileManager.fileExists(atPath: imagePAth){
                    cell.productImage.image = UIImage(contentsOfFile: imagePAth)
                }else{
                    cell.productImage.image = UIImage(named: "IMAC.jepg")
                }
                
                //cell.productImage.image = UIImage(named: "")
                cell.productName.text = itemTitleHome[0]
                cell.productPrice.text = "$\(itemPriceHome[0])"
                cell.IntelligentContentHeader.text = "Maybe you forgot..."
                cell.productImage.layer.cornerRadius = 25
                cell.productImage.clipsToBounds = true
                cell.shadowView.clipsToBounds = false
                cell.shadowView.layer.shadowColor = UIColor.black.cgColor
                cell.shadowView.layer.shadowOpacity = 1
                cell.shadowView.layer.shadowOffset = CGSize.zero
                cell.shadowView.layer.shadowRadius = 25
                cell.shadowView.layer.shadowPath = UIBezierPath(roundedRect: cell.shadowView.bounds , cornerRadius: 0).cgPath

            }else {
                
                cell.productName.text = ""
                cell.productPrice.text = ""
                cell.IntelligentContentHeader.text = ""
                cell.productImage.layer.cornerRadius = 25
                cell.productImage.clipsToBounds = true
                
            }
            
            
            return cell
            
        }else if indexPath.row == 4 {
            
            let cell = mainHomeTableView.dequeueReusableCell(withIdentifier: "RecentlyAddedIntelligenceCell", for: indexPath) as! IntelligenceFirstViewInHomeScreen
            if   itemTitleHome.count >= 5  {
                let fileManager = FileManager.default
                let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(itemImageHome[1])
                if fileManager.fileExists(atPath: imagePAth){
                    cell.productImage.image = UIImage(contentsOfFile: imagePAth)
                }else{
                    cell.productImage.image = UIImage(named: "IMAC.jepg")
                }

               // cell.productImage.image = UIImage(named: "")
                cell.productName.text = itemTitleHome[1]
                cell.productPrice.text = "$\(itemPriceHome[1])"
                cell.IntelligentContentHeader.text = ""
                cell.productImage.layer.cornerRadius = 25
                cell.productImage.clipsToBounds = true
                
                cell.shadowView.clipsToBounds = false
                cell.shadowView.layer.shadowColor = UIColor.black.cgColor
                cell.shadowView.layer.shadowOpacity = 1
                cell.shadowView.layer.shadowOffset = CGSize.zero
                cell.shadowView.layer.shadowRadius = 25
                cell.shadowView.layer.shadowPath = UIBezierPath(roundedRect: cell.shadowView.bounds , cornerRadius: 0).cgPath

            }else {
                
                cell.productName.text = ""
                cell.productPrice.text = ""
                cell.IntelligentContentHeader.text = ""
                cell.productImage.layer.cornerRadius = 25
                cell.productImage.clipsToBounds = true
                
            }
            
            return cell
            
            
        } else if indexPath.row == 5 {
            
            let cell = mainHomeTableView.dequeueReusableCell(withIdentifier: "RecentlyAddedIntelligenceCell", for: indexPath) as! IntelligenceFirstViewInHomeScreen
            if itemTitleHome.count >= 6   {
                let fileManager = FileManager.default
                let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(itemImageHome[2])
                if fileManager.fileExists(atPath: imagePAth){
                    cell.productImage.image = UIImage(contentsOfFile: imagePAth)
                }else{
                    cell.productImage.image = UIImage(named: "IMAC.jepg")
                }

                //cell.productImage.image = UIImage(named: "")
                cell.productName.text = itemTitleHome[2]
                cell.productPrice.text = "$\(itemPriceHome[2])"
                cell.IntelligentContentHeader.text = ""
                cell.productImage.layer.cornerRadius = 25
                cell.productImage.clipsToBounds = true
                
                cell.shadowView.clipsToBounds = false
                cell.shadowView.layer.shadowColor = UIColor.black.cgColor
                cell.shadowView.layer.shadowOpacity = 1
                cell.shadowView.layer.shadowOffset = CGSize.zero
                cell.shadowView.layer.shadowRadius = 25
                cell.shadowView.layer.shadowPath = UIBezierPath(roundedRect: cell.shadowView.bounds , cornerRadius: 0).cgPath

            }else {
                
                cell.productName.text = ""
                cell.productPrice.text = ""
                cell.IntelligentContentHeader.text = ""
                cell.productImage.layer.cornerRadius = 25
                cell.productImage.clipsToBounds = true
                
            }
            
            return cell
            
            
        } else {
            let cell = mainHomeTableView.dequeueReusableCell(withIdentifier: "RecentlyAddedIntelligenceCell", for: indexPath) as! IntelligenceFirstViewInHomeScreen
            
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 6
        
        
        
    }
    
    
    
}


/*
 
 
 var thisisThird: Bool!
 if indexPath.row == 0 {
 // try flipping if of indexPath.row and itemTitleHome.count
 let cell = mainHomeTableView.dequeueReusableCell(withIdentifier: "RecentlyAddedIntelligenceCell", for: indexPath) as! IntelligenceFirstViewInHomeScreen
 
 /*
 thisisThird = false
 if itemTitleHome.count == 1 || itemTitleHome.count == 2 || itemTitleHome.count == 3 || itemTitleHome.count == 4 || itemTitleHome.count == 5 || itemTitleHome.count == 6   {
 
 cell.productImage.image = UIImage(named: "IMAC.jpeg")
 cell.productName.text = itemTitleHome[0]
 cell.productPrice.text = "$\(itemPriceHome[0])"
 cell.IntelligentContentHeader.text = "Recent"
 }
 print(indexPath.row)
 print("First")
 */
 return cell
 
 
 
 } else if indexPath.row == 1 {
 
 let cell = mainHomeTableView.dequeueReusableCell(withIdentifier: "RecentlyAddedIntelligenceCell", for: indexPath) as! IntelligenceFirstViewInHomeScreen
 if itemTitleHome.count == 2 || itemTitleHome.count == 3 || itemTitleHome.count == 4 || itemTitleHome.count == 5 || itemTitleHome.count == 6 {
 cell.productImage.image = UIImage(named: "IMAC.jpeg")
 cell.productName.text = itemTitleHome[1]
 cell.productPrice.text = "$\(itemPriceHome[1])"
 cell.IntelligentContentHeader.text = ""
 }
 print(indexPath.row)
 
 return cell
 } else  if indexPath.row == 2 {
 
 let cell = mainHomeTableView.dequeueReusableCell(withIdentifier: "RecentlyAddedIntelligenceCell", for: indexPath) as! IntelligenceFirstViewInHomeScreen
 
 if itemTitleHome.count == 3 || itemTitleHome.count == 4 || itemTitleHome.count == 5 || itemTitleHome.count == 6 {
 
 cell.productImage.image = UIImage(named: "IMAC.jpeg")
 cell.productName.text = itemTitleHome[2]
 cell.productPrice.text = "$\(itemPriceHome[2])"
 cell.IntelligentContentHeader.text = ""
 }
 print(indexPath.row)
 return cell
 }else if indexPath.row == 4 {
 
 let cell = mainHomeTableView.dequeueReusableCell(withIdentifier: "RecentlyAddedIntelligenceCell", for: indexPath) as! IntelligenceFirstViewInHomeScreen
 if indexPath.row == 4 {
 thisisThird = true
 
 if thisisThird == true {
 if  itemTitleHome.count == 4 || itemTitleHome.count == 5 || itemTitleHome.count == 6 {
 
 for FirstElement in itemsListDatas {
 
 for secondElement in FirstElement {
 let currentDateTime = Date()
 
 if currentDateTime.timeIntervalSinceReferenceDate - Double(secondElement[secondElement.count - 1])! >= 5 {
 
 cell.productImage.image = UIImage(named: "")
 cell.productName.text = "Hello"
 cell.productPrice.text = "$\(itemPriceHome[3])"
 cell.IntelligentContentHeader.text = "Maybe you forgot..."
 }
 }
 }
 
 } else {
 
 cell.productImage.image = UIImage(named: "")
 cell.productName.text = ""
 cell.productPrice.text =  ""
 cell.IntelligentContentHeader.text =  ""
 }
 
 }
 }
 print(indexPath.row)
 print("Third")
 
 
 return cell
 } else  if indexPath.row == 5 {
 
 let cell = mainHomeTableView.dequeueReusableCell(withIdentifier: "RecentlyAddedIntelligenceCell", for: indexPath) as! IntelligenceFirstViewInHomeScreen
 
 if  itemTitleHome.count == 5 || itemTitleHome.count == 6{
 
 for FirstElement in itemsListDatas {
 
 for secondElement in FirstElement {
 let currentDateTime = Date()
 
 cell.productImage.image = UIImage(named: "IMAC.jpeg")
 cell.productName.text = "itemTitleHome[4]"
 cell.productPrice.text = "itemPriceHome[4]"
 cell.IntelligentContentHeader.text = ""
 
 
 }
 
 }
 } else {
 
 cell.productImage.image = UIImage(named: "")
 cell.productName.text = ""
 cell.productPrice.text =  ""
 cell.IntelligentContentHeader.text =  ""
 }
 print(indexPath.row)
 return cell
 } else  if indexPath.row == 6 {
 
 let cell = mainHomeTableView.dequeueReusableCell(withIdentifier: "RecentlyAddedIntelligenceCell", for: indexPath) as! IntelligenceFirstViewInHomeScreen
 
 if itemTitleHome.count == 6 {
 
 for FirstElement in itemsListDatas {
 
 for secondElement in FirstElement {
 let currentDateTime = Date()
 
 cell.productImage.image = UIImage(named: "IMAC.jpeg")
 cell.productName.text = "itemTitleHome[5]"
 cell.productPrice.text = "itemPriceHome[5]"
 cell.IntelligentContentHeader.text = ""
 
 }
 
 
 
 }
 }else {
 
 cell.productImage.image = UIImage(named: "")
 cell.productName.text = ""
 cell.productPrice.text =  ""
 cell.IntelligentContentHeader.text =  ""
 }
 
 print(indexPath.row)
 return cell
 } else {
 let cell = mainHomeTableView.dequeueReusableCell(withIdentifier: "RecentlyAddedIntelligenceCell", for: indexPath) as! IntelligenceFirstViewInHomeScreen
 cell.productImage.image = UIImage(named: "")
 cell.productName.text = ""
 cell.productPrice.text =  ""
 cell.IntelligentContentHeader.text =  ""
 
 return cell
 }
 
 */




