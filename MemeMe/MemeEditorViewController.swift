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
    
    @IBOutlet weak var cameraBarButton: UIBarButtonItem!
    
    @IBOutlet weak var shareBarButton: UIBarButtonItem!
    
    let memeTextAttributes = [NSForegroundColorAttributeName: UIColor(white: 1, alpha: 1),NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)!,NSStrokeColorAttributeName:UIColor(red: 0, green: 0, blue: 0, alpha: 1)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //check if camera available on device.
        if(!UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            cameraBarButton.enabled = false
        }
        shareBarButton.enabled = false
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.subscribeToKeyboardNotifications()
        
        // Do any additional setup after loading the view, typically from a nib.
        topTextField.delegate = self
        topTextField.text = "TOP"
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = .Center
        
        
        bottomTextField.delegate = self
        bottomTextField.text = "BOTTOM"
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.textAlignment = .Center
        
        var alreadyCalled = false
    }
    
    
    @IBAction func saveMemeActionClicked(sender: AnyObject) {
        presentActivityViewController()
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        self.unsubscribeFromKeyboardNotification()
    }
    
    //pragma mark - ImagePickerController methodss
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        println("Did finish picking image")
        memeImageView.image = image
        
        //enable bar button
        shareBarButton.enabled = true
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
    
    //pragma mark textfield methods
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    //check if top textfield is clicked or bottom.
    func isTopTextClicked(textField: UITextField) -> Bool{
        if(textField.restorationIdentifier == "top"){
            return true
        }
        return false
    }
    
    var alreadyCalled = false
    
    //method being called when keyboard is shown.
    func keyboardWillShow(notification: NSNotification){
        if(!alreadyCalled){
            self.view.frame.origin.y = self.view.frame.origin.y  - getKeyboardHeight(notification)
            println("keyboardWillShow Y after = \(self.view.frame.origin.y)")
            alreadyCalled = true
        }
    }
    
    //method being called when keyboard is hidden.
    func keyboardWillHide(notification: NSNotification){
        if(alreadyCalled){
            self.view.frame.origin.y += getKeyboardHeight(notification)
            println("keyboardWillHide Y after = \(self.view.frame.origin.y)")
            alreadyCalled = false
        }
    }
    
    //get keyboard height
    func getKeyboardHeight(notification: NSNotification) -> CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    //subscribe to keyboard hide and show notifications
    func subscribeToKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    //unsubscribe to keyboard hide and show notifications
    func unsubscribeFromKeyboardNotification(){
        NSNotificationCenter.defaultCenter().removeObserver(UIKeyboardWillShowNotification)
        NSNotificationCenter.defaultCenter().removeObserver(UIKeyboardWillHideNotification)
    }
    
    //render view to an image.
    func generateMemedImage() -> UIImage{
        //begin image context
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //end image context
        return memedImage
    }
    
    func presentActivityViewController(){
        var memedImage:UIImage = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        controller.completionWithItemsHandler = {
            (activity,success,items,error) in
            if(success){
                self.saveMeme(memedImage)
            }
        }
        presentViewController(controller, animated: true, completion: nil)
    }
    
    //save meme to shared object.
    func saveMeme(memedImage: UIImage){
        var meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, origImage: memeImageView.image!, memeImage: memedImage)
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as AppDelegate
        appDelegate.memes.append(meme)
    }
    
}

