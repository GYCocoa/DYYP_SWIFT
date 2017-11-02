//
//  GYShopingDetailController.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/24.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh
import SVProgressHUD

class GYShopingDetailController: GYBaseViewController,ShopDetailHeaderUpdateHeightDelegate {
    
    var goodId:Int?
    var shopNav:GYShopDetailNavigation?
    var viewDid:Bool?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        UIApplication.shared.statusBarStyle = .default
        viewDid = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = false
        viewDid = true
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if viewDid! {
            UIApplication.shared.statusBarStyle = .lightContent
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let traget = self.navigationController?.interactivePopGestureRecognizer?.delegate
        let pan = UIPanGestureRecognizer.init(target: traget, action: nil)
        self.view.addGestureRecognizer(pan)
        
        self.navigationItem.title = "商品详情"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "au_bigshare"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(shareAction))
        setupSubviews()
        /// 获取系统本地语言   数组第一个是当前的语言
        //        let arr = UserDefaults.standard.object(forKey: "AppleLanguages")
        /// 获取系统所有的语言
        //        let arr = NSLocale.availableLocaleIdentifiers
    }
    @objc fileprivate func shareAction() {
        print("分享")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    fileprivate func setupSubviews() {
        view.addSubview(tableView)
        self.shopNav = GYShopDetailNavigation.init(frame: CGRect(x: 0, y: 0, width: kWidth, height: kNavBarHeight), superController: self)        
        self.setupHeaderView()
        headerView.backgroundColor = UIColor.white
        headerView.delegate = self
        tableView.tableHeaderView = headerView
        self.setupFooterView()
        tableView.tableFooterView = footerView
        footerView.backgroundColor = UIColor.orange
        self.view.addSubview(bottomView)
        let fresh = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(headerAction))
        self.tableView.mj_header = fresh
        
        requestData()
    }
    @objc fileprivate func headerAction() {
        
        self.tableView.mj_header.endRefreshing()
    }
    fileprivate func requestData() {
        GYShopNetwork.getShopDetailData(goodId: goodId!, completionHandler: { (response) in
//            print(response)
            self.commentArray.removeAllObjects()
            if GYNetworkTool.success(response: response) {
                let data = response["data"] as? NSDictionary
                if let productDetails = data!["productDetails"] {/// header
                    self.headerView.dataDic = productDetails as? NSDictionary
                }
                if let commentList = data!["commentList"] { /// comment
                    let arr = (commentList as? NSArray)!
                    print(arr)
                    for (_,enums) in arr.enumerated() {
                        let model = GYShopDetailComment.init(dict: enums as! [String : AnyObject])
                        self.commentArray.add(model)
                    }
                }
                if let productShopInfo = data!["productShopInfo"] { /// footer
                    self.footerView.dataDic = productShopInfo as? NSDictionary
                }
            }else{
                SVProgressHUD.show(withStatus: response["stateMsg"] as? String)
            }
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
        
    }
    func updateShopDetailHeaderHeight(height: CGFloat) {
        headerView.frame = CGRect(x: 0, y: 0, width: kWidth, height: height)
    }
    fileprivate lazy var tableView:UITableView = {
        var tableView = UITableView.init(frame: CGRect.init(x: 0, y: -kNavStatusHeight, width: kWidth, height: kHeight - kShopBottomHeight + kNavStatusHeight), style: UITableViewStyle.grouped)
        tableView.backgroundColor = UIColor.globalBackgroundColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none; /// 去掉cell下划线
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: kWidth, height: 0)) /// 去掉cell多余的下划线
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: kWidth, height: 0)) /// 去掉cell多余的下划线
        tableView.register(UINib(nibName: String(describing: GYShopDetailTableCell.self), bundle: nil), forCellReuseIdentifier: String(describing: GYShopDetailTableCell.self))
        return tableView
    }()
    fileprivate lazy var headerView: GYShopDetailHeaderView = {
        var headerView = GYShopDetailHeaderView.init(frame: CGRect(x: 0, y: 0, width: kWidth, height: kHeight - 150), superController: self)
        return headerView
    }()
    fileprivate lazy var footerView: GYShopDetailFooterView = {
        var footerView = GYShopDetailFooterView()
        return footerView
    }()
    fileprivate lazy var bottomView: GYShopDetailBottomView = {
        var bottomView = GYShopDetailBottomView.bottomView()
        bottomView.frame = CGRect.init(x: 0, y: kHeight - kShopBottomHeight, width: kWidth, height: 50)
        return bottomView
    }()
    fileprivate lazy var commentArray: NSMutableArray = {
        var commentArray = NSMutableArray()
        return commentArray
    }()
}

extension GYShopingDetailController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.commentArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GYShopDetailTableCell.self), for: indexPath) as! GYShopDetailTableCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        if self.commentArray.count > 0 {
            cell.model = self.commentArray[indexPath.row] as? GYShopDetailComment
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.commentArray.count > 0 {
            var imgH:CGFloat = 0
            var replyImgH:CGFloat = 0
            let model:GYShopDetailComment = self.commentArray[indexPath.row] as! GYShopDetailComment
            print(model.imgs?.count)
            if model.imgs != nil && model.imgs!.count > 0 {
                imgH = 65 + 10 + (kWidth - 60)*1.2 / 6
            }else{
                imgH = 65 + 10
            }
            if model.appendCommentTime != nil {
                if model.appendImgs != nil && model.appendImgs!.count > 0 {
                    replyImgH = 45 + 10 + (kWidth - 60)*1.2 / 6
                }else{
                    replyImgH = 45 + 10
                }
            }else{
                replyImgH = 0
            }
            return imgH + replyImgH
        }
        return 0
//        return 230
//        if indexPath.row == 0 {
//            /// 原内容固定高度 + 自适应
//            return  65 + 10 + (kWidth - 60) / 6
//        }
//        /// 原内容固定高度 + 自适应 + 追评固定高度 + 自适应
//        return 65 + 10 + 45 + 10 + (kWidth - 60) / 6 * 2
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.shopNav?.scrollContentOffSet(offSet: self.tableView.contentOffset.y)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kWidth, height: 40))
        view.backgroundColor = UIColor.white
        let button = UIButton(type: UIButtonType.custom)
        button.setTitle("评价晒单(20)", for: UIControlState.normal)
        button.setTitleColor(UIColor.colorConversion(Color_Value: "#444444", alpha: 1), for: UIControlState.normal)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.frame = CGRect(x: 10, y: 0, width: kWidth - 20, height: 40)
        view .addSubview(button)
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kWidth, height: 40))
        view.backgroundColor = UIColor.white
        let button = UIButton(type: UIButtonType.custom)
        button.setTitle("全部评论", for: UIControlState.normal)
        button.setTitleColor(UIColor.colorConversion(Color_Value: "#444444", alpha: 1), for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.frame = CGRect(x: 10, y: 0, width: kWidth - 20, height: 40)
        button.setImage(UIImage.init(named: "au_smoregree"), for: UIControlState.normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 45, 0, -45)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 20)
        view .addSubview(button)
        return view
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
}

extension GYShopingDetailController {
    fileprivate func setupHeaderView() {
        headerView.frame = CGRect(x: 0, y: 0, width: kWidth, height: kHeight - 150)
    }
    fileprivate func setupFooterView() {
        footerView.frame = CGRect(x: 0, y: 0, width: kWidth, height: kHeight)
    }
    
}


