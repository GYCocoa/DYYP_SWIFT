//
//  GYMineHeaderView.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/25.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYMineHeaderView: UIView {

    @IBOutlet weak var daifukuan: UIButton!
    @IBOutlet weak var daichengtuan: UIButton!
    @IBOutlet weak var daifahuo: UIButton!
    @IBOutlet weak var daishouhuo: UIButton!
    @IBOutlet weak var daipingjia: UIButton!
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var profileL: UILabel!
    
    @IBOutlet weak var sexImage: UIImageView!
    @IBOutlet weak var tieziBtn: UIButton!
    @IBOutlet weak var followBtn: UIButton!
    
    @IBOutlet weak var fansBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headerImage.layer.cornerRadius = headerImage.width/2
        
        daifukuan?.titleEdgeInsets = UIEdgeInsetsMake((daifukuan?.imageView?.frame.size.height)! ,-(daifukuan?.imageView?.frame.size.width)!, 0,0)
        daifukuan?.imageEdgeInsets = UIEdgeInsetsMake(-15,0, 0,-(daifukuan?.imageView?.frame.size.width)!)
        
        daichengtuan?.titleEdgeInsets = UIEdgeInsetsMake((daichengtuan?.imageView?.frame.size.height)! ,-(daichengtuan?.imageView?.frame.size.width)!, 0,0)
        daichengtuan?.imageEdgeInsets = UIEdgeInsetsMake(-15,0, 0,-(daichengtuan?.imageView?.frame.size.width)!)
        
        daifahuo?.titleEdgeInsets = UIEdgeInsetsMake((daifahuo?.imageView?.frame.size.height)! ,-(daifahuo?.imageView?.frame.size.width)!, 0,0)
        daifahuo?.imageEdgeInsets = UIEdgeInsetsMake(-15,0, 0,-(daifahuo?.imageView?.frame.size.width)!)
        
        daishouhuo?.titleEdgeInsets = UIEdgeInsetsMake((daishouhuo?.imageView?.frame.size.height)! ,-(daishouhuo?.imageView?.frame.size.width)!, 0,0)
        daishouhuo?.imageEdgeInsets = UIEdgeInsetsMake(-15,0, 0,-(daishouhuo?.imageView?.frame.size.width)!)
        
        daipingjia?.titleEdgeInsets = UIEdgeInsetsMake((daipingjia?.imageView?.frame.size.height)! ,-(daipingjia?.imageView?.frame.size.width)!, 0,0)
        daipingjia?.imageEdgeInsets = UIEdgeInsetsMake(-15,0, 0,-(daipingjia?.imageView?.frame.size.width)!)
        
    }
    
    class func headerView() -> GYMineHeaderView {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.last as! GYMineHeaderView
    }

}
