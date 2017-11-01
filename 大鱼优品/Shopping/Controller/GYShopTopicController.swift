//
//  GYShopTopicController.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/27.
//  Copyright © 2017年 GYZ. All rights reserved.
//

//if #available(iOS 11.0, *) {
//    self.additionalSafeAreaInsets = UIEdgeInsets.zero
//} else {
//    // Fallback on earlier versions
//}

import UIKit
import MJRefresh

protocol ScrollTopicTitleDelegate:NSObjectProtocol {
    func scrollTopicTitle(height:CGFloat)
}

class GYShopTopicController: UIViewController {

    var topicTitle: TopicTitle?
    var delegate:ScrollTopicTitleDelegate?
    var pageId : Int = 1
    var isTopScroll:Bool?
    var contentOfSet_Y:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.randomColor()
        view.addSubview(tableView)
        setupControllerFresh()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    fileprivate func setupControllerFresh() {
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.pageId = 1
            self.requestCategoryData()
        })
        self.tableView.mj_header.beginRefreshing()
        self.tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            self.pageId += 1
            self.requestCategoryData()
        })
    }
    
    fileprivate func requestCategoryData() {
        GYNetworkTool.getShoppingCategoryData(pageId: self.pageId, categoryId: (self.topicTitle?.categoryId)!, completionHandler: { (response) in
            print(response)
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            if self.pageId == 1 {
                self.dataArray.removeAllObjects()
            }
            let data = response["data"] as? NSDictionary
            if data!["items"] != nil {
                let items = data!["items"] as? NSArray
                for (_, item) in items!.enumerated() {
                    let model = CategoryModel.init(dict: item as! [String : AnyObject])
                    self.dataArray.add(model)
                }
            }
            self.tableView.reloadData()
        }) { (error) in
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            let status = error["state"] as?NSInteger
            if status == 1 {
                self.tableView.mj_footer.endRefreshingWithNoMoreData()
            }
            print(error)
        }
    }
    fileprivate lazy var dataArray: NSMutableArray = {
        var dataArray = NSMutableArray()
        return dataArray
    }()
    fileprivate lazy var tableView:UITableView = {
        var tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: kWidth, height: kHeight-kNavBarHeight-kTabBarHeight), style: UITableViewStyle.grouped)
        tableView.backgroundColor = UIColor.globalBackgroundColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none; /// 去掉cell下划线
        tableView.tableFooterView = UIView() /// 去掉cell多余的下划线
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.register(UINib(nibName: String(describing: GYSnapUpTableCell.self), bundle: nil), forCellReuseIdentifier: String(describing: GYSnapUpTableCell.self))
        tableView.register(UINib(nibName: String(describing: GYRecommendTableCell.self), bundle: nil), forCellReuseIdentifier: String(describing: GYRecommendTableCell.self))
        tableView.register(UINib(nibName: String(describing: GYDisplayTableCell.self), bundle: nil), forCellReuseIdentifier: String(describing: GYDisplayTableCell.self))

        return tableView
    }()

}
extension GYShopTopicController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if topicTitle?.categoryName == "首页" {
            return 3
        }
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if topicTitle?.categoryName == "首页" {
            if section == 0 {
                return 1
            }else if section == 1 {
                return 1
            }
            return self.dataArray.count
        }
        return self.dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if topicTitle?.categoryName == "首页" {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GYSnapUpTableCell.self), for: indexPath) as! GYSnapUpTableCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.superController = self
                return cell
            }else if indexPath.section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GYRecommendTableCell.self), for: indexPath) as! GYRecommendTableCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.superController = self
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GYDisplayTableCell.self), for: indexPath) as! GYDisplayTableCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                if self.dataArray.count > 0 {
                    cell.homeModel = self.dataArray[indexPath.row] as? CategoryModel
                    if (isTopScroll)!{
                        if ((indexPath.row-(self.pageId-1)*10) == 0 || (indexPath.row-(self.pageId-1)*10) == 1 || self.pageId == 1) {
                            self.pageId += 1
                            requestCategoryData()
                        }
                    }
                }
                return cell
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GYDisplayTableCell.self), for: indexPath) as! GYDisplayTableCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            if self.dataArray.count > 0 {
                cell.categoryModel = self.dataArray[indexPath.row] as? CategoryModel
                if (isTopScroll)!{
                    if ((indexPath.row-(self.pageId-1)*10) == 0 || (indexPath.row-(self.pageId-1)*10) == 1 || self.pageId == 1) {
                        self.pageId += 1
                        requestCategoryData()
                    }
                }
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if topicTitle?.categoryName == "首页" {
            if indexPath.section == 2 {
                let homeModel = self.dataArray[indexPath.row] as? CategoryModel
                let view = GYShopingDetailController()
                view.goodId = homeModel?.productId
                self.navigationController?.pushViewController(view, animated: true)
            }
        }else{
            let homeModel = self.dataArray[indexPath.row] as? CategoryModel
            let view = GYShopingDetailController()
            view.goodId = homeModel?.productId
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if topicTitle?.categoryName == "首页" {
            if indexPath.section == 0 {
                return ( kWidth-40) / 3 + 130
            }else if indexPath.section == 1 {
                return ( kWidth-40) / 3 + 100
            }else{
                return 200
            }
        }
        return 200
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if topicTitle?.categoryName == "首页" {
            if section == 2 {
                return 40
            }
        }
        return 0.001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if topicTitle?.categoryName == "首页" {
            if section == 2 {
                let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kWidth, height: 40))
                view.backgroundColor = UIColor.white
                let button = UIButton(type: UIButtonType.custom)
                button.frame = CGRect.init(x: 10, y: 0, width: kWidth/3, height: 40)
                button.isUserInteractionEnabled = false
                button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
                button.setImage(UIImage(named:"au_hot"), for: UIControlState.normal)
                button.setTitle("精品推荐", for: UIControlState.normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
                button.setTitleColor(UIColor.colorConversion(Color_Value: "fd6363", alpha: 1), for: UIControlState.normal)
                view.addSubview(button)
                return view
            }
        }
        return UIView()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > contentOfSet_Y {
            isTopScroll = true
        }else{
            isTopScroll = false
        }
        contentOfSet_Y = scrollView.contentOffset.y
        if delegate != nil {
            delegate?.scrollTopicTitle(height: scrollView.contentOffset.y)
        }
    }

}

