//
//  GYCommunityAncillaryCell.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/19.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

fileprivate let CommunityUsersCollectionCellId = "CommunityUsersCollectionCellId"
class GYCommunityAncillaryCell: UITableViewCell {

    fileprivate var leftLabel:UILabel?
    fileprivate var showAllBtn:UIButton?
    
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
        
        self.contentView.backgroundColor = UIColor.white
        
        if leftLabel == nil {
            leftLabel = UILabel(frame: CGRect(x: 16, y: 0, width: kWidth/3, height: 40))
            leftLabel?.text = "推荐用户"
            leftLabel?.font = UIFont.systemFont(ofSize: 12)
            self.contentView.addSubview(leftLabel!)
        }
        if showAllBtn == nil {
            showAllBtn = UIButton.init(frame: CGRect.init(x: kWidth/3*2, y: 0, width: kWidth/3-16, height: 40))
            showAllBtn?.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
            showAllBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            showAllBtn?.setTitle("显示全部", for: UIControlState.normal)
            showAllBtn?.setTitleColor(UIColor.black, for: UIControlState.normal)
            showAllBtn?.addTarget(self, action: #selector(showAllAction), for: UIControlEvents.touchUpInside)
            self.contentView.addSubview(showAllBtn!)
        }
        
        self.collectionView.reloadData()
    }
    @objc fileprivate func showAllAction(sender:UIButton) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 40, width: kWidth, height: (kWidth-40) / 3 + 50), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        layout.itemSize = CGSize.init(width: (kWidth-40)/3, height: (kWidth-40) / 3 + 50)
        layout.scrollDirection = .horizontal
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = UIColor.white
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.register(UINib.init(nibName: "GYCommunityReUsersCVCell", bundle: nil), forCellWithReuseIdentifier: CommunityUsersCollectionCellId)
        self.contentView.addSubview(collectionView)

        return collectionView
    }()
    
    var dataArray:NSMutableArray? {
        didSet {
            print(dataArray!)
            self.collectionView.reloadData()
        }
    }
    
}

extension GYCommunityAncillaryCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommunityUsersCollectionCellId, for: indexPath) as! GYCommunityReUsersCVCell
        if self.dataArray!.count > 0 {
            let model = self.dataArray![indexPath.row] as? GYCommunityModel
            cell.model = model
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

