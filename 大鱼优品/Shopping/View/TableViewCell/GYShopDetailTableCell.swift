//
//  GYShopDetailTableCell.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/26.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

fileprivate let shopDetailCVId = "shopDetailCVId"
fileprivate let shopDetailReplyCVId = "shopDetailReplyCVId"

class GYShopDetailTableCell: UITableViewCell {
    
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
    
    var commentLayout:UICollectionViewFlowLayout?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        commentCollectionView.register(UINib.init(nibName: "GYShopDetailCommentCVCell", bundle: nil), forCellWithReuseIdentifier: shopDetailCVId)
        commentCollectionView.delegate = self
        commentCollectionView.dataSource = self
        
                replyCommentCollectionView.register(UINib.init(nibName: "GYShopDetailCommentCVCell", bundle: nil), forCellWithReuseIdentifier: shopDetailReplyCVId)
                replyCommentCollectionView.delegate = self
                replyCommentCollectionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var model:GYShopDetailComment? {
        didSet {
            if model?.userIcon != nil {
                headerImg?.sd_setImage(with: URL(string:(model?.userIcon)!), placeholderImage: UIImage(named:"image_noda"))
            }
            nickNameL.text = model?.userName
            contentL.text = model?.content
            timeL.text = model?.evaluateData
            if model?.imgs?.count == 0 || model?.imgs == nil {
                commentCVLeft.constant = kWidth - 20
                commentCollectionView.isHidden = true
            }
            if model?.appendCommentTime == nil {
                replyView.isHidden = true
            }else{
                replyView.isHidden = false
                if model?.appendImgs?.count == 0 || model?.appendImgs == nil {
                    replyCVLeft.constant = kWidth - 70
                    replyCommentCollectionView.isHidden = true
                }
                commentTimeL.text = model?.appendCommentTime
                replyContentL.text = model?.appendComment
            }
        }
    }
}

extension GYShopDetailTableCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == replyCommentCollectionView {
//            return 2
//        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == commentCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: shopDetailCVId, for: indexPath) as! GYShopDetailCommentCVCell

            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: shopDetailReplyCVId, for: indexPath) as! GYShopDetailCommentCVCell

            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var imgsMargin:CGFloat = 10
        var appendImgsMargin:CGFloat = 10
        if collectionView == commentCollectionView {
            if model?.imgs?.count == 0 || model?.imgs == nil {
                imgsMargin = 0
            }
            return  CGSize(width: self.commentCollectionView.height - imgsMargin, height: self.commentCollectionView.height - imgsMargin)
        }
        if model?.appendImgs?.count == 0 || model?.appendImgs == nil {
            appendImgsMargin = 0
        }
        return  CGSize(width: self.replyCommentCollectionView.height - appendImgsMargin, height: self.replyCommentCollectionView.height - appendImgsMargin)
    }
}
