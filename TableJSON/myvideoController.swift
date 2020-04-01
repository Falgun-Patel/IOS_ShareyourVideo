//
//  myvideoController.swift
//  TableJSON
//
//  Created by Falgun Patel on 4/3/18.
//  Copyright © 2018 Falgun Patel. All rights reserved.
//

import UIKit

class myvideoController: UIViewController ,UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableview: UITableView!
    
    var articles = [Article]()
    
    override func viewDidLoad() {
        fetchArticles()
        
        super.viewDidLoad()
        
        
    }
    
    
    
    
    func fetchArticles(){
        let urlRequest = URLRequest(url: URL(string: "https://shareurvideo.000webhostapp.com/json/historyapp.json")!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            if error != nil {
                print(error)
                return
            }
            
            self.articles = [Article]()
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                if let articlesFromJson = json["PP"] as? [[String : Any]] {
                    for articleFromJson in articlesFromJson {
                        let article = Article()
                        if let title = articleFromJson["firstname"] as? String, let author = articleFromJson["lastname"] as? String, let desc = articleFromJson["owner"] as? String , let url = articleFromJson["likee"] as? String, let urlToImage = articleFromJson["poster"] as? String,let file = articleFromJson["file"] as? String {
                            
                            article.author = author
                            article.desc = desc
                            article.headline = title
                            article.url = url
                            article.imageUrl = urlToImage
                            article.file = file
                        }
                        self.articles.append(article)
                    }
                }
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
                
            } catch let error {
                print(error)
            }
            
            
        }
        
        task.resume()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myvideo", for: indexPath) as! myvideoCell
        
        cell.lblFoodName?.text = self.articles[indexPath.item].headline
        cell.lblDescription?.text = self.articles[indexPath.item].file
        
        cell.imageViewFood?.downloadImagehdm(from: (self.articles[indexPath.item].imageUrl!))
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    
    //click video player open
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "webview") as! webview
        
        vc.nameTodisplay = "https://shareurvideo.000webhostapp.com/video/" + articles[indexPath.row].file! as! String
        present(vc, animated: true, completion: nil)
        
    }
    
    
    
}


extension UIImageView {
    
    func downloadImagehdm(from url: String){
        
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            
            if error != nil {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}






