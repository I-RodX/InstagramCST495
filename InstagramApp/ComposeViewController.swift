//
//  ComposeViewController.swift
//  InstagramApp
//
//  Created by Isaac on 10/4/18.
//  Copyright © 2018 Isaac. All rights reserved.
//

import UIKit
import Parse
import Toucan

class ComposeViewController: UIViewController, UIImagePickerControllerDelegate, UITextViewDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var composeImageView: UIImageView!
    @IBOutlet weak var composeTextView: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
         print("I'm here")
        composeTextView.delegate = self
        composeTextView.text = "Write a caption..."
        composeTextView.font = .systemFont(ofSize: 15)
        composeTextView.textColor = UIColor.lightGray
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPhoto(tapGestureRecognizer:)))
        
        composeImageView.isUserInteractionEnabled = true
        composeImageView.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if composeTextView.textColor == UIColor.lightGray {
            composeTextView.text = nil
            composeTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if composeTextView.text.isEmpty {
            composeTextView.text = "Write a caption..."
            composeTextView.textColor = UIColor.lightGray
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
       
        //let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        // Do something with the images (based on your use case)
        let editedImage = Toucan.Resize.resizeImage(originalImage, size: CGSize(width: 414, height: 414))
        composeImageView.image = editedImage
        composeImageView.contentMode = .scaleAspectFit
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapPhoto(tapGestureRecognizer: UITapGestureRecognizer) {
        print("I'm here")
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
            self.present(vc, animated: true, completion: nil)
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        self.performSegue(withIdentifier: "cancelSegue", sender: nil)
    }
    
    
    @IBAction func didTapShare(_ sender: Any) {
        Post.postUserImage(image: composeImageView.image, withCaption: composeTextView.text){(success, error) in
            if success{
                print("post sucessful")
                self.performSegue(withIdentifier: "shareSegue", sender: nil)
            }
            else if let e = error as NSError?{
                print (e.localizedDescription)
            }
        }
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
