//
//  HomeItem.swift
//  PetFairyland
//
//  Created by Ja on 2023/7/25.
//

import Foundation

struct HomeItem {
    
    enum HomeItemType {
        case unknown
        /// 预约列表
        case appointment
        /// 产品管理
        case productManagement
        /// 会员管理
        case memberManagement
        /// 会员卡
        case membershipCard
        /// 门店管理
        case storeManagement
        /// 员工管理
        case staffManagement
        /// 财务状况
        case financialSituation
    }
    
    var title: String = ""
    var imageStr: String = ""
    var type: HomeItemType = .unknown
}
