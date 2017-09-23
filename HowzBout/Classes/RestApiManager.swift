//
//  RestApiManager.swift
//  HowzBout
//
//  Created by Thomas Annerino on 9/22/17.
//  Copyright © 2017 HowzBout, LLC. All rights reserved.
//

import Foundation


//typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiManager: NSObject {
    static let sharedRestApi = RestApiManager()
    
    let baseURL = "http://api.randomuser.me"
}
