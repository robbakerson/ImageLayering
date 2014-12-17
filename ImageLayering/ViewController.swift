//
//  ViewController.swift
//  ImageLayering
//
//  Created by Robb.Akerson on 12/17/14.
//  Copyright (c) 2014 com.target.internal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var pickImageBtn: UIView!
    @IBOutlet var saveImageBtn: UIView!
    @IBOutlet weak var baseImage: UIImageView!
    @IBOutlet weak var overlayImage: UIImageView!
    @IBOutlet weak var previewImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func pickImage(sender: AnyObject) {
        var imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        imagePickerController.allowsEditing = true
        self.presentViewController(imagePickerController, animated: true, completion: { imageP in
            
        })
        
    }
    @IBAction func saveImage(sender: AnyObject) {
        println("save image")
        var bottomImage:UIImage = baseImage.image! //background image
        var imageTop:UIImage  = overlayImage.image!    //top image
 
        var newSize = CGSizeMake(bottomImage.size.width, bottomImage.size.height)
        UIGraphicsBeginImageContext( newSize )
        
        // Draw the bottom Image
        bottomImage.drawInRect(CGRectMake(0,0,newSize.width,newSize.height))
        
        // Overlay the top Image
        imageTop.drawInRect(CGRectMake(0,0,bottomImage.size.width,bottomImage.size.height), blendMode:kCGBlendModeNormal, alpha:1.0)
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

