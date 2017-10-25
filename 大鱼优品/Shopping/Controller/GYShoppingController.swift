//
//  GYShoppingController.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/18.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit
import SDCycleScrollView

class GYShoppingController: GYBaseViewController,ScrollTopicTitleDelegate,SDCycleScrollViewDelegate,UITabBarControllerDelegate {
    
    fileprivate var topView:UIView?
    fileprivate var currentH:CGFloat = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.delegate = self
        setNavigationTopBar()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        print(currentH)
//        self.scrollTopicTitle(height: currentH)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: kNavBar_Bg_Image), for: UIBarMetrics.default)
        UIApplication.shared.keyWindow?.viewWithTag(0x186A0)?.removeFromSuperview()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = ""
        setupNavBar()
        requestBannerAndTitlesData()
        setupBannerViews()
    }
    fileprivate func setupNavBar() {
        self.navigationItem.titleView = searchBar
    }
    @objc fileprivate func searchBarAction(sender:UIButton) {
        
    }
    fileprivate func setupBannerViews() {
        view.addSubview(cycleScrollView)
    }

    fileprivate func requestBannerAndTitlesData() {
        /// 获取banner数据
        GYNetworkTool.getShoppingBannerData(completionHandler: { (response) in
            //            print(response)
            self.shopBannerArr.removeAllObjects()
            if response["data"] != nil {
                let data:NSArray = response["data"] as! NSArray
                for index in 0..<data.count{
                    let model = GYShopping(dict: data[index] as! [String : AnyObject])
                    self.shopBannerArr.addObjects(from: [model.image as Any])
                }
                /// 给轮播图赋值
                self.cycleScrollView.imageURLStringsGroup = self.shopBannerArr as! [Any]
            }
        }) { (error) in
            print("error = \(error)")
        }
        /// 获取标题数据
        GYNetworkTool.getShoppingTitlesData(fromViewController: String(describing:GYShoppingController.self), completionHandler: { (topicTitles, topicVCs) in
            self.reloadButton.isHidden = true
            for child in self.childViewControllers {
                child.removeFromParentViewController()
            }
            // 将所有子控制器添加到父控制器中
            for childVc in topicVCs {
                childVc.delegate = self
                self.addChildViewController(childVc)
            }
            self.setupUI()
            self.pageView.titles = topicTitles
            self.pageView.childVcs = self.childViewControllers as? [GYShopTopicController]
        }) { (error) in
            print("error = \(error)")
            self.reloadButton.isHidden = false
        } 
    }
    override func reloadButtonAction(sender: UIButton) {
        requestBannerAndTitlesData()
    }
    
    //MARK: -------------------------- 实时修改高度 -------------------------
    func scrollTopicTitle(height: CGFloat) {
//        print(height)
        let H = height >= 100 + kNavStatusHeight ? 100 + kNavStatusHeight : (height <= 0 ? 0 : height)
        currentH =  H
        pageView.y = kNavBarHeight + 100 - H + kNavStatusHeight
        cycleScrollView.y = -H + kNavStatusHeight
        self.navigationController?.navigationBar.backgroundColor = UIColor.colorConversion(Color_Value: "ffffff", alpha: H/100)
        searchBar.backgroundColor = height<=0 ? UIColor.colorConversion(Color_Value: "ffffff", alpha: 0.85) : UIColor.colorConversion(Color_Value: "ececec", alpha: 1)
    }
    /// 轮播图点击事件
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        print("第\(index+1)张轮播图");
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate lazy var pageView: HomePageView = {
        let pageView = HomePageView()
        return pageView
    }()
    /// 无线轮播图
    lazy var cycleScrollView : SDCycleScrollView = {
        var cycleScrollView = SDCycleScrollView.init(frame: CGRect.init(x: 0, y: kNavStatusHeight, width: kWidth, height: kNavBarHeight+100), delegate: self, placeholderImage: UIImage(named: "community_nodata"))
        cycleScrollView?.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter
        cycleScrollView?.currentPageDotColor = UIColor.white
        cycleScrollView?.pageDotColor = UIColor.init(red: 202/255.0, green: 202/255.0, blue: 195/255.0, alpha: 1.0)
        return cycleScrollView!
    }()

    fileprivate lazy var searchBar: UIButton = {
        var searchBar = UIButton(type: UIButtonType.custom)
        searchBar.frame = CGRect.init(x: 10, y: 5, width: kWidth, height: 30)
        searchBar.setImage(UIImage(named:"au_search"), for: UIControlState.normal)
        searchBar.setTitle("搜索好物", for: UIControlState.normal)
        searchBar.setTitleColor(UIColor.colorConversion(Color_Value: "bfbfbf", alpha: 1), for: UIControlState.normal)
        searchBar.backgroundColor = UIColor.colorConversion(Color_Value: "ffffff", alpha: 0.85)
        searchBar.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        searchBar.layer.cornerRadius = 14
        searchBar.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        searchBar.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        searchBar.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        searchBar.adjustsImageWhenHighlighted = false
        return searchBar
    }()
    fileprivate lazy var shopBannerArr: NSMutableArray = {
        var shopBannerArr = NSMutableArray()
        return shopBannerArr
    }()
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabbar = self.tabBarController as? GYTabbarController
        if viewController == tabbar?.selected_ViewController {
            print("商城")
//            requestBannerAndTitlesData()
        }
        tabbar?.selected_ViewController = viewController
    }
}
extension GYShoppingController {
    fileprivate func setupUI() {
        pageView.removeFromSuperview()
        view.addSubview(pageView)
        pageView.frame = CGRect.init(x: 0, y: (kNavBarHeight + 100 + kNavStatusHeight), width: kWidth, height: kHeight - (kNavBarHeight + kNavStatusHeight))
    }
}
extension GYShoppingController {
    fileprivate func setNavigationTopBar() {
        topView = UIView()
        topView?.frame = CGRect.init(x: 0, y: 0, width: kWidth, height: kNavStatusHeight)
        topView?.backgroundColor = UIColor.globalMainColor()
        topView?.tag = 0x186A0
        UIApplication.shared.keyWindow?.addSubview(topView!)
    }
}
