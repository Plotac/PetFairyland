//
//  HomeModel.swift
//  PetFairyland
//
//  Created by Ja on 2023/7/25.
//

import Foundation

// MARK: 今日店铺营业数据
struct HomeOperatingDataItem {
    
    enum ItemType {
    case orders, turnover, sales
    }
    
    var title: String = ""
    
    var quantity: Double = 0
    
    var unit: String = "单"
    
    var type: HomeOperatingDataItem.ItemType = .orders
    
    var colors: (startColor: UIColor, endColor: UIColor) = (.white, .white)
}

struct HomeFunctionZone {
    enum ZoneType {
        case unknown
        /// 业务管理
        case businessManagement
        /// 会员中心
        case memberCenter
        /// 店铺配置
        case storeConfiguration
    }
    
    var title: String = ""
    
    var type: HomeFunctionZone.ZoneType = .unknown
    
    var functionItems: [HomeFunctionItem] = []
    
    var zoneHeight: CGFloat {
        let margin: CGFloat = 15
        let titleLabHeight: CGFloat = 23
        let lineCount = ceil((CGFloat(functionItems.count) / CGFloat(maxiNumberOfDisplaysPerRow)))
        return margin + titleLabHeight + margin + itemHeight * lineCount + minimumLineSpacing * (lineCount - 1) + margin
    }
    
    var maxiNumberOfDisplaysPerRow: Int = 4
    
    var itemHeight: CGFloat = 75
    
    var minimumLineSpacing: CGFloat = 20
    
    var minimumInteritemSpacing: CGFloat = 0
}

struct HomeFunctionItem {
    
    enum ItemType {
        case unknown
        
        /* ----  业务管理  ---- */
        /// 预约列表
        case appointment
        /// 商品管理
        case productManagement
        /// 宠物管理
        case petManagement
        /// 预约设置
        case appointmentSetting
        /// 历史订单
        case orderHistory
        
        /* ----  会员中心  ---- */
        /// 会员管理
        case memberManagement
        /// 会员卡
        case membershipCard
        /// 次卡
        case limitedUseCard
        /// 优惠券
        case discountCoupon
        
        /* ----  店铺配置  ---- */
        /// 店铺管理
        case storeManagement
        /// 员工管理
        case staffManagement
        /// 店铺评价
        case storeReviews
        /// 数据统计
        case dataStatistics
    }
    
    var title: String = ""
    var imageStr: String = ""
    var type: HomeFunctionItem.ItemType = .unknown
}
