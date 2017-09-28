//
//  DataViewController.swift
//  HowzBout
//
//  Created by Thomas Annerino on 8/23/17.
//  Copyright © 2017 HowzBout, LLC. All rights reserved.
//

import UIKit
import CoreLocation

class DataViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate {

    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""
    var searchActive: Bool = false
    
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var btnHungry: UIButton!
    @IBOutlet weak var howzBoutSearchBar: UISearchBar!
    
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
        
        // Setup delegate for searchBar
        howzBoutSearchBar.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        longitude = locValue.longitude
        latitude = locValue.latitude
        print(longitude)
        print(latitude)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        print(howzBoutSearchBar.text ?? "")
        howzBoutSearchBar.endEditing(true)
        
        if (searchActive == false) {
            let recommendationViewController = self.storyboard?.instantiateViewController(withIdentifier: "RecommendationController") as! RecommendationController
            recommendationViewController.latitude = String(latitude)
            recommendationViewController.longitude = String(longitude)
            recommendationViewController.term = searchBar.text!
            recommendationViewController.fromSearch = true;
        self.navigationController?.pushViewController(recommendationViewController, animated: true)
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func btnHungryTap(_ sender: Any) {
       
        let categorySelectionViewController = self.storyboard?.instantiateViewController(withIdentifier: "CategorySelectViewController") as! CategorySelectViewController
        categorySelectionViewController.latitude = latitude
        categorySelectionViewController.longitude = longitude
        
        self.navigationController?.pushViewController(categorySelectionViewController, animated: true)
    }
   
    
}

