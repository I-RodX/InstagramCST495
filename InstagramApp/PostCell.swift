//
//  PostCell.swift
//  InstagramApp
//
//  Created by Isaac on 10/21/18.
//  Copyright © 2018 Isaac. All rights reserved.
//

import UIKit
import ParseUI

class PostCell: UITableViewCell {

    @IBOutlet weak var postImage: PFImageView!
    @IBOutlet weak var postCaption: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var instagramPost: PFObject! {
        didSet {
            self.postImage.file = instagramPost["image"] as? PFFile
            self.postImage.loadInBackground()
        }
    }
    
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
