//
//  GYResultTopView.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/9.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

protocol searchImgViewDelegate:NSObjectProtocol {
    func searchImgViewMethods(image:UIImage,range:NSDictionary)
}

let resultTopCollectionId = "resultTopCollectionId"
class GYResultTopView: UIView {
    
    var delegate : searchImgViewDelegate?
    var searchImgView:UIImageView?
    var searchCollectionView:UICollectionView?
    var editImgView:UIImageView?
    var arrowImgView:UIImageView?

    fileprivate var categoryId:NSInteger?
    fileprivate var range:NSDictionary?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    func getSourcesData(datas:NSMutableArray,imgView:UIImage,range:NSDictionary,categoryId:NSInteger) {
//        print(datas)
        self.categoryId = categoryId
        self.range = range
        for index in 0..<datas.count {
            let dict = datas[index] as? NSDictionary
            let categoryId = dict?.value(forKey: "key") as? NSInteger
            if self.categoryId == categoryId {
                datas.insert(dict!, at: 0)
                datas.removeObject(at: index + 1)
            }
        }
        self.dataArray.removeAllObjects()
        self.dataArray = datas 
        searchImgView?.image = imgView
        self.searchCollectionView?.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        self.backgroundColor = UIColor.white
        let line = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kWidth, height: 1))
        line.backgroundColor = UIColor.globalGrayColor()
        self.addSubview(line)
        searchImgView = UIImageView.init(image: UIImage.init(named: "community_head"))
        searchImgView?.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(searchImgViewAction))
        searchImgView?.addGestureRecognizer(tap)
        self.addSubview(searchImgView!)
        editImgView = UIImageView.init(image: UIImage.init(named: "chanpinditu"))
        self.addSubview(editImgView!)
        arrowImgView = UIImageView.init(image: UIImage.init(named: "get_more_gray"))
        self.addSubview(arrowImgView!)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: 40, height: 18)
        searchCollectionView = UICollectionView.init(frame: CGRect.init(x: 65, y: 15, width: kWidth-85, height: 30), collectionViewLayout: layout)
        searchCollectionView?.backgroundColor = UIColor.white
        self.addSubview(searchCollectionView!)
        searchCollectionView?.delegate = self
        searchCollectionView?.dataSource = self
        searchCollectionView?.showsVerticalScrollIndicator = false
        searchCollectionView?.showsHorizontalScrollIndicator = false
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        searchCollectionView?.register(GYResultTipsCell.self, forCellWithReuseIdentifier: resultTopCollectionId)
        
        autolayoutSubviews()
    }
    @objc fileprivate func searchImgViewAction(sender:UITapGestureRecognizer) {
        if delegate != nil {
            delegate?.searchImgViewMethods(image: (self.searchImgView?.image!)!, range: self.range!)
        }
    }
    
    fileprivate func autolayoutSubviews() {
        searchImgView?.snp.makeConstraints({ (make) in
            make.top.left.equalTo(10)
            make.width.height.equalTo(40)
        })
        editImgView?.snp.makeConstraints({ (make) in
            make.top.left.equalTo(37)
            make.width.height.equalTo(13)
        })
        arrowImgView?.snp.makeConstraints({ (make) in
            make.top.equalTo(20)
            make.width.equalTo(10)
            make.height.equalTo(20)
            make.right.equalTo(-10)
        })
    }
    
    
    fileprivate lazy var dataArray: NSMutableArray = {
        var dataArray = NSMutableArray()
        return dataArray
    }()
}

extension GYResultTopView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
  
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var value = ""
        if self.dataArray.count > 0 {
            let dict = self.dataArray[indexPath.row] as? NSDictionary
            value = (dict?.value(forKey: "value") as? String)!
        }
        var sizes = NSObject.adaptiveSizeWithString(str: value, font: 11, reduce: 0)
        sizes.width = 50
        sizes.height = 18
        return sizes
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resultTopCollectionId, for: indexPath) as! GYResultTipsCell
        if self.dataArray.count > 0 {
            let dict = self.dataArray[indexPath.row] as? NSDictionary
            cell.tipLabel?.text = dict?.value(forKey: "value") as? String
            let categoryId = dict?.value(forKey: "key") as? NSInteger
            if self.categoryId == categoryId {
                cell.tipLabel?.backgroundColor = UIColor.colorConversion(Color_Value: "#fd6363", alpha: 1)
                cell.tipLabel?.textColor = UIColor.colorConversion(Color_Value: "#ffffff", alpha: 1)
            }else{
                cell.tipLabel?.backgroundColor = UIColor.white
                cell.tipLabel?.textColor = UIColor.colorConversion(Color_Value: "#444444", alpha: 1)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dict = self.dataArray[indexPath.row] as? NSDictionary
        self.categoryId = dict?.value(forKey: "key") as? NSInteger
        self.searchCollectionView?.reloadData()
    }
    
}

