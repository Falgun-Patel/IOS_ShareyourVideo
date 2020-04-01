//
//  newsController.swift
//  TableJSON
//
//  Created by Falgun Patel on 4/2/18.
//  Copyright © 2018 Falgun Patel. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class newsController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    @IBOutlet weak var tableview: UITableView!
    
    var foods: [[String: Any]] = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Alamofire.request("https://newsapi.org/v2/top-headlines?sources=google-news-ca&apiKey=4f4c6871a463473d90e33f9943b885d6").responseJSON { (response) in
            if let responseValue = response.result.value as! [String: Any]? {
                if let responseFoods = responseValue["articles"] as! [[String: Any]]? {
                    self.foods = responseFoods
                    self.tableview?.reloadData()
                }
            }
        }
        
        
        // Do any additional setup after loading the view.window sleep ma htu
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "news", for: indexPath) as! newsTableViewCell
        if foods.count > 0 {
            let eachFood = foods[indexPath.row]
            cell.title?.text = (eachFood["title"] as? String) ?? ""
            cell.desc?.text = (eachFood["author"] as? String) ?? ""
            cell.author?.text = (eachFood["description"] as? String) ?? ""
            if let imageUrl = eachFood["urlToImage"] as? String {
                Alamofire.request(imageUrl).responseImage(completionHandler: { (response) in
                    print(response)
                    if let image = response.result.value {
                        /*
                         let size = CGSize(width: 1000.0, height: 1000.0)
                         // Scale image to size disregarding aspect ratio
                         let scaledImage = image.af_imageScaled(to: size)
                         */
                        //                        let roundedImage = image.af_imageRounded(withCornerRadius: 100.0)
                        
                        DispatchQueue.main.async {
                            cell.imgView?.image = image
                        }
                    }
                })
            }
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return foods.count
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "newsweb") as! newswebController
        let eeachFood = foods[indexPath.row]

        vc.nameToDisplay = eeachFood["url"] as! String
            present(vc, animated: true, completion: nil)
        
    }
}
