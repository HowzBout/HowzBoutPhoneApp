//
//  Utilities.swift
//  HowzBout
//
//  Created by Thomas Annerino on 9/21/17.
//  Copyright © 2017 HowzBout, LLC. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire
import SwiftyJSON

class Utilities {
    let timeout: TimeInterval = 30.0
    
    func GetAllYelpMerchants(term: String, latitude: String, longitude: String, completion : ()->()) -> JSON {
        var response: DataResponse<Any>?
        var finishFlag = 0
        var json = JSON()
        let url = "http://localhost:55175/Yelp/\(term)/\(latitude)/\(longitude)"
        Alamofire.request(url, method: .get).validate().responseJSON { (resp) -> Void in
            response = resp
            
            if resp.result.isSuccess {
                json = JSON(resp.result.value)
                finishFlag = 1
            } else {
                finishFlag = -1
            }
            
//            if (resp.result.value != nil) {
//                json = JSON(resp.result.value)
//            }
//            if let value = resp.result.value {
//                json = JSON(value)
//            }
            
            while finishFlag == 0 {
                RunLoop.current.run(mode: RunLoopMode.defaultRunLoopMode, before: Date.distantFuture)
            }
        }
        completion()
        return json
    }
}

struct RequestType {
    let Post: String
    let Get: String
    let Put: String
    let Delete: String
}
