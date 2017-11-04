//
//  GYShopDetailFooterView.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/27.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit
import WebKit

fileprivate let ShopDetailCollectionCellId = "ShopDetailCollectionCellId"

protocol ShopDetailFooterWebViewDelegate:NSObjectProtocol {
    func shopDetailFooterWebView(height:CGFloat)
}

class GYShopDetailFooterView: UIView {

    fileprivate var controller:UIViewController?
    var headerImg:UIImageView?
    var nickNameL:UILabel?
    var shopButton:UIButton?
    
    var webView : WKWebView!
    var urlString = "http://192.168.1.156/group1/M00/02/A3/wKgBnFj1wm6AUtNZAAAOPwRtPtU69.html"
    var delegate:ShopDetailFooterWebViewDelegate?
    var currentCount:NSInteger = 0
    
    convenience init(frame: CGRect, superController: UIViewController) {
        self.init(frame: frame)
        superController.view.addSubview(self)

        self.controller = superController
        
        setupSubviews()
    }
    fileprivate func setupSubviews() {
        let topLine = UIView(frame: CGRect(x: 0, y: 0, width: kWidth, height: 6))
        topLine.backgroundColor = UIColor.globalGrayColor()
        self.addSubview(topLine)
        
        if headerImg == nil {
            headerImg = UIImageView(image: UIImage(named: imageView_nodata))
            headerImg?.frame = CGRect(x: 10, y: 16, width: 40, height: 40)
            self.addSubview(headerImg!)
        }
        if nickNameL == nil {
            nickNameL = UILabel.init(frame: CGRect.init(x: 60, y: 16, width: kWidth/2, height: 40))
            nickNameL?.font = UIFont.systemFont(ofSize: 13)
            nickNameL?.text = "卡卡西"
            self.addSubview(nickNameL!)
        }
        if shopButton == nil {
            shopButton = UIButton.init(type: UIButtonType.custom)
            shopButton?.frame = CGRect.init(x: kWidth-85, y: 23, width: 75, height: 25)
            shopButton?.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
            shopButton?.setImage(UIImage.init(named: "au_dianpu"), for: UIControlState.normal)
            self.addSubview(shopButton!)
        }
        let bottemLine = UIView(frame: CGRect(x: 0, y: 66, width: kWidth, height: 0.5))
        bottemLine.backgroundColor = UIColor.globalGrayColor()
        self.addSubview(bottemLine)
        
        self.addSubview(reusableView)
        self.addSubview(shopReusableView)

        let webConfiguratiojn = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguratiojn)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        self.addSubview(webView)
        webView.frame = CGRect.init(x: 0, y: (kWidth-40) / 3 + 177, width: kWidth, height: kHeight)
        let myURL = NSURL.init(string: urlString)
        let myRequest = NSURLRequest.init(url: myURL! as URL)
        webView.load(myRequest as URLRequest)

        webView.scrollView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)

    }
    var dataDic:NSDictionary? {
        didSet {
            print(dataDic!)
            if dataDic != nil {
                let model = GYShopDetailModel.init(dict: dataDic as! [String : AnyObject])
                if model.iconUrl != nil {
                    headerImg?.sd_setImage(with: URL(string:(model.iconUrl)!), placeholderImage: UIImage(named:"image_noda"))
                }
                nickNameL?.text = model.shopName
                
                let arr = model.recommend
                if arr!.count > 0 {
                    self.dataArray.removeAllObjects()
                    for (_,enums) in (arr?.enumerated())! {
                        let detail = GYShopDetailModel.init(dict: enums as! [String : AnyObject])
                        self.dataArray.add(detail)
                    }
                }
                self.collectionView.reloadData()
            }
            layoutConstraints()
        }
    }
    
    fileprivate func layoutConstraints() {
        
    }
    
    fileprivate lazy var reusableView: GYGoodDetailReusableView = {
        var reusableView = GYGoodDetailReusableView.reusableView()
        reusableView.frame = CGRect.init(x: 0, y: (kWidth-40) / 3 + 147, width: kWidth, height: 30)
        return reusableView
    }()
    fileprivate lazy var shopReusableView: GYGoodShopReusableView = {
        var shopReusableView = GYGoodShopReusableView.shopReusableView()
        shopReusableView.frame = CGRect.init(x: 0, y: 67, width: kWidth, height: 30)
        return shopReusableView
    }()
    fileprivate lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 97, width: kWidth, height: (kWidth-40) / 3 + 50), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        layout.itemSize = CGSize.init(width: (kWidth-40)/3, height: (kWidth-40) / 3 + 50)
        layout.scrollDirection = .horizontal
        collectionView.isScrollEnabled = true
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.register(UINib.init(nibName: "GYHomeCollectionCell", bundle: nil), forCellWithReuseIdentifier: ShopDetailCollectionCellId)
        collectionView.delegate = self
        collectionView.dataSource = self

        self.addSubview(collectionView)
        
        return collectionView
    }()
    fileprivate lazy var dataArray: NSMutableArray = {
        var dataArray = NSMutableArray()
        return dataArray
    }()

}

extension GYShopDetailFooterView: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopDetailCollectionCellId, for: indexPath) as! GYHomeCollectionCell
        if self.dataArray.count > 0 {
            let model = self.dataArray[indexPath.row] as? GYShopDetailModel
            cell.detailModel = model
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension GYShopDetailFooterView: WKUIDelegate ,WKNavigationDelegate {
    
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        webView.evaluateJavaScript("document.body.offsetHeight") { (result, error) in
//            let height = result as! CGFloat
//            var frame:CGRect = webView.frame
//            frame.size.height = height
//            print(height)
//            self.webView.frame = CGRect.init(x: 0, y: (kWidth-40) / 3 + 177, width: kWidth, height: height)
//            }
//    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            let size = webView.sizeThatFits(CGSize.zero)
            print(size)
            currentCount += 1
            webView.frame = CGRect.init(x: 0, y: (kWidth-40) / 3 + 177, width: size.width, height: size.height)
            if currentCount <= 1 {
                if self.delegate != nil {
//                    self.delegate?.shopDetailFooterWebView(height: (kWidth-40) / 3 + 177 + size.height)
                }
            }
        }
    }
    
    
}
