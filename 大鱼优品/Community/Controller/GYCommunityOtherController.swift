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

class GYCommunityOtherController: GYBaseViewController,SDCycleScrollViewDelegate {

    var topicTitle: TopicTitle?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.randomColor()

        ///   获取自视图数据
        setupSubviews()
        
    }

    fileprivate func setupSubviews() {
        
        view.addSubview(tableView)
        /// 获取banner数据
        getBannerdata()
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
    
    lazy var bannerArray: NSMutableArray = {
        var bannerArray = NSMutableArray()
        return bannerArray
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
        return 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
