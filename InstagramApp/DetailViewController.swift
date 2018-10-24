//
//  DetailViewController.swift
//  InstagramApp
//
//  Created by Isaac on 10/23/18.
//  Copyright © 2018 Isaac. All rights reserved.
//

import UIKit
import Parse

class DetailViewController: ViewController {
    
    var post: PFObject!
    var postImage : UIImage!
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        detailImage.image = postImage
        self.timestampLabel.text = post["timestamp"] as? String
        self.captionLabel.text = post["caption"] as? String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
