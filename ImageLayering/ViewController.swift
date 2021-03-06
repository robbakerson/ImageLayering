//
//  ViewController.swift
//  ImageLayering
//
//  Created by Robb.Akerson on 12/17/14.
//  Copyright (c) 2014 com.target.internal. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var currentBorderIndex:Int = 0;
    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!
    @IBOutlet var swipeRight: UISwipeGestureRecognizer!
    @IBOutlet weak var pickImageBtn: UIButton!

    @IBOutlet var saveImageBtn: UIView!
    @IBOutlet weak var fbButton: UIButton!
    @IBOutlet weak var twButton: UIButton!
    
    @IBOutlet weak var cardStage: UIView!
    
    @IBOutlet weak var baseImage: UIImageView!
    @IBOutlet weak var overlayImage: UIImageView!
    
    @IBOutlet weak var overlayText: UITextField!
    var previewImage: UIImageView! = UIImageView();
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func swipeLeft(sender: AnyObject) {
        println("SWIPE LEFT")
        //change the image
        currentBorderIndex++
        if(currentBorderIndex > 7)
        {
            currentBorderIndex = 0;
        }
        //overlayImage.animationDuration
        overlayImage.image = UIImage(named: "TargetCircle_clear-\(currentBorderIndex).png")
        
        
    }
    @IBAction func swipeRight(sender: AnyObject) {
        println("SWIPE Right")
        //change the image
        currentBorderIndex--
        if(currentBorderIndex < 0)
        {
            currentBorderIndex = 7;
        }
        //overlayImage.animationDuration
        overlayImage.image = UIImage(named: "TargetCircle_clear-\(currentBorderIndex).png")
        
        
    }
    

    @IBAction func pickImage(sender: AnyObject) {
        println("PICK IMAGE")
        var imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        imagePickerController.allowsEditing = true
        self.presentViewController(imagePickerController, animated: true, completion: { imageP in
            
        })
        
    }
    @IBAction func saveImage(sender: AnyObject) {
        println("save image")
        //var bottomImage:UIImage = baseImage.image! //background image
        //var imageTop:UIImage  = overlayImage.image!    //top image
 
       //var newSize = CGSizeMake(view.layer.width, bottomImage.size.height)
        UIGraphicsBeginImageContext(cardStage.frame.size )
        
        /// Draw the bottom Image
        //bottomImage.drawInRect(CGRectMake(0,0,newSize.width,newSize.height))
        
        
        
       //`[self.layer renderInContext:UIGraphicsGetCurrentContext()];
        //drawLayer(<#layer: CALayer!#>, inContext: <#CGContext!#>)
        cardStage.layer.renderInContext(UIGraphicsGetCurrentContext())
        
        
        // Overlay the top Image
        //imageTop.drawInRect(CGRectMake(0,0,bottomImage.size.width,bottomImage.size.height), blendMode:kCGBlendModeNormal, alpha:1.0)
        
        var newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        var imageData = UIImagePNGRepresentation(newImage)
        println(newImage)
        previewImage.image = newImage
        
        UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil);

    }
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        let selectedImage : UIImage = image
        baseImage.image = selectedImage
        println(selectedImage)
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func postToFaceBook(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            var facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText("This is an image I created")
            facebookSheet.addImage(previewImage.image)
            self.presentViewController(facebookSheet, animated: true, completion: nil)
        } else {
            var alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    


    @IBAction func twitterButtonPushed(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
            var twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText("This is an image I created")
            twitterSheet.addImage(previewImage.image)
            self.presentViewController(twitterSheet, animated: true, completion: nil)
        } else {
            var alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

