//
//  PhotoCell.swift
//  Tumblr
//
//  Created by Felipe De La Torre on 10/9/18.
//  Copyright © 2018 Felipe De La Torre. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    // Configure YourCustomCell using the outlets that you've defined.
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
