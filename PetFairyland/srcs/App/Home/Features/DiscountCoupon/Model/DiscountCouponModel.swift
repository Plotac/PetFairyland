//
//  DiscountCouponModel.swift
//  PetFairyland
//
//  Created by Ja on 2023/10/13.
//

import Foundation

class DiscountCouponModel: NSObject {
    
    enum CouponType {
        // 满减券
        case moneyOff
        // 折扣券
        case discount
    }
    
    enum UsageStatus {
        // 可用
        case enable
        // 不可用
        case disabled
    }
    
    enum ValidityPeriodType  {
        // 永久有效
        case forever
        // 自领取之日起n天内有效
        case limitDays(_ days: Int)
        // 截止日期前有效(年月日)
        case beforeExpirationDate(_ timeInterval: TimeInterval)
        // 时间段内有效
        case timePeriod(_ startDate: TimeInterval, _ endDate: TimeInterval)
        
        var description: String {
            switch self {
            case .forever:
                return "永久有效"
            case .limitDays(let days):
                return "自领取之日起\(days)日内有效"
            case .beforeExpirationDate(let timeInterval):
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy.MM.dd"
                formatter.locale = Locale.current
                let date = formatter.string(from: Date(timeIntervalSince1970: timeInterval))
                return "请在\(date)前使用"
            case .timePeriod(let start, let end):
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy.MM.dd"
                formatter.locale = Locale.current
                let startDate = formatter.string(from: Date(timeIntervalSince1970: start))
                let endDate = formatter.string(from: Date(timeIntervalSince1970: end))
                return "\(startDate)-\(endDate)期间内有效"
            }
        }
    }
    
    /// 优惠券类型（满减券 / 折扣券）
    var type: CouponType = .moneyOff
    /// 优惠券可用状态（可用 / 不可用）
    var status: UsageStatus = .enable
    /// 优惠券有效期
    var validityType: ValidityPeriodType = .forever
    /// 满足优惠券的目标金额
    var targetAmount: Int = 0
    /// 优惠金额 / 优惠折扣
    var discount: Float = 0
    /// 可否与会员价同时使用
    var sharedWithMemberPrice: Bool = false
    
    // Local
    /// 优惠券标题
    var title: String { "满\(targetAmount)元可用" }
    /// 单位
    var unit: String { type == .moneyOff ?  "¥" : "折" }
    
}
