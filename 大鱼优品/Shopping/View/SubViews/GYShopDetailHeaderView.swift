//
//  GYShopDetailHeaderView.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/26.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit
import SDCycleScrollView

protocol ShopDetailHeaderUpdateHeightDelegate:NSObjectProtocol {
    func updateShopDetailHeaderHeight(height:CGFloat)
}

class GYShopDetailHeaderView: UIView,SDCycleScrollViewDelegate {

    var shopNameL:UILabel?
    var priceL:UILabel?
    var originalPriceL:UILabel?
    var starView:UIView?
    var commentL:UILabel?
    var cellCountL:UILabel?
    var descriptionL:UILabel?
    var tipsView:UIView?
    var paramLabel:UILabel?
    var arrowImg:UIImageView?
    var bottomView:UIView?
    var delegate:ShopDetailHeaderUpdateHeightDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        self.addSubview(cycleScrollView)
        cycleScrollView.imageURLStringsGroup = self.bannerImages as! [Any]
        
        if shopNameL == nil {
            shopNameL = UILabel()
            shopNameL?.text = "新秀商务休闲双肩包简约轻便电脑书包手提旅游背包约轻便电脑书包手提旅游背包约轻便电脑书包手提旅游背包"
            shopNameL?.numberOfLines = 0
            shopNameL?.font = UIFont.systemFont(ofSize: 12)
            shopNameL?.textColor = UIColor.colorConversion(Color_Value: "#444444", alpha: 1)
            self.addSubview(shopNameL!)
        }
        if priceL == nil {
            priceL = UILabel()
            priceL?.text = "￥0.01"
            priceL?.font = UIFont.systemFont(ofSize: 12)
            priceL?.textColor = UIColor.globalMainColor()
            self.addSubview(priceL!)
        }
        if originalPriceL == nil {
            originalPriceL = UILabel()
            originalPriceL?.font = UIFont.systemFont(ofSize: 10)
            originalPriceL?.textColor = UIColor.colorConversion(Color_Value: "#999999", alpha: 1)
            self.addSubview(originalPriceL!)
            let str = "￥100  "
            let attri = NSMutableAttributedString.init(string: str)
            attri.addAttribute(NSStrikethroughStyleAttributeName, value: UInt8(NSUnderlineStyle.patternSolid.rawValue) | UInt8(NSUnderlineStyle.styleSingle.rawValue), range: NSRange(location: 0, length: str.characters.count))
            attri.addAttribute(NSStrikethroughColorAttributeName, value: UIColor.colorConversion(Color_Value: "#666666", alpha: 1), range: NSRange(location: 0, length: str.characters.count))
            originalPriceL?.attributedText = attri
        }
        if starView == nil {
            starView = UIView()
            starView?.backgroundColor = UIColor.cyan
            self.addSubview(starView!)
        }
        if commentL == nil {
            commentL = UILabel()
            commentL?.text = "100人评价"
            commentL?.font = UIFont.systemFont(ofSize: 11)
            commentL?.textColor = UIColor.colorConversion(Color_Value: "#999999", alpha: 1)
            self.addSubview(commentL!)
        }
        if cellCountL == nil {
            cellCountL = UILabel()
            cellCountL?.text = "累计销量：49件"
            cellCountL?.font = UIFont.systemFont(ofSize: 11)
            cellCountL?.textAlignment = NSTextAlignment.right
            cellCountL?.textColor = UIColor.colorConversion(Color_Value: "#999999", alpha: 1)
            self.addSubview(cellCountL!)
        }
        if descriptionL == nil {
            descriptionL = UILabel()
            descriptionL?.text = "这个商品很不错这个商品很不错这个商品很不错这个商品很不错这个商品很不错这个商品很不错这个商品很不错这个商品很不错这个商品很不错这个商品很不错这个商品很不错 这个商品很不错这个商品很不很不错这个商品很不错这个商品很不错这个商品很不错这个商品很不错这个商品很不错这个商品很不错这个商品很不错 这个商品很不错这个商品很不错这个商品很不错这个商品很不错"
            descriptionL?.numberOfLines = 0
            descriptionL?.font = UIFont.systemFont(ofSize: 10)
            descriptionL?.textColor = UIColor.colorConversion(Color_Value: "#999999", alpha: 1)
            self.addSubview(descriptionL!)
        }
        if tipsView == nil {
            tipsView = UIView()
            tipsView?.backgroundColor = UIColor.globalGrayColor()
            self.addSubview(tipsView!)
        }
        if paramLabel == nil {
            paramLabel = UILabel()
            paramLabel?.text = "产品参数"
            paramLabel?.font = UIFont.systemFont(ofSize: 12)
            paramLabel?.textColor = UIColor.colorConversion(Color_Value: "#444444", alpha: 1)
            self.addSubview(paramLabel!)
        }
        if arrowImg == nil {
            arrowImg = UIImageView(image: UIImage(named: "au_smoregree"))
            self.addSubview(arrowImg!)
        }
        if bottomView == nil {
            bottomView = UIView()
            bottomView?.backgroundColor = UIColor.globalGrayColor()
            self.addSubview(bottomView!)
        }
    }

    var dataArray:NSArray? {
        didSet {
            layoutConstraints()
        }
    }
    
    fileprivate func layoutConstraints() { // 10 + nameSize.height + 10 + priceSize.height + 10 + 10 + 10 + descriptionSize.height + 10 + 60 + 5   /// 125
        let nameSize:CGSize = NSObject.adaptiveSizeWithString(str: (shopNameL?.text)!, font: 12, reduce: 20)
        let priceSize:CGSize = NSObject.adaptiveSizeWithString(str: (priceL?.text)!, font: 12, reduce: kWidth/2)
        let originalPriceSize:CGSize = NSObject.adaptiveSizeWithString(str: (originalPriceL?.text)!, font: 10, reduce: kWidth/2)
        let commentSize:CGSize = NSObject.adaptiveSizeWithString(str: (commentL?.text)!, font: 11, reduce: kWidth/2)
        let cellCountSize:CGSize = NSObject.adaptiveSizeWithString(str: (cellCountL?.text)!, font: 11, reduce: kWidth/2)
        let descriptionSize:CGSize = NSObject.adaptiveSizeWithString(str: (descriptionL?.text)!, font: 10, reduce: 20)

        shopNameL?.snp.makeConstraints({ (make) in
            make.top.equalTo(cycleScrollView.snp.bottom).offset(10)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(nameSize.height)
        })
        priceL?.snp.makeConstraints({ (make) in
            make.top.equalTo(shopNameL!.snp.bottom).offset(10)
            make.left.equalTo(10)
            make.width.equalTo(priceSize.width + 5)
        })
        originalPriceL?.snp.makeConstraints({ (make) in
            make.top.equalTo(shopNameL!.snp.bottom).offset(11)
            make.left.equalTo(priceL!.snp.right)
            make.width.equalTo(originalPriceSize.width + 5)
        })
        starView?.snp.makeConstraints({ (make) in
            make.top.equalTo(priceL!.snp.bottom).offset(10)
            make.left.equalTo(10)
            make.width.equalTo(100)
            make.height.equalTo(10)
        })
        commentL?.snp.makeConstraints({ (make) in
            make.top.equalTo(priceL!.snp.bottom).offset(10)
            make.left.equalTo(starView!.snp.right).offset(15)
            make.width.equalTo(commentSize.width)
            make.height.equalTo(10)
        })
        cellCountL?.snp.makeConstraints({ (make) in
            make.top.equalTo(priceL!.snp.bottom).offset(10)
            make.right.equalTo(-10)
            make.width.equalTo(cellCountSize.width + 5)
            make.height.equalTo(10)
        })
        descriptionL?.snp.makeConstraints({ (make) in
            make.top.equalTo(starView!.snp.bottom).offset(10)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(descriptionSize.height + 5)
        })
        tipsView?.snp.makeConstraints({ (make) in
            make.top.equalTo(descriptionL!.snp.bottom).offset(10)
            make.left.right.equalTo(0)
            make.height.equalTo(30)
        })
        paramLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(tipsView!.snp.bottom).offset(0)
            make.left.equalTo(10)
            make.width.equalTo(100)
            make.height.equalTo(40)
        })
        arrowImg?.snp.makeConstraints({ (make) in
            make.top.equalTo(tipsView!.snp.bottom).offset(10)
            make.right.equalTo(-5)
            make.width.height.equalTo(20)
        })
        bottomView?.snp.makeConstraints({ (make) in
            make.top.equalTo(paramLabel!.snp.bottom).offset(0)
            make.left.right.equalTo(0)
            make.height.equalTo(5)
        })
        // 10 + nameSize.height + 10 + priceSize.height + 10 + 10 + 10 + descriptionSize.height + 10 + 60 + 5   /// 125
        if delegate != nil {   /// 修改header的高度
            delegate?.updateShopDetailHeaderHeight(height: ((kHeight - 150) / 2 + nameSize.height + priceSize.height + descriptionSize.height + 140))
        }
        
    }
    
    /// 轮播图点击事件
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        print("第\(index+1)张轮播图");
    }
    
    /// 无线轮播图
    fileprivate lazy var cycleScrollView : SDCycleScrollView = {
        var cycleScrollView = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: kWidth, height: (kHeight - 150) / 2), delegate: self, placeholderImage: UIImage(named: "community_nodata"))
        cycleScrollView?.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter
        cycleScrollView?.currentPageDotColor = UIColor.white
        cycleScrollView?.pageDotColor = UIColor.init(red: 202/255.0, green: 202/255.0, blue: 195/255.0, alpha: 1.0)
        return cycleScrollView!
    }()
    
    fileprivate lazy var bannerImages : NSMutableArray = { /// 轮播图
        var bannerImages = NSMutableArray()
        return bannerImages
    }()
    
}
