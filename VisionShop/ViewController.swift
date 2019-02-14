//
//  ViewController.swift
//  Bixby
//
//  Created by 김준우 on 2017-08-03.
//  Copyright © 2017 김준우. All rights reserved.
//

import UIKit
import Vision

import CoreML

import AVFoundation

import Photos
import SafariServices


class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, SFSafariViewControllerDelegate {
    var session = AVCaptureSession()
    
    var imagePicker: UIImagePickerController!
   
    var launched = true
    var searchItem: String!
    
    @IBOutlet var imageView: UIImageView!
     @IBOutlet var detectionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
    }
    override func viewDidAppear(_ animated: Bool) {
        if launched == true {
            takePhoto()

            launched = false
        }
        
        
        
    }
    
    @IBAction func takePhoto() {
        
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    //MARK: - Saving Image here
    @IBAction func save(_ sender: AnyObject) {
        
        
    }
    
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    //MARK: - Done image capture here
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        
        
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        guard let ciImage = CIImage(image: imageView.image!) else {
            fatalError("couldn't convert UIImage to CIImage")
        }
        self.detectScene(image: ciImage)
        print("done")
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75, execute: {
            //self.searchOnAmazon()
        })
        // searchOnAmazon()
        
    }
    
    @IBAction func detectSceneOnImage() {
        guard let ciImage = CIImage(image: imageView.image!) else {
            fatalError("couldn't convert UIImage to CIImage")
        }
        self.detectScene(image: ciImage)
        
        
    }
    
    @IBAction func searchOnAmazon() {
        
        //https://www.amazon.ca/s/ref=nb_sb_noss_2/133-3171663-1909855?url=search-alias%3Daps&field-keywords=
        let something: String!
        
        something =  "https://www.amazon.ca/s/ref=nb_sb_noss_2/133-3171663-1909855?url=search-alias%3Daps&field-keywords=\(searchItem!)"
        print(something)
        if let url = URL(string: something!) {
            let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
            present(vc, animated: true)
        }
        
    }
    
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        guard let ciImage = CIImage(image: imageView.image!) else {
            fatalError("couldn't convert UIImage to CIImage")
        }
        
        self.detectScene(image: ciImage)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    func detectScene(image: CIImage) {
        
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
            //let article = (self?.vowels.contains(topResult.identifier.first!))! ? "an" : "a"
            print(topResult.identifier)
            print("Yes")
            DispatchQueue.main.async { [weak self] in
                var something:String!
                
                something = topResult.identifier
                
                var token = something.components(separatedBy: ", ")
                print(token[0])
                self?.detectionLabel.text = "\(Int(topResult.confidence * 100))% it's \(token[0])"
                
                
                self?.searchItem = "\(topResult.identifier)"
                var firstFix: String!
                firstFix = token[0]
                var secondFix: String!
                secondFix =  firstFix.replacingOccurrences(of: " ", with: "%20")
                
                
                
                self?.searchItem = secondFix
                //self!.searchItem.trimmingCharacters(in: [" ", ","])
                
                print(self!.searchItem)
                
                
                
                
                
            }
        }
        
        
        
        
    }
    */
    
    
    
}

extension ViewController {
    
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
                secondFix =  firstFix.replacingOccurrences(of: " ", with: "%20")
                
                
                
                self?.searchItem = secondFix
                
                self?.detectionLabel.text = "\(Int(topResult.confidence * 100))% \(token[0])"
                
                
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
