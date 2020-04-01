//
//  webview.swift
//  TableJSON
//
//  Created by Falgun Patel on 3/21/18.
//  Copyright © 2018 Falgun Patel. All rights reserved.
//
protocol PlayerVCDelegate {
    func didMinimize()
    func didmaximize()
  
}
enum stateOfVC {
    case minimized
    case fullScreen
    case hidden
}

import UIKit
import AVKit
import  AVFoundation
import Photos
class webview: UIViewController ,AVPlayerViewControllerDelegate, UITableViewDelegate, UITableViewDataSource{
  
  @IBOutlet var falgun: [UIWebView]!
  
   @IBOutlet weak var minimizeButton: UIButton!
  

    var delegate: PlayerVCDelegate?
    var state = stateOfVC.hidden
    
    
    
   @IBOutlet weak var commentweb: UIWebView!
    var articles = [Article]()
    @IBOutlet weak var videoview: UIView!
    @IBOutlet weak var webb: UIWebView!
@IBOutlet weak var sugetable: UITableView!
    @IBOutlet weak var durationtimelable: UILabel!
    @IBOutlet weak var currenttimelable: UILabel!
    @IBOutlet weak var timeslider: UISlider!
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    var isVideoPlaying = false
 
    var nameTodisplay = String()
    
    ////
    override func viewDidLoad() {
        super.viewDidLoad()
       
     
        
        
        
        
        webb.loadRequest(NSURLRequest(url: NSURL(string: "https://www.google.com")! as URL) as URLRequest)
        commentweb.loadRequest(NSURLRequest(url: NSURL(string: "https://www.google.com")! as URL) as URLRequest)
        fetchArticles()
        print(nameTodisplay)
       self.sugetable.rowHeight = 120.0
        let videoURL = URL(string: nameTodisplay.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
         player = AVPlayer(url: videoURL!)
        addTimeObserver()
   playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resize
        player.currentItem?.addObserver(self, forKeyPath: "duration", options: [.new, .initial], context: nil)
        
        videoview.layer.addSublayer(playerLayer)
    }
    
    //
    func tableView(_ sugetable: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.articles.count
        
    }
    //
    //
    func downloadVideoLinkAndCreateAsset(_ videoLink: String) {
        print("fufufufufu**")
        let imageView = UIImageView(frame: CGRect(x: 148,y: 8, width: 40, height: 40))
        imageView.image = #imageLiteral(resourceName: "thumb")
        
        
        
       
        
        // use guard to make sure you have a valid url
        guard let videoURL = URL(string: videoLink) else { return }
        
        guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        // check if the file already exist at the destination folder if you don't want to download it twice
        if !FileManager.default.fileExists(atPath: documentsDirectoryURL.appendingPathComponent(videoURL.lastPathComponent).path) {
            
            // set up your download task
            URLSession.shared.downloadTask(with: videoURL) { (location, response, error) -> Void in
                
                // use guard to unwrap your optional url
                guard let location = location else { return }
                
                // create a deatination url with the server response suggested file name
                let destinationURL = documentsDirectoryURL.appendingPathComponent(response?.suggestedFilename ?? videoURL.lastPathComponent)
                
                do {
                    
                    try FileManager.default.moveItem(at: location, to: destinationURL)
                    
                    PHPhotoLibrary.requestAuthorization({ (authorizationStatus: PHAuthorizationStatus) -> Void in
                        
                        // check if user authorized access photos for your app
                        if authorizationStatus == .authorized {
                            PHPhotoLibrary.shared().performChanges({
                                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: destinationURL)}) { completed, error in
                                    if completed {
                                        
                                        let alert = UIAlertController(title: "@", message: "It's recommended you bring your towel before continuing.", preferredStyle: .alert)
                                        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                                        alert.view.addSubview(imageView)
                                        self.present(alert, animated: true)
                                        print("Video asset created")
                                        
                                        
                                        
                                    } else {
                                        print(error)
                                    }
                            }
                        }
                    })
                    
                } catch { print(error) }
                
                }.resume()
            
        } else {
            print("File already exists at destination url")
        }
        
    }
////
    @IBAction func back(_ sender: UIButton) {
       
        
    }
    @IBAction func handler(_ sender: UIButton) {
        falgun.forEach { (webview) in webview.isHidden = !webview.isHidden }
      
        if commentweb.isHidden == true {
            sugetable.isHidden = false
            sender.setTitle("Commnets",for: .highlighted)

        } else if commentweb.isHidden == false {
            sugetable.isHidden = true
            
        }
        
    }
    
    @IBAction func download(_ sender: UIButton) {
        downloadVideoLinkAndCreateAsset("https://shareurvideo.000webhostapp.com/video/" + nameTodisplay)

    }
    @IBAction func sharee(_ sender: Any){
        let text = "good night";
        let URL = "https://shareurvideo.000webhostapp.com/video/" + nameTodisplay;
        print(URL)
        let vcc = UIActivityViewController(activityItems: [text,URL], applicationActivities: [])
        
        if let popoverController = vcc.popoverPresentationController{
            popoverController.sourceView = self.view
            popoverController.sourceRect = self.view.bounds
            
        }
        self.present(vcc,animated: true, completion: nil)
    }
    //
    func tableView(_ sugetable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = sugetable.dequeueReusableCell(withIdentifier: "suggested", for: indexPath) as!
        videosuges
       
        
        cell.sugelbl?.text = self.articles[indexPath.item].headline!
        cell.sugelbll?.text = self.articles[indexPath.item].desc! + "·view:" +  self.articles[indexPath.item].view!
        cell.sugeimage?.downloadImagee(from: (self.articles[indexPath.item].imageUrl!))
            return cell
        
        
            
    
    }
    
   
    func numberOfSections(in sugetable: UITableView) -> Int {
        return 1
    }
    
    //click video player open
    func tableView(_ sugetable: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "webview") as! webview
        vc.nameTodisplay = "https://shareurvideo.000webhostapp.com/video/" + articles[indexPath.row].file!
        
        // vc.nameTodisplay = "https://shareurvideo.000webhostapp.com/video/" + //articles[indexPath.row].file! as! String
        present(vc, animated: true, completion: nil)
        
    }
    
    override func viewDidDisappear(_ animated: Bool){
    super.viewDidDisappear(animated)
        player.pause()
        
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
                if let articlesFromJson = json["PP"] as? [[String : AnyObject]] {
                    for articleFromJson in articlesFromJson {
                        let article = Article()
                        if let title = articleFromJson["firstname"] as? String, let author = articleFromJson["lastname"] as? String, let desc = articleFromJson["owner"] as? String, let url = articleFromJson["likee"] as? String, let urlToImage = articleFromJson["poster"] as? String,let file = articleFromJson["file"] as? String,
                            let views = articleFromJson["views"] as? String {
                            article.author = author
                            article.desc = desc
                            article.headline = title
                            article.url = url
                            article.imageUrl = urlToImage
                            article.file = file
                                article.view = views
                        }
                        self.articles.append(article)
                    }
                }
                DispatchQueue.main.async {
                    self.sugetable.reloadData()
                }
                
            } catch let error {
                print(error)
            }
            
            
        }
        
        task.resume()
        
    }
    //
    
    override var prefersStatusBarHidden: Bool{return true}
    
  override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = videoview.bounds
    }
   override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player.play()
    }

    
    func addTimeObserver(){
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        let mainQueue = DispatchQueue.main
        _ = player.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue, using: { [weak self] time in
            guard let currentItem = self?.player.currentItem else {return}
            self?.timeslider.maximumValue = Float(currentItem.duration.seconds)
            self?.timeslider.minimumValue = 0
            self?.timeslider.value = Float(currentItem.currentTime().seconds)
            self?.currenttimelable.text = self?.getTimeString(from: currentItem.currentTime())
        })
    }
    
    
    lazy var pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "thumb")
        button.setImage(image, for: .normal)
       
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.isHidden = true
        
        button.addTarget(self, action: #selector(playpress), for: .touchUpInside)
        
        return button
    }()

  
    
    @IBAction func playpress(_ sender: UIButton) {
        if isVideoPlaying{
            
            player.pause()
            pausePlayButton.setImage(UIImage(named: "pause"), for: UIControlState())
        }else{
            player.play()
             pausePlayButton.setImage(UIImage(named: "play"), for: UIControlState())
        }
        isVideoPlaying = !isVideoPlaying
    }
   
    
    
    @IBAction func slidervalusechanged(_ sender: UISlider) {
        
        player.seek(to: CMTimeMake(Int64(sender.value*1000), 1000))
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "duration", let duration = player.currentItem?.duration.seconds, duration > 0.0 {
            self.durationtimelable.text = getTimeString(from: player.currentItem!.duration)
        }
    }
    func getTimeString(from time: CMTime) -> String{
        let totalseconds = CMTimeGetSeconds(time)
        let hours = Int(totalseconds/3600)
        let minutes = Int(totalseconds/60) % 60
        let seconds = Int(totalseconds.truncatingRemainder(dividingBy: 60))
        if hours > 0 {
            return String(format: "%i:%02i:%02i", arguments: [hours,minutes,seconds])
        }else{
            return String(format: "%02i:%02i", arguments: [minutes,seconds])        }
    }
}

   func topMostController() -> UIViewController {
        var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        return topController
    }

 
//
extension UIImageView {
    
    func downloadImagee(from url: String){
        
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
/////////




