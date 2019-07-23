//
//  GYCaremaResultController.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/30.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit
import Photos
import SVProgressHUD

let caremaResultCollectionId = "caremaResultCollectionId"
class GYCaremaResultController: GYBaseViewController,searchImgViewDelegate {

    //选中的图片
    var clickImage:UIImage?
    fileprivate var topView:GYResultTopView?
    var id:String?
    var categoryId:NSInteger?
    var range:NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "一搜一世界"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "au_bigback"), style: UIBarButtonItem.Style.done, target: self, action: #selector(cancelAction))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "more"), style: UIBarButtonItem.Style.done, target: self, action: #selector(screeningAction))
        self.view.addSubview(self.collectionView)
        self.topView = GYResultTopView(frame: CGRect(x: 0, y: 64, width: kWidth, height: 60))
        self.topView?.delegate = self
        self.view.addSubview(self.topView!)
        self.topView?.getSourcesData(datas: [], imgView: self.clickImage!, range: [:], categoryId: 0)
        requestImageRestultData()
    }
    @objc fileprivate func cancelAction() {
        self.dismiss(animated: true, completion: nil)
        SVProgressHUD.dismiss()
    }
    @objc fileprivate func screeningAction() {
        print("筛选")
    }
    fileprivate func requestImageRestultData() {
        let array = NSMutableArray()
        let data = self.clickImage!.pngData()
        array.add(data!)
        SVProgressHUD.show(withStatus: "加载中...")
        GYNetworkTool.upLoadImageRequest(urlString: CAREMA_REAULT, data: array as! [Data], success: { (response) in
            SVProgressHUD.dismiss()
            self.dataArray.removeAllObjects()
            self.topArray.removeAllObjects()
//            print(response)
            self.id = response["id"] as? String
            self.categoryId = response["categoryId"] as? NSInteger
            self.range = response["range"] as? NSDictionary
            if let categoryItems = response["categoryItems"] {
                self.topArray.addObjects(from: categoryItems as! [Any])
                self.topView?.getSourcesData(datas: self.topArray, imgView: self.clickImage!, range: self.range!, categoryId: self.categoryId!)
            }
            if response["productItems"] != nil {
                let array:NSArray = response["productItems"] as! NSArray
                for index in 0..<array.count{
                    let model = GYCaremaResult(dict: array[index] as! [String : AnyObject])
                    self.dataArray.add(model)
                }
            }
            self.collectionView.reloadData()
        }) { (error) in
            SVProgressHUD.dismiss()
            print(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: -------------------------- 懒加载集合视图 -------------------------
    fileprivate lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 64 + 60, width: kWidth, height: kHeight-64 - 60), collectionViewLayout: collectionViewLayout)
        collectionViewLayout.itemSize = CGSize.init(width: (kWidth-30)/2, height: (kWidth-30)/2 + 60)
        collectionViewLayout.sectionInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.isUserInteractionEnabled = true
        collectionView.backgroundColor = UIColor.globalGrayColor()
        collectionView.register(UINib.init(nibName: "GYResultCollectionCell", bundle: nil), forCellWithReuseIdentifier: caremaResultCollectionId)
        return collectionView
    }()
    
    fileprivate lazy var dataArray: NSMutableArray = {
        var dataArray = NSMutableArray()
        return dataArray
    }()
    fileprivate lazy var topArray: NSMutableArray = {
        var topArray = NSMutableArray()
        return topArray
    }()
    
}

extension GYCaremaResultController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: caremaResultCollectionId, for: indexPath) as! GYResultCollectionCell
        if self.dataArray.count > 0 {
            cell.model = self.dataArray[indexPath.row] as? GYCaremaResult
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    //MARK: -------------------------- 裁剪框代理方法 -------------------------
    func searchImgViewMethods(image: UIImage, range: NSDictionary) {
        let cutting = GYCuttingBoxController()
        cutting.cuttingImg = image
        cutting.range = range
        self.present(cutting, animated: true, completion: nil)
    }
    
}


