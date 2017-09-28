//
//  RecommendationController.swift
//  HowzBout
//
//  Created by Thomas Annerino on 9/23/17.
//  Copyright © 2017 HowzBout, LLC. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class RecommendationController: UIViewController {
    
    // Control Declarations
    @IBOutlet weak var imgMerchantPic: UIImageView!
    @IBOutlet weak var lblMerchantName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblCityStateZip: UILabel!
    @IBOutlet weak var btnNewPlace: UIButton!
    
    
    
    
    var json: JSON = JSON()
    var latitude:String = ""
    var longitude:String = ""
    var term:String = ""
    var fromSearch: Bool = false
    var distance:Int = 0
    var priceLevel:Int = 0
    var postal:String = "none"
    var rand:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        btnNewPlace.isHidden = true
        if (term == "") {
            term = "pizza"
        }
        LoadYelpData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func LoadYelpData() {
        var response: DataResponse<Any>?
        var url = ""
        if (postal == "") {
            postal = "none"
        }
        if (fromSearch == true) {
            url = "http://localhost:55175/Yelp/search/\(term)/\(latitude)/\(longitude)"
        } else {
            url = "http://localhost:55175/Yelp/\(term)/\(latitude)/\(longitude)/\(priceLevel)/\(distance)/\(postal)"
        }
        print(url)
        Alamofire.request(url, method: .get).validate().responseJSON { (resp) -> Void in
            response = resp
            if resp.result.isSuccess {
                self.json = JSON(resp.result.value!)
                self.rand = Int(arc4random_uniform(20))
                if (Int(self.json["total"].stringValue)! < 20) {
                    var randomizer = Int(self.json["total"].stringValue)! - 1
                    self.rand = Int(arc4random_uniform(UInt32(randomizer)))
                }
                self.DisplayMerchant(randomNumber: self.rand)
            }
        }
    }
    
    @IBAction func btnNewPlaceClick(_ sender: Any) {
        DisplayMerchant(randomNumber: Int(arc4random_uniform(UInt32(self.rand))))
    }
    
    
    func DisplayMerchant(randomNumber: Int) {
        print(json.rawString())
        let picUrl = URL(string: json["businesses"][randomNumber]["image_url"].stringValue)!
        let session = URLSession(configuration: .default)
        let downloadPicTask = session.dataTask(with: picUrl) { (data, response, error) in
            // The download has finished.
            if let e = error {
                print("Error downloading cat picture: \(e)")
            } else {
                // No errors found.
                // It would be weird if we didn't have a response, so check for that too.
                if let res = response as? HTTPURLResponse {
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
                        // Finally convert that Data into an image and do what you wish with it.
                        let image = UIImage(data: imageData)
                        // Do something with your image.
                       DispatchQueue.main.async {
                            self.imgMerchantPic.image = image
                            self.imgMerchantPic.layer.masksToBounds = true
                            self.imgMerchantPic.layer.borderWidth = 1.5
                            self.imgMerchantPic.layer.borderColor = UIColor.black.cgColor
                            self.imgMerchantPic.layer.cornerRadius = 10
                            self.btnNewPlace.isHidden = false
                            }
                        } else {
                            print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }
        
        downloadPicTask.resume()
        
        lblMerchantName.text = json["businesses"][randomNumber]["name"].stringValue
        lblAddress.text = json["businesses"][randomNumber]["location"]["address1"].stringValue
        lblCityStateZip.text = json["businesses"][randomNumber]["location"]["city"].stringValue + ", " + json["businesses"][randomNumber]["location"]["state"].stringValue + " " + json["businesses"][randomNumber]["location"]["zip_code"].stringValue
    }
}
