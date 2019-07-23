//
//  GYMineHeaderView.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/25.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit


enum ShakeDirection {
    case horizontal
    case vertical
}
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
        
        daifukuan?.titleEdgeInsets = UIEdgeInsets(top: (daifukuan?.imageView?.frame.size.height)! ,left: -(daifukuan?.imageView?.frame.size.width)!, bottom: 0,right: 0)
        daifukuan?.imageEdgeInsets = UIEdgeInsets(top: -15,left: 0, bottom: 0,right: -(daifukuan?.imageView?.frame.size.width)!)
        
        daichengtuan?.titleEdgeInsets = UIEdgeInsets(top: (daichengtuan?.imageView?.frame.size.height)! ,left: -(daichengtuan?.imageView?.frame.size.width)!, bottom: 0,right: 0)
        daichengtuan?.imageEdgeInsets = UIEdgeInsets(top: -15,left: 0, bottom: 0,right: -(daichengtuan?.imageView?.frame.size.width)!)
        
        daifahuo?.titleEdgeInsets = UIEdgeInsets(top: (daifahuo?.imageView?.frame.size.height)! ,left: -(daifahuo?.imageView?.frame.size.width)!, bottom: 0,right: 0)
        daifahuo?.imageEdgeInsets = UIEdgeInsets(top: -15,left: 0, bottom: 0,right: -(daifahuo?.imageView?.frame.size.width)!)
        
        daishouhuo?.titleEdgeInsets = UIEdgeInsets(top: (daishouhuo?.imageView?.frame.size.height)! ,left: -(daishouhuo?.imageView?.frame.size.width)!, bottom: 0,right: 0)
        daishouhuo?.imageEdgeInsets = UIEdgeInsets(top: -15,left: 0, bottom: 0,right: -(daishouhuo?.imageView?.frame.size.width)!)
        
        daipingjia?.titleEdgeInsets = UIEdgeInsets(top: (daipingjia?.imageView?.frame.size.height)! ,left: -(daipingjia?.imageView?.frame.size.width)!, bottom: 0,right: 0)
        daipingjia?.imageEdgeInsets = UIEdgeInsets(top: -15,left: 0, bottom: 0,right: -(daipingjia?.imageView?.frame.size.width)!)
        
        self.shake()
    }
    /// 扩展UIView增加抖动方法
    ///
    /// - Parameters:
    ///   - direction: 抖动方向（默认是水平方向）
    ///   - times: 抖动次数（默认6次）
    ///   - interval: 每次抖动时间（默认0.2秒）
    ///   - delta: 抖动偏移量（默认4）
    ///   - completion: 抖动动画结束后的回调
    public func shake(direction: ShakeDirection = .horizontal, times: Int = 12, interval: TimeInterval = 0.2, delta: CGFloat = 4, completion: (() -> Void)? = nil) {
        //播放动画
        UIView.animate(withDuration: interval, animations: { () -> Void in
            switch direction {
            case .horizontal:
                self.headerImage.layer.setAffineTransform( CGAffineTransform(translationX: delta, y: 0))
                break
            case .vertical:
                self.headerImage.layer.setAffineTransform( CGAffineTransform(translationX: 0, y: delta))
                break
            }
        }) { (complete) -> Void in
            //如果当前是最后一次抖动，则将位置还原，并调用完成回调函数
            if (times == 0) {
                UIView.animate(withDuration: interval, animations: { () -> Void in
                    self.headerImage.layer.setAffineTransform(CGAffineTransform.identity)
                }, completion: { (complete) -> Void in
                    completion?()
                })
            }
                //如果当前不是最后一次抖动，则继续播放动画（总次数减1，偏移位置变成相反的）
            else {
                self.shake(direction: direction, times: times - 1,  interval: interval, delta: delta * -1, completion:completion)
            }
        }
    }
    
    class func headerView() -> GYMineHeaderView {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.last as! GYMineHeaderView
    }

}
