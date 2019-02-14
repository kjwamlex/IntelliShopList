//
//  SearchViewController.swift
//  IntelliShopList
//
//  Created by 김준우 on 2017-08-12.
//  Copyright © 2017 김준우. All rights reserved.
//

import UIKit
var requestedItemCellForDetail: Int!
var changedData:Bool!
class searchResultsCell: UITableViewCell {
    
    @IBOutlet var searchResultLabel: UILabel!
    @IBOutlet var priceResultLabel: UILabel!
}

class searchViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var searchField: UITextField!
    
    @IBOutlet var searchTableView: UITableView!
    
    var searchResults: [String] = []
    override func viewDidLoad() {
        searchField.becomeFirstResponder()
        searchField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        if changedData == true {
            searchField.text = ""
            searchResults.removeAll()
            searchTableView.reloadData()
            
        }

    }
    @IBAction func dismissViewController() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let searchItem = searchField.text!
        var filtered = itemTitleHome.filter {
            return $0.range(of: searchItem, options: .caseInsensitive) != nil
        }
        
        
        if searchField.text == "" {
            
            filtered.removeAll()
        }
        searchResults.removeAll()
        searchResults.append(contentsOf: filtered)
        searchTableView.reloadData()
        print(searchResults)
        
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = searchTableView.dequeueReusableCell(withIdentifier: "seachTableViewCell", for: indexPath) as! searchResultsCell

        itemCell.searchResultLabel.text = searchResults[indexPath.row]
        let indexOfItem = itemTitleHome.index(of: searchResults[indexPath.row])
        print(indexOfItem as Int!)
        itemCell.priceResultLabel.text = itemPriceHome[indexOfItem as Int!]
        return itemCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        searchTableView.deselectRow(at: indexPath, animated: true)

        let indexOfItem = itemTitleHome.index(of: searchResults[indexPath.row])
        print(indexOfItem as Int!)
        itemNameFromSearchViewController = itemTitleHome[itemTitleHome.index(of: searchResults[indexPath.row])!]
        itemPriceFromSearchViewController = itemPriceHome[itemTitleHome.index(of: searchResults[indexPath.row])!]
        itemImageFromSearchViewController = itemImageHome[itemTitleHome.index(of: searchResults[indexPath.row])!]
        
    }

}
