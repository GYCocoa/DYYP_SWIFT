//
//  GYCommunityHomeTableCell.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/13.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYCommunityHomeTableCell: UITableViewCell {
/// 132 + imageH
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var headerImgView: UIImageView!
    @IBOutlet weak var nickNameL: UILabel!
    @IBOutlet weak var timeL: UILabel!
    @IBOutlet weak var contentL: UILabel!
    @IBOutlet weak var bodyImgView: UIImageView!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var collectionBtn: UIButton!
    @IBOutlet weak var pariseBtn: UIButton!
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
        
        
    }
    /*
     var comments:Int?
     var content:String?
     var ctime:String?
     var icon:String?
     var isKeep:Int?
     var isLike:Int?
     var isTurn:Int?
     var likes:Int?
     var nickName:String?
     var picture:NSDictionary?
     var tid:Int?
     var tname:String?
     var uid:Int?
     var wid:Int?
     var isFollow:Int?
     */
    var communityModel:GYCommunityModel? {
        didSet {
            let con = communityModel?.content  != nil ? communityModel?.content : ""
            let tn = communityModel?.tname  != nil ? communityModel?.tname : ""
            let content = NSString(string: (con)! + "#" + (tn)! + "#")
            let attri = NSMutableAttributedString.init(string: content as String)
            let s = NSString(string: "#\(tn!)#")
            let range = content.range(of: s as String)
            attri.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.globalMainColor(), range: range)
            contentL.attributedText = attri
            
            if communityModel?.icon != nil {
                headerImgView.sd_setImage(with: NSURL(string: (communityModel?.icon)!) as URL?, placeholderImage: UIImage.init(named: imageView_nodata))
            }
            nickNameL.text = communityModel?.nickName
            timeL.text = communityModel?.ctime
            if let arr = communityModel?.picture {
                let url = arr["imgUrl"] as? String
                bodyImgView.sd_setImage(with: NSURL(string: url!) as URL?, placeholderImage: UIImage.init(named: imageView_nodata))
            }
            commentBtn.setTitle("\(communityModel!.comments!)", for: UIControl.State.normal)
            pariseBtn.setTitle("\(communityModel!.likes!)", for: UIControl.State.normal)
            if communityModel?.isKeep == 0 { // not colletion
                collectionBtn.setImage(UIImage.init(named: "commond_love"), for: UIControl.State.normal)
            }else{
                collectionBtn.setImage(UIImage.init(named: "commond_inlove"), for: UIControl.State.normal)
            }
            if communityModel?.isLike == 0 { // not praise
                pariseBtn.setImage(UIImage.init(named: "blackzan"), for: UIControl.State.normal)
            }else{
                pariseBtn.setImage(UIImage.init(named: "bigzan"), for: UIControl.State.normal)
            }
        }
    }
    
    
    
}
