//
//  GYCommunityChooseCollectionCell.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/24.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYCommunityChooseCollectionCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var contentL: UILabel!
    @IBOutlet weak var parseBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    
    @IBAction func buttonAction(_ sender: UIButton) {
    }
    
    var model:GYCommunityModel? {
        didSet {
            if model?.image != nil {
                imgView.sd_setImage(with: NSURL(string: (model?.image)!) as URL?, placeholderImage: UIImage.init(named: imageView_nodata))
            }
            if model?.tname != nil {
                contentL.text = model?.tname
            }
            if model!.comments != nil {
                commentBtn.setTitle("\(model!.comments!)", for: UIControlState.normal)
            }
            if model?.isLike == 0 { // not praise
                parseBtn.setImage(UIImage.init(named: "zan"), for: UIControlState.normal)
            }else{
                parseBtn.setImage(UIImage.init(named: "inzan"), for: UIControlState.normal)
            }
        }
    }
    
    

}
