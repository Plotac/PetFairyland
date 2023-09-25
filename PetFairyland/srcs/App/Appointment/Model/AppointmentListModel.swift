//
//  AppointmentListModel.swift
//  PetFairyland
//
//  Created by Ja on 2023/9/25.
//

import Foundation

class AppointmentListModel: NSObject {
    
    enum Status: Int {
        /// 未完成
        case unfinished = 0
        /// 已完成
        case finished
        /// 已取消
        case canceled
    }
    
    enum OrderType: Int {
        /// 未查看的新订单
        case new = 0
        /// 已查看的订单
        case old
    }
    
    enum IdentityType: Int {
        /// 会员
        case memeber = 0
        /// 次卡
        case limitCard
        /// 散客
        case customer
        
        var description: String {
            switch self {
            case .memeber: return "会员"
            case .limitCard: return "次卡用户"
            case .customer: return "散客"
            }
        }
    }
    
    var productUrl: String = ""
    
    var productName: String = ""
    
    var pet: String = ""
    
    var master: String = ""
    
    var appointmentServer: String = ""
    
    var appointmentTime: Int64 = 0
    
    var remark: String = ""
    
    var status: Status = .unfinished
    
    var type: OrderType = .old
    
    var identityType: IdentityType = .customer
}
