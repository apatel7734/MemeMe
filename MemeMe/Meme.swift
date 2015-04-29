//
//  Meme.swift
//  MemeMe
//
//  Created by Ashish Patel on 3/18/15.
//  Copyright (c) 2015 Average Techie. All rights reserved.
//

import Foundation
import UIKit

class Meme {
    let topText: String!
    let bottomText: String!
    let origImage: UIImage!
    let memeImage: UIImage!
    
    init(topText:String, bottomText: String, origImage: UIImage,memeImage: UIImage){
        self.topText = topText
        self.bottomText = bottomText
        self.origImage = origImage
        self.memeImage = memeImage
    }
    
    
}