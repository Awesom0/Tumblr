//
//  PhotoDetailsViewController.swift
//  Tumblr
//
//  Created by Felipe De La Torre on 10/10/18.
//  Copyright © 2018 Felipe De La Torre. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoDetailsViewController: UIViewController {

    
    @IBOutlet weak var detailPhoto: UIImageView!
    var post: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let photos = post!["photos"] as? [[String: Any]] {
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)
            detailPhoto.af_setImage(withURL: url!)
        }
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
