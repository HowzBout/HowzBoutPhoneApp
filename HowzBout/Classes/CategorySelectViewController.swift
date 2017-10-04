//
//  CategorySelectViewController.swift
//  HowzBout
//
//  Created by Thomas Annerino on 9/20/17.
//  Copyright © 2017 HowzBout, LLC. All rights reserved.
//

import UIKit
import SwiftyJSON

class CategorySelectViewController: UIViewController {
    
    
    // Control Declarations
    @IBOutlet weak var btnMileMin: UIButton!
    @IBOutlet weak var btnMileMid: UIButton!
    @IBOutlet weak var btnMileMax: UIButton!
    @IBOutlet weak var txtZipCode: UITextField!
    @IBOutlet weak var btnPriceOne: UIButton!
    @IBOutlet weak var btnPriceTwo: UIButton!
    @IBOutlet weak var btnPriceThree: UIButton!
    @IBOutlet weak var btnPriceFour: UIButton!
    @IBOutlet weak var btnFirstCategory: UIButton!
    @IBOutlet weak var btnSecondCategory: UIButton!
    @IBOutlet weak var btnThirdCategory: UIButton!
    
    
    var longitude:Double = 0.0
    var latitude:Double = 0.0
    var priceLevel:Int = 0
    var distance:Int = 24140
    var postal:String = ""
    var term = ""
    
    // Category Array (hard coded for now)
    var categories: [String: String] = ["Afghan": "afghani", "African": "african", "American (New)": "newamerican", "American (Traditional)": "tradamerican", "Arabian": "arabian", "Argentine": "argentine", "Barbeque": "bbq", "Caribbean": "caribbean", "Pizza": "pizza"]
    
    var categoriesLookup: [String] = ["Afghan", "African", "American (New)", "American (Traditional)", "Arabian", "Argentine", "Barbeque", "Caribbean", "Pizza"]
    
    var selectedCat = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // We will simply print out the value here
        print(longitude)
        print(latitude)
        SetupButtons()
    }
    
    func SetupButtons() {
        let num1:UInt32 = randomNumber()
        var num2:UInt32
        var num3:UInt32
        
        num2 = randomNumber()
        num3 = randomNumber()
        
        while num2 == num3 {
            num3 = randomNumber()
        }
        
        
        btnFirstCategory.setTitle(categoriesLookup[Int(num1)], for: UIControlState.normal)
        btnFirstCategory.accessibilityIdentifier = categories[categoriesLookup[Int(num1)]]
        
        btnSecondCategory.setTitle(categoriesLookup[Int(num2)], for: UIControlState.normal)
        btnSecondCategory.accessibilityIdentifier = categories[categoriesLookup[Int(num2)]]
        
        btnThirdCategory.setTitle(categoriesLookup[Int(num3)], for: UIControlState.normal)
        btnThirdCategory.accessibilityIdentifier = categories[categoriesLookup[Int(num3)]]
        
    }
    
    var previousNumber: UInt32? // used in randomNumber()
    
    func randomNumber() -> UInt32 {
        var randomNumber = arc4random_uniform(9)
        while previousNumber == randomNumber {
            randomNumber = arc4random_uniform(9)
        }
        previousNumber = randomNumber
        return randomNumber
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCategoryClick(_ sender: UIButton) {
        selectedCat = sender.accessibilityIdentifier!
    }
    
    
    @IBAction func btnMileMinClick(_ sender: Any) {
        btnMileMid.isSelected = false
        btnMileMax.isSelected = false
        btnMileMin.isSelected = true
        distance = 1609
    }
    
    @IBAction func btnMileMidClick(_ sender: Any) {
        btnMileMid.isSelected = true
        btnMileMax.isSelected = false
        btnMileMin.isSelected = false
        distance = 8046
    }
    
    @IBAction func btnMileMaxClick(_ sender: Any) {
        btnMileMid.isSelected = false
        btnMileMax.isSelected = true
        btnMileMin.isSelected = false
        distance = 16093
    }
    
    @IBAction func PriceLevelFilterSet(_ sender: UIButton) {
        switch sender.accessibilityIdentifier {
        case "1"?:
            priceLevel = 1
            btnPriceOne.isSelected = true
            btnPriceTwo.isSelected = false
            btnPriceThree.isSelected = false
            btnPriceFour.isSelected = false
        case "2"?:
            priceLevel = 2
            btnPriceOne.isSelected = false
            btnPriceTwo.isSelected = true
            btnPriceThree.isSelected = false
            btnPriceFour.isSelected = false
        case "3"?:
            priceLevel = 3
            btnPriceOne.isSelected = false
            btnPriceTwo.isSelected = false
            btnPriceThree.isSelected = true
            btnPriceFour.isSelected = false
        case "4"?:
            priceLevel = 4
            btnPriceOne.isSelected = false
            btnPriceTwo.isSelected = false
            btnPriceThree.isSelected = false
            btnPriceFour.isSelected = true
        case .none:
            break
        case .some(_):
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {   
        
        switch segue.identifier {
        case "cat1"?,
             "cat2"?,
             "cat3"?:
            let recommendedViewController = segue.destination as! RecommendationController
            recommendedViewController.latitude = String(latitude)
            recommendedViewController.longitude = String(longitude)
            recommendedViewController.priceLevel = priceLevel
            recommendedViewController.distance = distance
            recommendedViewController.postal = postal
            recommendedViewController.term = selectedCat
        case .none:
            break
        case .some(_):
            break
        }
       
    }
}
