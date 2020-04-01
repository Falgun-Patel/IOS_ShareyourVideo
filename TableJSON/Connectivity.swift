//
//  Connectivity.swift
//  TableJSON
//
//  Created by Falgun Patel on 4/2/18.
//  Copyright © 2018 Falgun Patel. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity{
    class func isConnectedToInternet() -> Bool {
        retrun
        NetworkReachabilityManager()!.isReachable
     
    }
}
