//
//  HomeViewModel.swift
//  PetFairyland
//
//  Created by Ja on 2023/7/25.
//

import UIKit
import PFUtility

protocol HomeViewModelDelegate: NSObjectProtocol {
    func didSelectHomeFunction(item: HomeFunctionItem)
}

class HomeViewModel: NSObject {
    
    weak var delegate: HomeViewModelDelegate?
    
    private(set) var loginBtn: UIButton!
    
    private(set) var mainTableView: UITableView!
    
    private(set) var homeZones: [HomeFunctionZone] = []
    
    override init() {
        super.init()
        setupZones()
        buildUI()
    }
}

extension HomeViewModel {
    @objc
    func login() {
        
    }
}

extension HomeViewModel: HomeFunctionalZoneCellDelegate {

    func didSelect(item: HomeFunctionItem) {
        delegate?.didSelectHomeFunction(item: item)
    }
}

extension HomeViewModel: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int { homeZones.count }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeFunctionalZoneCell.reuseIdentity(), for: indexPath) as? HomeFunctionalZoneCell ?? HomeFunctionalZoneCell()
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.delegate = self
        cell.zone = homeZones[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return homeZones[indexPath.section].zoneHeight
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { 10 }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 10))
    }
}

// MARK: -
extension HomeViewModel {
    
    func setupZones() {
        
        let appointment = HomeFunctionItem(title: "预约列表", imageStr: "home_appointment_list", type: .appointment)
        let productManagement = HomeFunctionItem(title: "商品管理", imageStr: "home_product", type: .productManagement)
        let petManagement = HomeFunctionItem(title: "宠物管理", imageStr: "home_pet", type: .petManagement)
        let appointmentSetting = HomeFunctionItem(title: "预约设置", imageStr: "home_appointment_setting", type: .appointmentSetting)
        let orderHistory = HomeFunctionItem(title: "历史订单", imageStr: "home_orderHistory", type: .orderHistory)
        let businessManagement = HomeFunctionZone(title: "业务管理",
                                                  type: .businessManagement,
                                                  functionItems: [appointment, productManagement, petManagement, appointmentSetting, orderHistory])
        
        let memberManagement = HomeFunctionItem(title: "会员管理", imageStr: "home_membership", type: .memberManagement)
        let membershipCard = HomeFunctionItem(title: "会员卡", imageStr: "home_vip_card", type: .membershipCard)
        let limitedUseCard = HomeFunctionItem(title: "次卡", imageStr: "home_limit_use_card", type: .limitedUseCard)
        let discountCoupon = HomeFunctionItem(title: "优惠券", imageStr: "home_discount_coupon", type: .discountCoupon)
        let memberCenter = HomeFunctionZone(title: "会员中心",
                                            type: .memberCenter,
                                            functionItems: [memberManagement, membershipCard, limitedUseCard, discountCoupon])
        
        let storeManagement = HomeFunctionItem(title: "店铺管理", imageStr: "home_store_manage", type: .storeManagement)
        let staffManagement = HomeFunctionItem(title: "员工管理", imageStr: "home_staff_manage", type: .staffManagement)
        let storeReviews = HomeFunctionItem(title: "店铺评价", imageStr: "home_store_reviews", type: .storeReviews)
        let dataStatistics = HomeFunctionItem(title: "数据统计", imageStr: "home_data_statistics", type: .dataStatistics)
        let storeConfiguration = HomeFunctionZone(title: "店铺配置",
                                                  type: .storeConfiguration,
                                                  functionItems: [storeManagement, staffManagement, storeReviews, dataStatistics])

        homeZones = [businessManagement, memberCenter, storeConfiguration]
    }
    
    func buildUI() {
        loginBtn = UIButton(type: .custom)
        loginBtn.titleLabel?.font = UIFont.pingfang(style: .medium, size: 17)
        loginBtn.backgroundColor = SystemColor.Button.enable
        loginBtn.setTitle("登录后体验完整功能", for: .normal)
        loginBtn.setTitleColor(.black, for: .normal)
        loginBtn.layer.masksToBounds = true
        loginBtn.layer.cornerRadius = 25
        loginBtn.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        mainTableView = UITableView(frame: .zero, style: .plain)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.backgroundColor = .clear
        mainTableView.separatorStyle = .none
        mainTableView.showsVerticalScrollIndicator = false
        if #available(iOS 15.0, *) {
            mainTableView.sectionHeaderTopPadding = 0
        }
        mainTableView.register(HomeFunctionalZoneCell.self, forCellReuseIdentifier: HomeFunctionalZoneCell.reuseIdentity())
    }
}
