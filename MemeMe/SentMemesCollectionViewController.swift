//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Ashish Patel on 3/18/15.
//  Copyright (c) 2015 Average Techie. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var memes: [Meme]!
    
    @IBOutlet weak var memeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        memes = appDelegate.memes
        
        memeCollectionView.delegate = self
        memeCollectionView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -UICollectionView methods
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("memecollectioncell", forIndexPath: indexPath)as! MemeCollectionViewCell
        
        cell.memeImageView.image = self.memes[indexPath.row].memeImage
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //code only push viewcontroller
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var memeDetailsVC = storyboard.instantiateViewControllerWithIdentifier("memedetailsvc")as! MemeDetailsViewController
        memeDetailsVC.meme = self.memes[indexPath.row]
        self.navigationController?.pushViewController(memeDetailsVC, animated: true)
    }
    
    
    @IBAction func addNewMemeButtonClicked(sender: AnyObject) {
        
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
