//
//  MainPageViewController.swift
//  InstagramApp
//
//  Created by Isaac on 10/2/18.
//  Copyright © 2018 Isaac. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class MainPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var posts : [Post] = []
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var composeButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        
        self.tableView.reloadData()
        fetchPosts()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func OnCompose(_ sender: Any) {
        self.performSegue(withIdentifier: "photoSegue", sender: nil)
    }
    
    @IBAction func OnLogout(_ sender: Any) {
       NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
       self.performSegue(withIdentifier: "logoutSegue", sender: nil)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        
        let caption = post.caption
        
        cell.postCaption.text = caption
        
        if let imageFile: PFFile = post.media {
            imageFile.getDataInBackground(block: {(data, error) in
                if error == nil {
                    DispatchQueue.main.async {
                        let image = UIImage(data: data!)
                        cell.postImage.image = image
                    }
                } else{
                    print(error!.localizedDescription)
                }
            })
        }
        return cell
    }
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        fetchPosts()
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func fetchPosts(){
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.limit = 20
        
        // fetch data asynchronously
        query?.findObjectsInBackground { (Post, error: Error?) -> Void in
            if let posts = Post {
                self.posts = posts as! [Post]
                self.tableView.reloadData()
            } else {
                print("fetch failed")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let detailViewController = segue.destination as? DetailViewController{
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell){
                let post = posts[indexPath.row]
                detailViewController.post = post
            
                let postCell = sender as! PostCell
                detailViewController.postImage = postCell.postImage.image!
            }
        }
        
        
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
