//
//  GYCommunityTopicCollectionCell.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/24.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYCommunityTopicCollectionCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var tipL: UILabel!
    
    var model:GYCommunityModel? {
        didSet {
            if model?.image != nil {
                imgView.sd_setImage(with: NSURL(string: (model?.image)!) as URL?, placeholderImage: UIImage.init(named: imageView_nodata))
            }
            if model?.tname != nil {
                tipL.text = model?.tname
            }
        }
    }
    
    

}
