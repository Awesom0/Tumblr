//
//  PhotosViewController.swift
//  Tumblr
//
//  Created by Felipe De La Torre on 10/9/18.
//  Copyright © 2018 Felipe De La Torre. All rights reserved.
//

import UIKit
import AlamofireImage

var posts: [[String: Any]] = []

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var posts: [[String: Any]] = []
    var image: UIImage!
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // added for refresh
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(PhotosViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        // end of added refresh
        
        tableView.delegate = self
        tableView.dataSource = self
        fetchPictures()
        
    }
    
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        
        fetchPictures()
        
    }
    
    
    func fetchPictures(){
        // Network request snippet
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        // let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                print(dataDictionary)
                
                // Get the dictionary from the response key
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                // Store the returned array of dictionaries in our posts property
                self.posts = responseDictionary["posts"] as! [[String: Any]]
                
                self.tableView.reloadData() // reloads the tableview
                self.refreshControl.endRefreshing() // needed for refresh function
                
                
            }
        }
        task.resume()
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let post = posts[indexPath.row]
        if let photos = post["photos"] as? [[String: Any]] {  // photos is NOT nil, we can use it!
            
            // get the first photo in photo array
            let photo = photos[0]
            // get the original size dictionary from the photo
            let originalSize = photo["original_size"] as! [String: Any]
            // get the url string from the original size dictionary
            let urlString = originalSize["url"] as! String
            // create a URL using the urlString
            let url = URL(string: urlString)
            
            
            cell.photoImageView.af_setImage(withURL: url!)
            
        }
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! PhotoDetailsViewController
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let post = posts[indexPath.row]
        let photoDetailsViewController = segue.destination as! PhotoDetailsViewController
        photoDetailsViewController.post = post
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
