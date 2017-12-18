//
//  GYHomeController.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/18.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit
import SDCycleScrollView
import MJRefresh

let homeHeaderView = "homeHeaderView"
let GYHomeSpecialCellId = "GYHomeSpecialCellId"
let GYHomeRecommendCellId = "GYHomeRecommendCellId"
class GYHomeController: GYBaseViewController,UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,UITabBarControllerDelegate {

    var advert:UIView?
    fileprivate var pageId : Int = 1

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        setupNavigationBar()
        setupSubviews()
//        loadAdvertising()
    }
    
    fileprivate func loadAdvertising() {
        let window = UIApplication.shared.keyWindow
        let advert = UIView.init(frame: (window?.bounds)!)
        advert.backgroundColor = UIColor.gray
        advert.alpha = 0.5
        advert.tag = 0x186A1
        let button = UIButton.init(type: UIButtonType.custom)
        button.frame = CGRect.init(x: kWidth/2-50, y: kHeight/2-20, width: 100, height: 40)
        button.setTitle("关闭", for: UIControlState.normal)
        button.setTitleColor(UIColor.colorConversion(Color_Value: "fd6363", alpha: 1), for: UIControlState.normal)
        button.addTarget(self, action: #selector(buttonAction), for: UIControlEvents.touchUpInside)
        advert.addSubview(button)
        window?.addSubview(advert)
    }
    @objc fileprivate func buttonAction() {
        UIApplication.shared.keyWindow?.viewWithTag(0x186A1)?.removeFromSuperview()
    }
    fileprivate func setupNavigationBar() {
        self.titleView.frame = CGRect.init(x: 0, y: 0, width: kWidth, height: 30)
        self.navigationItem.titleView = self.titleView
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "home_fenlei")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.done, target: self, action: #selector(homeleftAction))
        self.titleView.addTarget(self, action: #selector(homeSearchAction), for: UIControlEvents.touchUpInside)
        self.newRewards.addTarget(self, action: #selector(newRewardsAction), for: UIControlEvents.touchUpInside)
    }
    @objc fileprivate func homeSearchAction() {
        print("home search")
    }
    @objc fileprivate func homeleftAction() {
        print("home category")
        self.navigationController?.pushViewController(GYNodeServerController(), animated: true)
    }
    @objc fileprivate func newRewardsAction() {
        print("home newRewards")
    }
    fileprivate func setupSubviews() {
        view.addSubview(tableView)
        tableView.tableHeaderView = topView
        topView.addSubview(cycleScrollView)
        topView.addSubview(newRewards)
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.pageId = 1
            self.requestSubviewsData()
        })
        self.tableView.mj_header.beginRefreshing()
        
        self.tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            self.pageId += 1
            self.requestShopRecommendData()
        })
    }
    fileprivate func requestSubviewsData() {
        requestBannerData()
        requestSpecialData()
         requestShopRecommendData()
    }
    //MARK: -------------------------- 获取banner数据 -------------------------
    fileprivate func requestBannerData() {
        GYNetworkTool.getHomeBannerData(completionHandler: { (response) in
            //            print( response)
            self.bannerImages.removeAllObjects()
            if response["items"] != nil {
                let data:NSArray = response["items"] as! NSArray
                for index in 0..<data.count{
                    let model = GYHomeBanner.init(dict: data[index] as! [String : AnyObject])
                    self.bannerImages.addObjects(from: [model.image as Any])
                }
                /// 给轮播图赋值
                self.cycleScrollView.imageURLStringsGroup = self.bannerImages as! [Any]
            }
        }) { (error) in
            print(error)
        }
    }
    //MARK: -------------------------- 获取专场数据 -------------------------
    fileprivate func requestSpecialData() {
        GYNetworkTool.getHomeSpecialData(completionHandler: { (response) in
//            print(response)
            self.specialArr.removeAllObjects()
            if response["items"] != nil {
                let data:NSArray = response["items"] as! NSArray
                for index in 0..<data.count{
                    let model = GYHomeSpecial.init(dict: data[index] as! [String : AnyObject])
                    self.specialArr.add(model)
                }
            }
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
    }
    //MARK: -------------------------- 获取商品推荐数据 -------------------------
    fileprivate func requestShopRecommendData() {
        GYNetworkTool.getShopRecommendData(pageId: self.pageId,completionHandler: { (response) in
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
//            print(response)
            if self.pageId == 1 {
                self.shopRecommendArr.removeAllObjects()
            }
            if response["data"] != nil {
                let data = response["data"] as? NSDictionary
                if data!["items"] != nil {
                    let items:NSArray = data!["items"] as! NSArray
                    for index in 0..<items.count{
                        let model = GYShopModel.init(dict: items[index] as! [String : AnyObject])
                        self.shopRecommendArr.add(model)
                    }
                }
            }
            self.tableView.reloadData()
        }) { (error) in
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            if let status = error["state"] as?NSInteger {
                if status == 1 {
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                }
            }
            print(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1 {
            return self.specialArr.count
        }else{
            return self.shopRecommendArr.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return (kWidth-40) / 3 + 50
        }else if indexPath.section == 1 {
            return 150
        }else{
            return 120
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kWidth, height: 30))
        view.backgroundColor = UIColor.white
        let line = UIView.init(frame: CGRect.init(x: 10, y: 9, width: 2, height: 12))
        line.backgroundColor = UIColor.red
        view .addSubview(line)
        let label = UILabel.init(frame: CGRect.init(x: 15, y: 9, width: kWidth/2, height: 12))
        label.text = footerHeaderArr[section] as? String
        label.font = UIFont.systemFont(ofSize: 12)
        view .addSubview(label)
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.globalBackgroundColor()
        return view
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    //MARK: -------------------------- cellForRowAt indexPath -------------------------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: GYHomeRecommendCellId) as! GYHomeRecommendCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: GYHomeSpecialCellId) as! GYHomeSpecialCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            if self.specialArr.count > 0 {
                let model = self.specialArr[indexPath.row] as? GYHomeSpecial
                cell.special = model
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GYHomeShopRecommendCell.self), for: indexPath) as! GYHomeShopRecommendCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            if self.shopRecommendArr.count > 0 {
                let model = self.shopRecommendArr[indexPath.row] as? GYShopModel
                cell.shop = model
            }
            return cell
        }
    }

    /// 轮播图点击事件
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        print("第\(index+1)张轮播图");
    }
    fileprivate lazy var tableView:UITableView = {
        var tableView = UITableView.init(frame: CGRect.init(x: 0, y: kNavBarHeight, width: kWidth, height: kHeight), style: UITableViewStyle.grouped)
        tableView.backgroundColor = UIColor.globalBackgroundColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none; /// 去掉cell下划线
        tableView.tableFooterView = UIView() /// 去掉cell多余的下划线
        tableView.register(GYHomeRecommendCell.self, forCellReuseIdentifier: GYHomeRecommendCellId)
        tableView.register(GYHomeSpecialCell.self, forCellReuseIdentifier: GYHomeSpecialCellId)
        tableView.register(UINib(nibName: String(describing: GYHomeShopRecommendCell.self), bundle: nil), forCellReuseIdentifier: String(describing: GYHomeShopRecommendCell.self))

        return tableView
    }()
    /// 无线轮播图
    fileprivate lazy var cycleScrollView : SDCycleScrollView = {
        var cycleScrollView = SDCycleScrollView.init(frame: CGRect.init(x: 0, y: 0, width: kWidth, height: 150*scaleH), delegate: self, placeholderImage: UIImage(named: "community_nodata"))
        cycleScrollView?.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter
        cycleScrollView?.currentPageDotColor = UIColor.white
        cycleScrollView?.pageDotColor = UIColor.init(red: 202/255.0, green: 202/255.0, blue: 195/255.0, alpha: 1.0)
        return cycleScrollView!
    }()
    fileprivate lazy var topView:UIView = {
        var topView = UIView()
        topView.frame = CGRect.init(x: 0, y: 0, width: kWidth, height: 250*scaleH)
        return topView
    }()
    fileprivate lazy var titleView: UIButton = {
        var titleView = UIButton()
        titleView.setBackgroundImage(UIImage.init(named: "first"), for: UIControlState.normal)
        titleView.adjustsImageWhenHighlighted = false
        return titleView
    }()
    fileprivate lazy var newRewards: UIButton = {
        var newRewards = UIButton()
        newRewards.frame = CGRect.init(x: 0, y: 160*scaleH, width: kWidth, height: 80*scaleH)
        newRewards.setImage(UIImage.init(named: "new_user_rewards"), for: UIControlState.normal)
        newRewards.adjustsImageWhenHighlighted = false
        return newRewards
    }()
    fileprivate lazy var bannerImages : NSMutableArray = { /// 轮播图
        var bannerImages = NSMutableArray()
        return bannerImages
    }()
    fileprivate lazy var footerHeaderArr : NSMutableArray = {
        var footerHeaderArr = NSMutableArray()
        footerHeaderArr = ["精品推荐","必买专场","商品推荐"]
        return footerHeaderArr
    }()
    fileprivate lazy var specialArr : NSMutableArray = { /// 必买专场
        var specialArr = NSMutableArray()
        return specialArr
    }()
    fileprivate lazy var shopRecommendArr : NSMutableArray = { /// 商品推荐
        var shopRecommendArr = NSMutableArray()
        return shopRecommendArr
    }()
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabbar = self.tabBarController as? GYTabbarController
        if viewController == tabbar?.selected_ViewController {
            print("全网")
        }
        tabbar?.selected_ViewController = viewController
    }
}

