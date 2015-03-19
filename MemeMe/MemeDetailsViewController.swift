//
//  MemeDetailsViewController.swift
//  MemeMe
//
//  Created by Ashish Patel on 3/18/15.
//  Copyright (c) 2015 Average Techie. All rights reserved.
//

import UIKit

class MemeDetailsViewController: UIViewController {

    @IBOutlet weak var memeImageView: UIImageView!
    var meme: Meme!
    
    override func viewDidLoad() {
        if let memeImage = meme.memeImage?{
            self.memeImageView.image = memeImage
        }
    }
}
