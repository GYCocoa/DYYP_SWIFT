//
//  GYSettingController.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/25.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

let SETTINGCELLID = "SETTINGCELLID"
class GYSettingController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.globalBackgroundColor()
        self.navigationItem.title = "设置"
        
     view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSources.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = dataSources[section] as! NSArray
        return array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SETTINGCELLID) as! GYSettingCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        let array = dataSources[indexPath.section] as! NSArray
        let rows = array[indexPath.row] as! NSArray
        cell.itemNameL?.text = rows[0] as? String
        cell.itemContentL?.text = rows[1] as? String
        if indexPath.section == 0 {
            cell.tag = indexPath.row + 100
        }else{
            cell.tag = indexPath.row + 105
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    //返回分区头部视图
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.globalBackgroundColor()
        return headerView
    }
    
    //返回分区头部高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! GYSettingCell
        print(cell.tag)
        switch cell.tag {
        case 100:
            break
        case 101:
            break
        case 102:
            break
        case 103:
            break
        case 104:
            break
        case 105:
            scoringAction()
            break
        case 106:
            break
        case 107:
            resetAccount()
            break
        default:
            break
        }
    }
    fileprivate func scoringAction() {
        if #available(iOS 11.0, *) {
            let itunesurl = "itms-apps://itunes.apple.com/cn/app/id1296698742?mt=8&action=write-review"
//            let itunesurl = "itms-apps://itunes.apple.com/cn/app/id1296698742?mt=8"
            UIApplication.shared.openURL(NSURL(string: itunesurl)! as URL)
        }else {
            let itunesurl = "http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1296698742&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"
            UIApplication.shared.openURL(NSURL(string: itunesurl)! as URL)
        }
    }
    fileprivate func resetAccount() {
        let alert = GYAlertView.alertOriginalViewWithTitle(title: "确定要退出登录吗", cancel: "取消", sure: "确定", cancelClick: {
        }) {
            GYUserModel.resetAccount()
            let nav = GYNavigationController.init(rootViewController: GYLoginController())
            UIApplication.shared.keyWindow?.rootViewController = nav;
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    fileprivate lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.frame = CGRect.init(x: 0, y: 0, width: kWidth, height: kHeight)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(GYSettingCell.self, forCellReuseIdentifier: SETTINGCELLID)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        
        return tableView
    }()

    fileprivate lazy var dataSources: NSMutableArray = {
        var dataSources = NSMutableArray()
        dataSources = [[["个人资料",""],["通用",""],["隐私",""],["账户与安全",""],["黑名单",""]],[["给APP评分",""],["清空缓存","12.00MB"],["退出登录",""]]]
        return dataSources
    }()
}
