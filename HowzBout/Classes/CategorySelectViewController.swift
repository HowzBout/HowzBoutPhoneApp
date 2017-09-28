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
    
    
    var longitude:Double = 0.0
    var latitude:Double = 0.0
    var priceLevel:Int = 0
    var distance:Int = 24140
    var postal:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // We will simply print out the value here
        print(longitude)
        print(latitude)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCategoryClick(_ sender: Any) {
        
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
        case "recommendation"?:
            let recommendedViewController = segue.destination as! RecommendationController
            recommendedViewController.latitude = String(latitude)
            recommendedViewController.longitude = String(longitude)
            recommendedViewController.priceLevel = priceLevel
            recommendedViewController.distance = distance
            recommendedViewController.postal = postal
        case .none:
            break
        case .some(_):
            break
        }
       
    }
}
