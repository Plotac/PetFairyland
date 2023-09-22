//
//  HomeOperatingDataView.swift
//  PetFairyland
//
//  Created by Ja on 2023/9/22.
//

import UIKit

class HomeOperatingDataView: UIView {
    
    var dataItems: [HomeOperatingDataItem] = [] {
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
        cv.register(HomeOperatingDataCell.self, forCellWithReuseIdentifier: HomeOperatingDataCell.reuseIdentity())
        
        return cv
    }()
    
    required init(frame: CGRect, dataItems: [HomeOperatingDataItem]) {
        super.init(frame: frame)
        
        self.dataItems = dataItems
        
        addSubview(orderCollectionView)
        orderCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeOperatingDataView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { dataItems.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeOperatingDataCell.reuseIdentity(), for: indexPath) as? HomeOperatingDataCell ?? HomeOperatingDataCell()
        cell.item = dataItems[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let count = CGFloat(min(Constants.maxVisibleCount, dataItems.count))
        
        return CGSize(width: (Screen.width - Constants.margin * 2 - Constants.minimumInteritemSpacing * CGFloat((dataItems.count - 1))) / count,
                      height: collectionView.bounds.size.height)
    }
}

fileprivate struct Constants {
    
    static let margin: CGFloat = 12
    
    static let maxVisibleCount: Int = 3
    
    static let minimumInteritemSpacing: CGFloat = 10
}
