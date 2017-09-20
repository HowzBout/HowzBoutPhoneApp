//
//  DataViewController.swift
//  HowzBout
//
//  Created by Thomas Annerino on 8/23/17.
//  Copyright © 2017 HowzBout, LLC. All rights reserved.
//

import UIKit
import CoreLocation

class DataViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""
    
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var btnHungry: UIButton!
    
    var locationManager: CLLocationManager = CLLocationManager();
    var longitude:Double = 0.0
    var latitude:Double = 0.0


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        longitude = locValue.longitude
        latitude = locValue.latitude
        print(longitude)
        print(latitude)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//    }

   

//    @IBAction func btnHungryClick(_ sender: UIButton) {
//        lblText.text = "I'm Hungry Button Clicked!"
//    }
}

