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
    @IBOutlet weak var starViews: GYStarRateView!
    
    var commentLayout:UICollectionViewFlowLayout?
    var browser:XLPhotoBrowser?
    var currentCollectuinView:UICollectionView?
    
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
            starViews.scoreCount = Float((model?.score)!)
            nickNameL.text = model?.userName
            contentL.text = model?.content
            let timeStamp = NSData.stringToTimeStamp(stringTime: (model?.evaluateData)!, second: true)
            timeL.text = NSData.timeStampToString(timeStamp: timeStamp, second: false)
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
                let timeStamp = NSData.stringToTimeStamp(stringTime: (model?.evaluateData)!, second: true)
                let timeString = NSData.timeStampToString(timeStamp: timeStamp, second: false)
                let timeArr = timeString.components(separatedBy: "-")

                let appendTimeStamp = NSData.stringToTimeStamp(stringTime: (model?.appendCommentTime)!, second: true)
                let appendTimeString = NSData.timeStampToString(timeStamp: appendTimeStamp, second: false)
                let appendTimeArr = appendTimeString.components(separatedBy: "-")
                
                if timeArr[1] == appendTimeArr[1] {
                    commentTimeL.text = "用户当天追评"
                }else{
                    commentTimeL.text = appendTimeString
                }
                replyContentL.text = model?.appendComment
            }
        }
    }
}

extension GYShopDetailTableCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,XLPhotoBrowserDelegate, XLPhotoBrowserDatasource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == commentCollectionView {
            if model?.imgs != nil && model?.imgs?.count != 0  {
                return (model?.imgs?.count)!
            }
            return 0
        }
        if model?.appendImgs != nil && model?.appendImgs?.count != 0 {
            return (model?.appendImgs?.count)!
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == commentCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: shopDetailCVId, for: indexPath) as! GYShopDetailCommentCVCell
            if model?.imgs != nil && model?.imgs?.count != 0  {
                cell.imageString = model?.imgs![indexPath.row] as? String
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: shopDetailReplyCVId, for: indexPath) as! GYShopDetailCommentCVCell
            if model?.appendImgs != nil && model?.appendImgs?.count != 0 {
                cell.imageString = model?.appendImgs![indexPath.row] as? String
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var array = NSArray()
        if collectionView == commentCollectionView {
            currentCollectuinView = commentCollectionView
            array = model!.imgs!
        }else{
            currentCollectuinView = replyCommentCollectionView
            array = model!.appendImgs!
        }
        self.browser = XLPhotoBrowser.show(withCurrentImageIndex: indexPath.row, imageCount: UInt(array.count), datasource: self)
        self.browser?.pageDotColor = UIColor.white
        self.browser?.currentPageDotColor = UIColor.orange
        self.browser?.pageControlStyle = XLPhotoBrowserPageControlStyle.classic
        self.browser?.action(withTitle: "", delegate: self, cancelButtonTitle: "", deleteButtonTitle: "", otherButtonTitles: "保存图片")
    }
    func photoBrowser(_ browser: XLPhotoBrowser!, highQualityImageURLFor index: Int) -> URL! {
        var array = NSArray()
        if currentCollectuinView == commentCollectionView {
            array = model!.imgs!
        }else{
            array = model!.appendImgs!
        }
        return NSURL.init(string: array[index] as! String)! as URL
        
    }
    func photoBrowser(_ browser: XLPhotoBrowser!, clickActionSheetIndex actionSheetindex: Int, currentImageIndex: Int) {
        switch actionSheetindex {
        case 0:
            browser.saveCurrentShowImage()
        default:
            break
        }
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
