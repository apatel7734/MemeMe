//
//  MemeEditorViewController
//  MemeMe
//
//  Created by Ashish Patel on 3/13/15.
//  Copyright (c) 2015 Average Techie. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    let memeTextAttributes = [NSStrokeColorAttributeName: UIColor.blackColor(),NSForegroundColorAttributeName: UIColor.whiteColor(),NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,NSStrokeWidthAttributeName: 1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        topTextField.delegate = self
        topTextField.text = "TOP"
        
        //        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.delegate = self
        bottomTextField.text = "BOTTOM"
        
        //        bottomTextField.defaultTextAttributes = memeTextAttributes
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        println("Did finish picking image")
        memeImageView.image = image
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        println("Did cancel picking image")
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //camera button clicked
    @IBAction func cameraImagePicker(sender: AnyObject) {
        self.startImagePicker(UIImagePickerControllerSourceType.Camera)
    }
    
    //photo album button clicked
    @IBAction func photoAlbumImagePicker(sender: AnyObject) {
        self.startImagePicker(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    
    //start ImagePicker to pick an image from camera OR Photo Library
    func startImagePicker(sourceType: UIImagePickerControllerSourceType){
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        //        if(textField.text == "TOP" || textField.text == "BOTTOM"){
        //            textField.text = ""
        //        }
    }
    
    
    func isTopTextClicked(textField: UITextField) -> Bool{
        if(textField.restorationIdentifier == "top"){
            return true
        }
        return false
    }
    
    
    
    
}

