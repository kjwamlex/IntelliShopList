//
//  IntroViewController.swift
//  IntelliShopList
//
//  Created by 김준우 on 2017-08-10.
//  Copyright © 2017 김준우. All rights reserved.
//

import UIKit

class introViewController: UIViewController {
    
    @IBOutlet var COntinueButton: UIButton!
    
    @IBOutlet var homeScreen: UIImageView!
    
    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    @IBOutlet var thridLabel: UILabel!
    @IBOutlet var featuresList: UIView!
    
    @IBOutlet var thirdFeatureTitle: UILabel!
    @IBOutlet var thirdFeatureImage: UIImageView!
    @IBOutlet var thirdDescriptionView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.COntinueButton.layer.cornerRadius = 13
        
        self.COntinueButton
            .clipsToBounds = true

    }
    override func viewWillAppear(_ animated: Bool) {
        homeScreen.alpha = 0
        print(UIScreen.main.bounds.height)
        if UIScreen.main.bounds.height >= 665 && UIScreen.main.bounds.height <= 667{
            homeScreen.image = UIImage(named:"HomeScreen.png")
            
            
        } else if UIScreen.main.bounds.height >= 730 && UIScreen.main.bounds.height <= 740 {
            homeScreen.image = UIImage(named:"homeiPhone3x.png")
            
            
        } else if UIScreen.main.bounds.height >= 560 && UIScreen.main.bounds.height <= 570 {
            homeScreen.image = UIImage(named:"HomeScreeniPhone2x4inch.png")
            
            
        } else if UIScreen.main.bounds.height < 560 {
            thirdFeatureTitle.alpha = 0
            thirdFeatureImage.alpha = 0
            thirdDescriptionView.alpha = 0
            homeScreen.image = UIImage(named:"Home@2xSmall.png")
        } else if UIScreen.main.bounds.height == 812 {
            
            homeScreen.image = UIImage(named:"Home@3xiPhoneX.png")

        } else if UIScreen.main.bounds.height == 480 {
            
        }

    }
    @IBAction func goToHomeScreen() {
        
        UIView.animate(withDuration: 0.4) {
            self.firstLabel.alpha = 0
            self.secondLabel.alpha = 0
            self.thridLabel.alpha = 0
            self.featuresList.alpha = 0
            
        }
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            //self.mainHomeTableView.transform = CGAffineTransform.init(translationX: 0, y: -200)
            //self.mainHomeTableView.alpha =  0//(-UIScreen.main.bounds.width/4)-12 //(-UIScreen.main.bounds.height/3)-12
            self.COntinueButton.alpha  = 0
        }, completion: nil)
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            //self.mainHomeTableView.transform = CGAffineTransform.init(translationX: 0, y: -200)
            //self.mainHomeTableView.alpha =  0//(-UIScreen.main.bounds.width/4)-12 //(-UIScreen.main.bounds.height/3)-12
            self.COntinueButton.frame = CGRect(x:  0, y: 0 , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            self.COntinueButton.alpha  = 0
            
            if UIScreen.main.bounds.height == 480.0 {
                self.homeScreen.frame = CGRect(x:  0, y: 17 , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height )
                
            } else {
                self.homeScreen.frame = CGRect(x:  0, y: 0 , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                
                
            }

            //self.homeScreen.frame = CGRect(x:  0, y: 0 , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            self.homeScreen.alpha  = 1
            
            //homeScreen
        }, completion: nil)

        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as UIViewController
            
            self.present(viewController, animated: false, completion: nil)
            
        })

    }
}
