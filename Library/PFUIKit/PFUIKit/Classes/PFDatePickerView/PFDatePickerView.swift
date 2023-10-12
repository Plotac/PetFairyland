//
//  PFDatePickerView.swift
//  PFUIKit
//
//  Created by Ja on 2023/7/27.
//

import UIKit
import JXSegmentedView

public protocol PFDatePickerViewDelegate: NSObjectProtocol {
    func datePickerView(_ datePickerView: PFDatePickerView, didSelectedItemAt index: Int)
}

extension PFDatePickerViewDelegate {
    func datePickerView(_ datePickerView: PFDatePickerView, didSelectedItemAt index: Int) {}
}

public class PFDatePickerView: UIView {
    
    public internal(set) var limiteDays: Int = 0
    
    public weak var delegate: PFDatePickerViewDelegate?
    
    private(set) var segmentView: JXSegmentedView!
    
    private let dataSource: JXSegmentedTitleAttributeDataSource = JXSegmentedTitleAttributeDataSource()
    
    private var dateList: [DatePickModel] = []
    
    
    public required init(frame: CGRect, limiteDays: UInt) {
        super.init(frame: frame)
        self.limiteDays = Int(limiteDays)
        generateDateList()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PFDatePickerView {
    
}

extension PFDatePickerView: JXSegmentedViewDelegate {
    public func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        delegate?.datePickerView(self, didSelectedItemAt: index)
    }
}

private extension PFDatePickerView {
    func setupUI() {
        backgroundColor = .white
        
        segmentView = JXSegmentedView()
        
        var normalTexts: [NSAttributedString] = []
        var selectedTexts: [NSAttributedString] = []
        for model in dateList {
            let attriText = NSMutableAttributedString(string: "\(model.exactDate)\n\(model.weekday)")
            
            let dateRange: NSRange = NSRange(attriText.string.range(of: model.exactDate)!, in: attriText.string)
            let weekdayRange: NSRange = NSRange(attriText.string.range(of: model.weekday)!, in: attriText.string)
            
            attriText.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.black,
                                     NSAttributedString.Key.font: UIFont.pingfang(style: .medium, size: 14)], range: dateRange)
            attriText.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.black,
                                     NSAttributedString.Key.font: UIFont.pingfang(style: .regular, size: 13)], range: weekdayRange)
            
            format(attriText: attriText, selected: false)
            if let copyAttriText = attriText.copy() as? NSAttributedString {
                normalTexts.append(copyAttriText)
            }

            format(attriText: attriText, selected: true)
            if let copyAttriText = attriText.copy() as? NSAttributedString {
                selectedTexts.append(copyAttriText)
            }
        }
        dataSource.attributedTitles = normalTexts
        dataSource.selectedAttributedTitles = selectedTexts
        dataSource.itemSpacing = 0
        // 最多显示7天
        dataSource.itemWidth = (Screen.width - 10 * 2)/min(CGFloat(dateList.count), 7.0)
        
        segmentView.dataSource = dataSource
        segmentView.delegate = self
        addSubview(segmentView)
        segmentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(10)
        }
        
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorColor = SystemColor.main
        indicator.indicatorWidth = 30
        indicator.indicatorHeight = 3
        indicator.layer.cornerRadius = 1.5
        indicator.layer.masksToBounds = true
        segmentView.indicators = [indicator]
        
        func format(attriText: NSMutableAttributedString, selected: Bool) {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5
            paragraphStyle.alignment = .center
            let range = NSRange(attriText.string.range(of: attriText.string)!, in: attriText.string)
            attriText.addAttributes([
//                NSAttributedString.Key.foregroundColor: selected ? SystemColor.main : UIColor.black,
//                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
                NSAttributedString.Key.paragraphStyle: paragraphStyle],
                                    range: range)
        }
    }
    
    
    
    func generateDateList() {
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: Date()) // 当前日期的开始时间
        
        for day in 0..<limiteDays {
            if let date = calendar.date(byAdding: .day, value: day, to: startDate) {
                let dateData = formatDate(date: date)
                if let exactDate = dateData.components(separatedBy: ":").first, exactDate.isEmpty == false,
                   let weekday = dateData.components(separatedBy: ":").last, weekday.isEmpty == false {
                    let localDateStr = transLocal(exactDate: exactDate, weekday: weekday)
                    if localDateStr.isEmpty == false {
                        var model = DatePickModel(exactDate: exactDate,
                                                  weekday: localDateStr,
                                                  selected: formatDate(date: Date()).components(separatedBy: ":").first == exactDate)
                        dateList.append(model)
                    }
                }
            }
        }
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd:EEEE"
        return dateFormatter.string(from: date)
    }
    
    func transLocal(exactDate: String, weekday: String) -> String {
        if let today = formatDate(date: Date()).components(separatedBy: ":").first, today == exactDate {
            return "今天"
        }
        
        switch weekday {
        case "Monday":
            return "周一"
        case "Tuesday":
            return "周二"
        case "Wednesday":
            return "周三"
        case "Thursday":
            return "周四"
        case "Friday":
            return "周五"
        case "Saturday":
            return "周六"
        case "Sunday":
            return "周日"
        default:
            return weekday
        }
    }
}
