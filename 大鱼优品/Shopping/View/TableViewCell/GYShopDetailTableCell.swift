//
//  GYShopDetailTableCell.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/26.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYShopDetailTableCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var headerImg: UIImageView!
    @IBOutlet weak var nickNameL: UILabel!
    @IBOutlet weak var contentL: UILabel!
    @IBOutlet weak var timeL: UILabel!
    @IBOutlet weak var commentCollectionView: UICollectionView!
    @IBOutlet weak var commentCVLeft: NSLayoutConstraint!

    @IBOutlet weak var replyView: UIView!
    @IBOutlet weak var commentTimeL: UILabel!
    @IBOutlet weak var replyContentL: UILabel!
    @IBOutlet weak var replyCommentCollectionView: UICollectionView!
    @IBOutlet weak var replyCVLeft: NSLayoutConstraint!
    
    @IBOutlet weak var styleL: UILabel!
    
    var model:GYShopDetailComment? {
        didSet {
            if model?.userIcon != nil {
                headerImg?.sd_setImage(with: URL(string:(model?.userIcon)!), placeholderImage: UIImage(named:"image_noda"))
            }
            nickNameL.text = model?.userName
            contentL.text = model?.content
            timeL.text = model?.evaluateData
            if model?.imgs?.count == 0 || model?.imgs == nil {
                commentCVLeft.constant = kWidth
            }
            if model?.appendCommentTime == nil {
                replyView.isHidden = true
            }else{
                replyView.isHidden = false
                if model?.appendImgs?.count == 0 || model?.appendImgs == nil {
                    replyCVLeft.constant = kWidth
                }
                commentTimeL.text = model?.appendCommentTime
                replyContentL.text = model?.appendComment
            }
        }
    }
    
    
}
