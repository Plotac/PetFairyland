//
//  HomeViewModel.swift
//  PetFairyland
//
//  Created by Ja on 2023/7/25.
//

import UIKit
import PFUtility

protocol HomeViewModelDelegate: NSObjectProtocol {
    func didSelectHomeItem(item: HomeItem)
}

class HomeViewModel: NSObject {
    
    weak var delegate: HomeViewModelDelegate?
    
    private(set) var mainCollectinView: UICollectionView!
    
    private(set) var homeItems: [HomeItem] = []
    
    override init() {
        super.init()
        setupItems()
        buildUI()
    }
}

extension HomeViewModel: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { homeItems.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.reuseIdentity(), for: indexPath) as? HomeCell ?? HomeCell()
        cell.model = homeItems[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectHomeItem(item: homeItems[indexPath.item])
    }
    
}

// MARK: -
extension HomeViewModel {
    
    func setupItems() {
        let appointment = HomeItem(title: "预约列表", imageStr: "home_list")
        let productManagement = HomeItem(title: "产品管理", imageStr: "home_product")
        let memberManagement = HomeItem(title: "会员管理", imageStr: "home_membership")
        let membershipCard = HomeItem(title: "会员卡", imageStr: "home_vip")
        let storeManagement = HomeItem(title: "门店管理", imageStr: "home_store")
        let staffManagement = HomeItem(title: "员工管理", imageStr: "home_staff")
        let financialSituation = HomeItem(title: "财务状况", imageStr: "home_finance")
        
        homeItems = [appointment, productManagement, storeManagement, membershipCard, memberManagement, staffManagement, financialSituation]
    }
    
    func buildUI() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (Screen.width - 50 - 40 * 2)/2, height: 80)
        layout.minimumLineSpacing = 40
        layout.minimumInteritemSpacing = 50
        layout.sectionInset = UIEdgeInsets(top: 40, left: 40, bottom: 0, right: 40)
        mainCollectinView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        mainCollectinView.dataSource = self
        mainCollectinView.backgroundColor = .clear
        mainCollectinView.delegate = self
        mainCollectinView.showsVerticalScrollIndicator = false
        mainCollectinView.showsHorizontalScrollIndicator = false
        mainCollectinView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.reuseIdentity())
    }
}
