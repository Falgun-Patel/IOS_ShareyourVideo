//
//  newswebController.swift
//  TableJSON
//
//  Created by Falgun Patel on 4/3/18.
//  Copyright © 2018 Falgun Patel. All rights reserved.
//

import UIKit

class newswebController: UIViewController {
@IBOutlet weak var newsweb: UIWebView?
    @IBOutlet weak var newswe: UIWebView?
    var nameToDisplay = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newswe?.loadRequest(NSURLRequest(url: NSURL(string: "https://www.google.com")! as URL) as URLRequest)
print(nameToDisplay)
        newsweb?.loadRequest(NSURLRequest(url: NSURL(string: nameToDisplay)! as URL) as URLRequest)
        
    }

   
}
