//
//  CategorySelectViewController.swift
//  HowzBout
//
//  Created by Thomas Annerino on 9/20/17.
//  Copyright © 2017 HowzBout, LLC. All rights reserved.
//

import UIKit

class CategorySelectViewController: UIViewController {
    
    var longitude:Double = 0.0
    var latitude:Double = 0.0
    
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
}
