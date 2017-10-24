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

fileprivate let GYHomeAncillaryCellId = "GYHomeAncillaryCellId"
fileprivate let GYCommunityTopicTableCellId = "GYCommunityTopicTableCellId"
fileprivate let GYCommunityChooseTableCellId = "GYCommunityChooseTableCellId"
class GYCommunityOtherController: GYBaseViewController,SDCycleScrollViewDelegate {

    var topicTitle: TopicTitle?
    fileprivate var pageId:Int = 1
    fileprivate var choosePageId:Int = 1
    fileprivate var currentIndex:Int = 0
    var isTopScroll:Bool?
    var contentOfSet_Y:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.randomColor()
        view.addSubview(tableView)

        if topicTitle?.cname == "推荐" {
            setupSubviews(isRecomment: true)
        }else{
            setupSubviews(isRecomment: false)
            setupCategory()
            requestTopicData()
            requestChooseData()
        }
    }
    fileprivate func setupSubviews(isRecomment: Bool) {
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            /// 获取banner数据
            self.pageId = 1
            if isRecomment {
                self.getBannerdata()
            }else{
                self.requestTopicData()
                self.requestChooseData()
            }
            self.getRecommendData(isRecomment: isRecomment)
        })
        self.tableView.mj_header.beginRefreshing()
        
        self.tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            self.pageId += 1
            self.getRecommendData(isRecomment: isRecomment)
        })
    }
    /// 获取精选数据
    fileprivate func requestChooseData() {
        GYCommunityView.getCommunityChooseData(cId: (topicTitle?.cid)!, pageId: choosePageId, completionHandler: { (response) in
            print(response)
            self.chooseArray.removeAllObjects()
            if GYNetworkTool.success(response: response) {
                if let data = response["data"] {
                    let datas = data as? NSDictionary
                    if let item = datas!["items"] {
                        let items = item as? NSArray
                        for (_,enums) in (items?.enumerated())!{
                            let model = GYCommunityModel.init(dict: enums as! [String : AnyObject])
                            self.chooseArray.add(model)
                        }
                    }
                }
            }
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
    }
    /// 获取话题数据
    fileprivate func requestTopicData() {
        GYCommunityView.getCommunityAllTopicData(cId: (topicTitle?.cid)!, completionHandler: { (response) in
//            print(response)
            self.topicArray.removeAllObjects()
            if GYNetworkTool.success(response: response) {
                if let data = response["data"] {
                    let item = data as? NSArray
                    for (_,enums) in (item?.enumerated())!{
                        let model = GYCommunityModel.init(dict: enums as! [String : AnyObject])
                        self.topicArray.add(model)
                    }
                }
            }
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
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
    
    fileprivate func getRecommendData(isRecomment:Bool) {
        var url = ""
        var param = NSMutableDictionary()
        if isRecomment {
            url = COMMUNITY_RECOMMEND
            param = [:]
        }else{
            url = COM_CATEGORY_NEW
            param = ["pageId":pageId,"id":topicTitle!.cid!,
                     "type":"1"]
        }
        GYCommunityView.getCommunityRecommendData(url: url, pageId: self.pageId, param:param, isRecomment: isRecomment, completionHandler: { (response) in
            print(response)
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            if self.pageId == 1 {
                self.dataArray.removeAllObjects()
                self.recommendUsers.removeAllObjects()
            }
            if let data = response["data"] as? NSDictionary {
                let pageTotal = data["pageTotal"] as? Int
                if pageTotal! <= self.pageId {
                    self.tableView.mj_footer.resetNoMoreData()
                }
            }
            if GYNetworkTool.success(response: response) {
                if let data = response["data"] as? NSDictionary {
                    if let items = data["items"] as? NSArray {
//                        print(items)
                        for (index,enums) in items.enumerated(){
                            let subs = enums as? NSDictionary
                            let subData = subs!["subData"] as? NSDictionary
                            if subs!["type"] as? Int == 1 {
                                let model = GYCommunityModel.init(dict: subData as! [String : AnyObject])
                                if model.picture != nil {
                                    let H = model.picture!["height"] as? CGFloat
                                    let W = model.picture!["width"] as? CGFloat
                                    var height = (kWidth-32)*(H! / W!)
                                    if height > (kWidth - 32) {
                                        height = kWidth-32
                                    }
                                    model.height = height
                                }else{
                                    model.height = 0
                                }
                                self.dataArray.add(model)
                            }else if subs!["type"] as? Int == 2{
                                self.currentIndex = index
                                let users = subs!["subData"] as? NSArray
//                                print(users!)
                                for (_,enums) in users!.enumerated(){
                                    let model = GYCommunityModel.init(dict: enums as! [String : AnyObject])
                                    self.recommendUsers.add(model)
                                }
                            }
                        }
                    }
                }
            }
            print(self.dataArray.count)
            self.tableView.reloadData()
        }) { (error) in
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            print(error)
        }
    }
    
    fileprivate func setupCategory() {
        
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
    fileprivate lazy var topicArray: NSMutableArray = {
        var topicArray = NSMutableArray()
        return topicArray
    }()
    fileprivate lazy var chooseArray: NSMutableArray = {
        var chooseArray = NSMutableArray()
        return chooseArray
    }()
    lazy var tableView:UITableView = {
        var tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: kWidth, height: kHeight-kNavBarHeight-kTabBarHeight - 40), style: UITableViewStyle.grouped)
        tableView.backgroundColor = UIColor.globalBackgroundColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none; /// 去掉cell下划线
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: kWidth, height: 0.01)) /// 去掉cell多余的下划线
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: kWidth, height: 0.01))
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.register(UINib(nibName: String(describing: GYCommunityHomeTableCell.self), bundle: nil), forCellReuseIdentifier: String(describing: GYCommunityHomeTableCell.self))
        tableView.register(GYCommunityAncillaryCell.self, forCellReuseIdentifier: GYHomeAncillaryCellId) /// 推荐用户
        tableView.register(GYCommunityTopicTableCell.self, forCellReuseIdentifier: GYCommunityTopicTableCellId) /// 话题
        tableView.register(GYCommunityChooseTableCell.self, forCellReuseIdentifier: GYCommunityChooseTableCellId) /// 精选

        
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
        if topicTitle?.cname == "推荐" {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GYCommunityHomeTableCell.self), for: indexPath) as! GYCommunityHomeTableCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                let model = self.dataArray.subarray(with: NSRange(location: 0, length: self.currentIndex))[indexPath.row] as? GYCommunityModel
                cell.communityModel = model
                if (isTopScroll)!{
                    if ((indexPath.row-(self.pageId-1)*10) == 0 || (indexPath.row-(self.pageId-1)*10) == 1 || self.pageId == 1) {
                        self.pageId += 1
                        getRecommendData(isRecomment: true)
                    }
                }
                return cell
            }else if indexPath.section == 1{
                let homeSpecial = tableView.dequeueReusableCell(withIdentifier: GYHomeAncillaryCellId) as! GYCommunityAncillaryCell
                homeSpecial.selectionStyle = UITableViewCellSelectionStyle.none
                homeSpecial.dataArray = self.recommendUsers
                return homeSpecial
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GYCommunityHomeTableCell.self), for: indexPath) as! GYCommunityHomeTableCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                let model = self.dataArray.subarray(with: NSRange(location: self.currentIndex, length: self.dataArray.count-self.currentIndex))[indexPath.row] as? GYCommunityModel
                if (isTopScroll)!{
                    if ((indexPath.row-(self.pageId-1)*10) == 0 || (indexPath.row-(self.pageId-1)*10) == 1 || self.pageId == 1) {
                        self.pageId += 1
                        getRecommendData(isRecomment: true)
                    }
                }
                cell.communityModel = model
                return cell
            }
        }else{
            if indexPath.section == 0 {
                let topic = tableView.dequeueReusableCell(withIdentifier: GYCommunityTopicTableCellId) as! GYCommunityTopicTableCell
                topic.selectionStyle = UITableViewCellSelectionStyle.none
                topic.dataArray = self.topicArray
                return topic
            }else if indexPath.section == 1 {
                let choose = tableView.dequeueReusableCell(withIdentifier: GYCommunityChooseTableCellId) as! GYCommunityChooseTableCell
                choose.selectionStyle = UITableViewCellSelectionStyle.none
                choose.dataArray = self.chooseArray
                return choose
            }else if indexPath.section == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GYCommunityHomeTableCell.self), for: indexPath) as! GYCommunityHomeTableCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                let model = self.dataArray.subarray(with: NSRange(location: 0, length: self.currentIndex))[indexPath.row] as? GYCommunityModel
                cell.communityModel = model
                if (isTopScroll)!{
                    if ((indexPath.row-(self.pageId-1)*10) == 0 || (indexPath.row-(self.pageId-1)*10) == 1 || self.pageId == 1) {
                        self.pageId += 1
                        getRecommendData(isRecomment: false)
                    }
                }
                return cell
            }else if indexPath.section == 3 {
                let anc = tableView.dequeueReusableCell(withIdentifier: GYHomeAncillaryCellId) as! GYCommunityAncillaryCell
                anc.selectionStyle = UITableViewCellSelectionStyle.none
                anc.dataArray = self.recommendUsers
                return anc
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GYCommunityHomeTableCell.self), for: indexPath) as! GYCommunityHomeTableCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                let model = self.dataArray.subarray(with: NSRange(location: self.currentIndex, length: self.dataArray.count-self.currentIndex))[indexPath.row] as? GYCommunityModel
                cell.communityModel = model
                if (isTopScroll)!{
                    if ((indexPath.row-(self.pageId-1)*10) == 0 || (indexPath.row-(self.pageId-1)*10) == 1 || self.pageId == 1) {
                        self.pageId += 1
                        getRecommendData(isRecomment: false)
                    }
                }
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if topicTitle?.cname == "推荐" {
            if indexPath.section == 0 {
                let model = self.dataArray.subarray(with: NSRange(location: 0, length: self.currentIndex))[indexPath.row] as? GYCommunityModel
                return 132 + (model?.height)!
            }else if indexPath.section == 1{
                return 210
            }else{
                let model = self.dataArray.subarray(with: NSRange(location: self.currentIndex, length: self.dataArray.count-self.currentIndex))[indexPath.row] as? GYCommunityModel
                return 132 + (model?.height)!
            }
        }else{
            if indexPath.section == 0 {
                return 95
            }else if indexPath.section == 1{
                return self.chooseArray.count > 2 ? 430 : (self.chooseArray.count > 0 ? 220 : 0)
            }else if indexPath.section == 2{
                let model = self.dataArray.subarray(with: NSRange(location: 0, length: self.currentIndex))[indexPath.row] as? GYCommunityModel
                return 132 + (model?.height)!
            }else if indexPath.section == 3{
                return 227
            }else{
                let model = self.dataArray.subarray(with: NSRange(location: self.currentIndex, length: self.dataArray.count-self.currentIndex))[indexPath.row] as? GYCommunityModel
                return 132 + (model?.height)!
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 6
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > contentOfSet_Y {
            isTopScroll = true
        }else{
            isTopScroll = false
        }
        contentOfSet_Y = scrollView.contentOffset.y
    }
    
}
