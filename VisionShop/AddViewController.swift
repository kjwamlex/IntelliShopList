//
//  AddViewController.swift
//  VisionShop
//
//  Created by 김준우 on 2017-08-08.
//  Copyright © 2017 김준우. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import CoreML
import Vision
var itemsListDatas = [[["Add items","Add items to your list.","","1000000000"],]]// ,["Macbook","1399","","1000000000"],["Macbook Pro","1599","","1000000000"],["Apple","60M","","1000000000"]
var cancelLaunchAddViewController = false
var canceledInHome = false
var canceledInYourList = false
class AddViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var itemName: UITextField!
    @IBOutlet var itemPrice: UITextField!
    @IBOutlet var productImage: UIImageView!
    
    @IBOutlet var addUsingVision: UIButton!
    @IBOutlet var objectPhoto: UIImageView!
    @IBOutlet var launchImage: UIImageView!
    @IBOutlet var firstStepView: UIView!
    @IBOutlet var secondStepView: UIView!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var homeScreen: UIImageView!
    @IBOutlet var doneScreen: UIView!
    var session = AVCaptureSession()
    
    var imagePicker: UIImagePickerController!
    
    var launched = false
    var searchItem: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addUsingVision.layer.cornerRadius = 8
        self.addUsingVision.clipsToBounds = true
        self.doneButton.layer.cornerRadius = 8
        self.doneButton.clipsToBounds = true
        self.nextButton.layer.cornerRadius = 8
        self.nextButton.clipsToBounds = true
        
        
    }
    
    @IBAction func addUsingVisionCoreML() {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

        if UIScreen.main.bounds.height >= 665 && UIScreen.main.bounds.height <= 667{
            launchImage.image = UIImage(named:"CameraLaunchScreen.png")
            
            
        } else if UIScreen.main.bounds.height >= 730 && UIScreen.main.bounds.height <= 740 {
            launchImage.image = UIImage(named:"CameraLaunchScreen.png")
            
            
        } else if UIScreen.main.bounds.height >= 560 && UIScreen.main.bounds.height <= 570 {
            launchImage.image = UIImage(named:"cameraLaunchView2x.png")
            
            
        } else if UIScreen.main.bounds.height >= 811 {
            self.launchImage.frame = CGRect(x:  0, y: 0 , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

            launchImage.image = UIImage(named:"Camera@3xiPhoneX copy.png")
            
        }

        if launched == false {
            self.homeScreen.transform = CGAffineTransform.init(scaleX: 0.0001, y: 0.0001)
            self.secondStepView.transform = CGAffineTransform.init(translationX: 100, y: 0)
            self.secondStepView.alpha  = 0
            self.firstStepView.alpha = 0
            self.doneScreen.alpha = 0
        }
        
        
        if canceledInHome == true {
            

            
            if UIScreen.main.bounds.height >= 665 && UIScreen.main.bounds.height <= 667{
                homeScreen.image = UIImage(named:"HomeScreen.png")
                
                
            } else if UIScreen.main.bounds.height >= 730 && UIScreen.main.bounds.height <= 740 {
                homeScreen.image = UIImage(named:"homeiPhone3x.png")
                
                
            } else if UIScreen.main.bounds.height >= 560 && UIScreen.main.bounds.height <= 570 {
                homeScreen.image = UIImage(named:"HomeScreeniPhone2x4inch.png")
                
                
            }

            
        } else if canceledInYourList == true {
            
            //homeScreen.image = UIImage(named: "YourListScreen.png")
            if UIScreen.main.bounds.height >= 665 && UIScreen.main.bounds.height <= 667{
                homeScreen.image = UIImage(named:"YourListScreen.png")
                
                
            } else if UIScreen.main.bounds.height >= 730 && UIScreen.main.bounds.height <= 740 {
                homeScreen.image = UIImage(named:"YourListScreeniPhone3x.png")
                
                
            } else if UIScreen.main.bounds.height >= 560 && UIScreen.main.bounds.height <= 570 {
                homeScreen.image = UIImage(named:"YourListScreeniPhone2x4inch.png")
                
                
            }
            
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if launched == false {
            imagePicker =  UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            present(imagePicker, animated: false, completion: nil)
            launched = true
        }
        
    }
    
    @IBAction func nextStep() {
        view.endEditing(true)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            //self.mainHomeTableView.transform = CGAffineTransform.init(translationX: 0, y: -200)
            //self.mainHomeTableView.alpha =  0//(-UIScreen.main.bounds.width/4)-12 //(-UIScreen.main.bounds.height/3)-12
            self.firstStepView.transform = CGAffineTransform.init(translationX: -100, y: 0)
            self.firstStepView.alpha = 0
        }, completion: nil)

        UIView.animate(withDuration: 0.3, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            //self.mainHomeTableView.transform = CGAffineTransform.init(translationX: 0, y: -200)
            //self.mainHomeTableView.alpha =  0//(-UIScreen.main.bounds.width/4)-12 //(-UIScreen.main.bounds.height/3)-12
            self.secondStepView.transform = CGAffineTransform.init(translationX: 0, y: 0)
            self.secondStepView.alpha = 1

        }, completion: nil)
        itemPrice.becomeFirstResponder()
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        launchImage.alpha = 0
        self.firstStepView.alpha = 1
        
        imagePicker.dismiss(animated: true, completion: nil)
        
        
        objectPhoto.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        guard let ciImage = CIImage(image: objectPhoto.image!) else {
            fatalError("couldn't convert UIImage to CIImage")
        }
        self.detectScene(image: ciImage)
        print("done")
        
        itemName.becomeFirstResponder()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75, execute: {
            //self.searchOnAmazon()
        })
        // searchOnAmazon()
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: false, completion: nil)
        
        cancelLaunchAddViewController = true
        if canceledInHome == true {
        DispatchQueue.main.asyncAfter(deadline: .now() , execute: {
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as UIViewController
            
            self.present(viewController, animated: false, completion: nil)
        })
        
        } else if canceledInYourList == true {
            
            DispatchQueue.main.asyncAfter(deadline: .now() , execute: {
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "YourListViewController") as UIViewController
                
                self.present(viewController, animated: false, completion: nil)
            })
        }
    }
    
    @IBAction func dismissViewController() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func addItemsToArray() {
        view.endEditing(true)

        AudioServicesPlaySystemSound(1519)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            
            AudioServicesPlaySystemSound(1519)
        })
        
        
        cancelLaunchAddViewController = false
        let currentDateTime = Date()
        
        for var firstElement in itemsListDatas {
            
            
            firstElement.insert([self.itemName.text!,self.itemPrice.text!,"\(itemName.text!)\(itemPrice.text!).jpeg", "\(currentDateTime.timeIntervalSinceReferenceDate)"], at: firstElement.count)
            itemsListDatas.removeAll()
            itemsListDatas.append(firstElement)
            
            let size = CGSize(width: 500, height: 500)
            let image = objectPhoto.image?.crop(to:size)
            saveImageDocumentDirectory(imageName: "\(itemName.text!)\(itemPrice.text!).jpeg", imageToSave: image!)
            for secondElement in firstElement {
                if secondElement[0] == "Add items" {
                    firstElement.remove(at: 0)
                    itemsListDatas.removeAll()
                    
                    itemsListDatas.append(firstElement)
                }
                
            }
            
        }
        itemTitleHome.removeAll()
        itemPriceHome.removeAll()
        itemImageHome.removeAll()
        itemForDeleteName.removeAll()
        for firstElement in itemsListDatas {
            
            for secondElement in firstElement {
                
                print(secondElement[0])
                itemTitleHome.append(secondElement[0])
                itemPriceHome.append(secondElement[1])
                itemImageHome.append(secondElement[2])
                itemForDeleteName.append(secondElement[0])
            }
            
            
        }
        
        let MusicData = NSKeyedArchiver.archivedData(withRootObject: itemsListDatas)
        UserDefaults.standard.set(itemsListDatas, forKey: "itemListDataArray")
        UserDefaults.standard.synchronize()

        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.secondStepView.alpha = 0
            }, completion: nil)
            
            UIView.animate(withDuration: 0.3) {
                self.doneScreen.alpha = 1

                
            }
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
            UIView.animate(withDuration: 0.3) {
                self.doneScreen.alpha = 0

            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9, execute: {
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                
                self.homeScreen.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }, completion: nil)
        })

        print(itemsListDatas)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.75, execute: {
            if canceledInHome == true {

            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as UIViewController
            
            self.present(viewController, animated: false, completion: nil)
                
            } else if canceledInYourList == true {
                
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "YourListViewController") as UIViewController
                
                self.present(viewController, animated: false, completion: nil)

                
            }
        })
        
        
    }
    
    
    
    
    
    func saveImageDocumentDirectory(imageName: String, imageToSave: UIImage){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        let image = imageToSave
        print(paths)
        let imageData = UIImageJPEGRepresentation(image, 0.5)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }
    
    func getImage(){
        let fileManager = FileManager.default
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent("apple.jpg")
        if fileManager.fileExists(atPath: imagePAth){
            self.objectPhoto.image = UIImage(contentsOfFile: imagePAth)
        }else{
            print("No Image")
        }
    }
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    
    
}


extension UIImage {
    
    func crop(to:CGSize) -> UIImage {
        guard let cgimage = self.cgImage else { return self }
        
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        
        let contextSize: CGSize = contextImage.size
        
        //Set to square
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        let cropAspect: CGFloat = to.width / to.height
        
        var cropWidth: CGFloat = to.width
        var cropHeight: CGFloat = to.height
        
        if to.width > to.height { //Landscape
            cropWidth = contextSize.width
            cropHeight = contextSize.width / cropAspect
            posY = (contextSize.height - cropHeight) / 2
        } else if to.width < to.height { //Portrait
            cropHeight = contextSize.height
            cropWidth = contextSize.height * cropAspect
            posX = (contextSize.width - cropWidth) / 2
        } else { //Square
            if contextSize.width >= contextSize.height { //Square on landscape (or square)
                cropHeight = contextSize.height
                cropWidth = contextSize.height * cropAspect
                posX = (contextSize.width - cropWidth) / 2
            }else{ //Square on portrait
                cropWidth = contextSize.width
                cropHeight = contextSize.width / cropAspect
                posY = (contextSize.height - cropHeight) / 2
            }
        }
        
        let rect: CGRect = CGRect.init(x:posX, y:posY, width: cropWidth, height: cropHeight)
        
        // Create bitmap image from context using the rect
        
        let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!
        
        // let imageReference: CGImage =
        
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        
        let cropped: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        
        UIGraphicsBeginImageContextWithOptions(to, true, self.scale)
        cropped.draw(in: CGRect.init(x: 0, y: 0,width:  to.width, height: to.height))
        let resized = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resized!
    }
}


extension AddViewController {
    
    func detectScene(image: CIImage) {
        // answerLabel.text = "detecting scene..."
        
        // Load the ML model through its generated class
        guard let model = try? VNCoreMLModel(for: Resnet50().model) else {
            fatalError("can't load Places ML model")
        }
        
        
        let request = VNCoreMLRequest(model: model) { [weak self] request, error in
            guard let results = request.results as? [VNClassificationObservation],
                let topResult = results.first else {
                    fatalError("unexpected result type from VNCoreMLRequest")
            }
            
            // Update UI on main queue
            DispatchQueue.main.async {  [weak self] in
                
                // self?.detectionLabel.text = "\(Int(topResult.confidence * 100))% \(topResult.identifier)"
                
                
                var something:String!
                
                something = topResult.identifier
                var token = something.components(separatedBy: ", ")
                print(token[0])
                print(something)
                
                var firstFix: String!
                firstFix = token[0]
                var secondFix: String!
                //secondFix =  firstFix.replacingOccurrences(of: " ", with: "%20")
                
                
                
                self?.itemName.text = firstFix
                
                //self?.detectionLabel.text = "\(Int(topResult.confidence * 100))% \(token[0])"
                
                
            }
        }
        
        
        let handler = VNImageRequestHandler(ciImage: image)
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([request])
            } catch {
                print(error)
            }
        }
    }
}

