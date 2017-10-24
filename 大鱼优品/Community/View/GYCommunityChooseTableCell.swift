//
//  GYCommunityChooseTableCell.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/24.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYCommunityChooseTableCell: UITableViewCell {

    
    fileprivate var centerLabel:UILabel?
    fileprivate var changeBtn:UIButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.white
        
        
        if centerLabel == nil {
            centerLabel = UILabel(frame: CGRect(x: kWidth/2-20, y: 0, width: 40, height: 40))
            centerLabel?.text = "精选"
            centerLabel?.font = UIFont.boldSystemFont(ofSize: 12)
            centerLabel?.textColor = UIColor.colorConversion(Color_Value: "#999999", alpha: 1)
            self.contentView.addSubview(centerLabel!)
        }
        if changeBtn == nil {
            changeBtn = UIButton.init(frame: CGRect.init(x: kWidth/3*2, y: 0, width: kWidth/3-16, height: 40))
            changeBtn?.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
            changeBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            changeBtn?.setTitle("换一批", for: UIControlState.normal)
            changeBtn?.setImage(UIImage.init(named: "change"), for: UIControlState.normal)
            changeBtn?.setTitleColor(UIColor.globalMainColor(), for: UIControlState.normal)
            changeBtn?.addTarget(self, action: #selector(changeAction), for: UIControlEvents.touchUpInside)
            changeBtn?.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5)
            self.contentView.addSubview(changeBtn!)
        }
        self.collectionView.reloadData()
    }
    
    @objc fileprivate func changeAction(sender:UIButton) {
        
    }
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 40, width: kWidth, height: 390), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        layout.itemSize = CGSize.init(width: (kWidth-30)/2, height: 195)
        layout.scrollDirection = .horizontal
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = UIColor.white
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.register(UINib(nibName: String(describing: GYCommunityChooseCollectionCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: GYCommunityChooseCollectionCell.self))
        
        self.contentView.addSubview(collectionView)
        
        return collectionView
    }()
    
    var dataArray:NSMutableArray? {
        didSet {
//            print(dataArray!)
            if dataArray!.count > 2 {
                self.collectionView.frame = CGRect.init(x: 0, y: 40, width: kWidth, height: 390)
            }else{
                self.collectionView.frame = CGRect.init(x: 0, y: 40, width: kWidth, height: 195)
            }
            self.collectionView.reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension GYCommunityChooseTableCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GYCommunityChooseCollectionCell.self), for: indexPath) as! GYCommunityChooseCollectionCell
        if ((self.dataArray?.count) != nil) {
            let model = self.dataArray![indexPath.row] as? GYCommunityModel
            cell.model = model
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
