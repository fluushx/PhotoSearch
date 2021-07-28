//
//  PhotoSearchTableViewCell.swift
//  PhotoSearchAgain
//
//  Created by Felipe Ignacio Zapata Riffo on 27-07-21.
//

import UIKit
import SDWebImage

class PhotoSearchTableViewCell: UITableViewCell {
    @IBOutlet var imageView_: UIImageView?
 

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView_?.contentMode = .scaleAspectFill
        imageView_?.clipsToBounds = true
    }
    
     
  
    
}
