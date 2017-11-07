//
//  GYShopDetailCommentCVCell.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/11/2.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYShopDetailCommentCVCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBOutlet weak var imgView: UIImageView!
    
    
    var imageString:String? {
        didSet {
            if imageString != nil {
                imgView.sd_setImage(with: NSURL(string: imageString!) as URL?, placeholderImage: UIImage(named: imageView_nodata))
            }
        }
    }
    
    
    
}
