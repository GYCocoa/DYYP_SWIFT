//
//  GYCommunityOtherController.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/29.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit
import SDCycleScrollView
import SVProgressHUD
import MJRefresh

class GYCommunityOtherController: GYBaseViewController,SDCycleScrollViewDelegate {

    var topicTitle: TopicTitle?
    fileprivate var pageId:Int = 1
    fileprivate var currentIndex:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.randomColor()
        if topicTitle?.cname == "推荐" {
            setupSubviews()
        }else{
            
        }
    }

    fileprivate func setupSubviews() {
        
        view.addSubview(tableView)
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            /// 获取banner数据
            self.pageId = 1
            self.getBannerdata()
            self.getRecommendData()
        })
        self.tableView.mj_header.beginRefreshing()
        
        self.tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            self.pageId += 1
            self.getRecommendData()
        })
    }
    
    fileprivate func getBannerdata() {
        tableView.tableHeaderView = self.cycleScrollView
        /// 给轮播图赋值
        GYCommunityView.getCommunityBannersData(completionHandler: { (response) in
            if GYNetworkTool.success(response: response) {
                self.bannerArray.removeAllObjects()
                if let data = response["data"] as?NSArray {
                    for index in 0..<data.count {
                        let dict = data[index] as? NSDictionary
                        self.bannerArray.add(dict!["image"] as! String)
                    }
                }
                self.cycleScrollView.imageURLStringsGroup = self.bannerArray as! [Any]
            }else{
                SVProgressHUD.showError(withStatus: response["stateMsg"] as? String)
            }
        }, errorCode: { (error) in
            print(error)
        })
    }
    
    fileprivate func getRecommendData() {
        GYCommunityView.getCommunityRecommendData(pageId: self.pageId, completionHandler: { (response) in
//            print(response)
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            if GYNetworkTool.success(response: response) {
                self.dataArray.removeAllObjects()
                self.recommendUsers.removeAllObjects()
                if let data = response["data"] as? NSDictionary {
                    if let items = data["items"] as? NSArray {
                        print(items)
                        for (index,enums) in items.enumerated(){
                            let subs = enums as? NSDictionary
                            if subs!["type"] as? Int == 1 {
                                let model = GYCommunityModel.init(dict: items[index] as! [String : AnyObject])
                                self.dataArray.add(model)
                            }else if subs!["type"] as? Int == 2{
                                self.currentIndex = index
                                let users = subs!["subData"] as? NSArray
                                print(users!)
                                let model = GYCommunityModel.init(dict: users![index] as! [String : AnyObject])
                                self.recommendUsers.add(model)
                            }
                        }
                    }
                }
            }
            self.tableView.reloadData()
        }) { (error) in
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            print(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// 轮播图点击事件
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        print("第\(index+1)张轮播图");
    }
    /// 无线轮播图
    lazy var cycleScrollView : SDCycleScrollView = {
        var cycleScrollView = SDCycleScrollView.init(frame: CGRect.init(x: 0, y: 0, width: kWidth, height: kNavBarHeight+100), delegate: self, placeholderImage: UIImage(named: "community_nodata"))
        cycleScrollView?.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter
        cycleScrollView?.currentPageDotColor = UIColor.white
        cycleScrollView?.pageDotColor = UIColor.init(red: 202/255.0, green: 202/255.0, blue: 195/255.0, alpha: 1.0)
        return cycleScrollView!
    }()
    
    fileprivate lazy var bannerArray: NSMutableArray = {
        var bannerArray = NSMutableArray()
        return bannerArray
    }()
    fileprivate lazy var dataArray: NSMutableArray = {
        var dataArray = NSMutableArray()
        return dataArray
    }()
    fileprivate lazy var recommendUsers: NSMutableArray = {
        var recommendUsers = NSMutableArray()
        return recommendUsers
    }()
    
    lazy var tableView:UITableView = {
        var tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: kWidth, height: kHeight-152), style: UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.globalBackgroundColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none; /// 去掉cell下划线
        tableView.tableFooterView = UIView() /// 去掉cell多余的下划线
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.register(UINib(nibName: String(describing: GYCommunityHomeTableCell.self), bundle: nil), forCellReuseIdentifier: String(describing: GYCommunityHomeTableCell.self))
        
        
        return tableView
    }()

}

extension GYCommunityOtherController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if topicTitle?.cname == "推荐" {
            if section == 0 {
                return self.currentIndex
            }else if section == 1{
                return self.recommendUsers.count > 0 ? 1:0
            }else{
                return self.dataArray.count - self.currentIndex
            }
        }else{
            if section == 0 || section == 1{
                return 1
            }else if section == 2{
                return self.currentIndex
            }else if section == 3{
                return self.recommendUsers.count > 0 ? 1:0
            }else{
                return self.dataArray.count - self.currentIndex
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if topicTitle?.cname == "推荐" {
            return 3
        }
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GYCommunityHomeTableCell.self), for: indexPath) as! GYCommunityHomeTableCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132 + 250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}
