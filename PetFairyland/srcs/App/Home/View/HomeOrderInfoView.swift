//
//  HomeOrderInfoView.swift
//  PetFairyland
//
//  Created by Ja on 2023/9/22.
//

import UIKit

class HomeOrderInfoView: UIView {
    
    var orderInfos: [HomeOrderInfoItem] = [] {
        didSet {
            orderCollectionView.reloadData()
        }
    }
    
    
    lazy var orderCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = Constants.minimumInteritemSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: Constants.margin, bottom: 0, right: Constants.margin)
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        cv.backgroundColor = .clear
        cv.register(HomeOrderInfoCell.self, forCellWithReuseIdentifier: HomeOrderInfoCell.reuseIdentity())
        
        return cv
    }()
    
    required init(frame: CGRect, orderInfos: [HomeOrderInfoItem]) {
        super.init(frame: frame)
        
        self.orderInfos = orderInfos
        
        addSubview(orderCollectionView)
        orderCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeOrderInfoView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { orderInfos.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeOrderInfoCell.reuseIdentity(), for: indexPath) as? HomeOrderInfoCell ?? HomeOrderInfoCell()
        cell.item = orderInfos[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let count = CGFloat(min(Constants.maxVisibleCount, orderInfos.count))
        
        return CGSize(width: (Screen.width - Constants.margin * 2 - Constants.minimumInteritemSpacing * CGFloat((orderInfos.count - 1))) / count,
                      height: collectionView.bounds.size.height)
    }
}


struct HomeOrderInfoItem {
    
    enum ItemType {
    case orders, turnover, sales
    }
    
    var title: String = ""
    
    var quantity: Double = 0
    
    var unit: String = "单"
    
    var type: HomeOrderInfoItem.ItemType = .orders
    
    var colors: (startColor: UIColor, endColor: UIColor) = (.white, .white)
}

fileprivate struct Constants {
    
    static let margin: CGFloat = 12
    
    static let maxVisibleCount: Int = 3
    
    static let minimumInteritemSpacing: CGFloat = 10
}
