//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Ashish Patel on 3/18/15.
//  Copyright (c) 2015 Average Techie. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var memes: [Meme]!
    
    @IBOutlet weak var memeTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memeTableView.delegate = self
        memeTableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        memes = appDelegate.memes
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var selectedRow = 0
    //#pragma mark - UITableViewDelegate methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        selectedRow = indexPath.row
    }
    
    
    //#pragma mark - UITableViewDatasource delegate methods
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("memetablecell") as MemeTableViewCell
        var meme = self.memes[indexPath.row]
        
        cell.memeUITextField.text = "\(meme.topText!) \(meme.bottomText!)"
        cell.memedUIImageView.image = meme.memeImage
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("memes.count = \(memes.count)")
        return memes.count
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "tomemedetailssegue"){
            let destinationVC = segue.destinationViewController as MemeDetailsViewController
            destinationVC.meme = self.memes[selectedRow]
        }
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
