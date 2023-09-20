//
//  PFTimer.swift
//  PFAccount
//
//  Created by Ja on 2023/9/20.
//

import Foundation
 
public class PFTimer: NSObject {
    
    public typealias PFTimerEventHandler = () -> Void
    
    public enum Style {
        case normal, gcd
    }
    
    public internal(set) var style: PFTimer.Style = .normal
    
    internal var timeInterval: TimeInterval
    internal var target: AnyObject?
    internal var selector: Selector
    internal var repeats: Bool
    internal var handler: PFTimerEventHandler?
    
    internal var normalTimer: Timer?
    internal var gcdTimer: DispatchSourceTimer?
    
    public required init(timeInterval: TimeInterval,
                         target: AnyObject?,
                         selector: Selector,
                         repeats: Bool,
                         style: PFTimer.Style) {
        
        self.timeInterval = timeInterval
        self.target = target
        self.selector = selector
        self.repeats = repeats
        self.style = style
        
        super.init()
        
        if style == .normal {
            initNormal()
        } else {
            initGCD()
        }
    }
    
    public convenience init(timeInterval: TimeInterval,
                            repeats: Bool,
                            style: PFTimer.Style,
                            eventHandler: PFTimerEventHandler?) {
        self.init(timeInterval: timeInterval, target: nil, selector: Selector(""), repeats: repeats, style: style)
        
        self.handler = eventHandler
    }
    
    public func fire() {
        if style == .normal {
            normalTimer?.fireDate = Date()
        } else {
            gcdTimer?.resume()
        }
    }
    
    public func invalidate() {
        if style == .normal {
            normalTimer?.invalidate()
            normalTimer = nil
        } else {
            gcdTimer?.cancel()
            gcdTimer = nil
        }
    }
     
}

extension PFTimer {
    func initNormal() {
        let proxy = PFWeakProxy(target: self.target)
        let timer = Timer(timeInterval: timeInterval, target: proxy, selector: selector, userInfo: nil, repeats: repeats)
        RunLoop.current.add(timer, forMode: .common)
        
        normalTimer = timer
    }
    
    func initGCD() {

        gcdTimer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        
        gcdTimer?.schedule(deadline: .now() + timeInterval, repeating: repeats ? .seconds(1) : .never)
        
        gcdTimer?.setEventHandler { [weak self] in
            
            if let handler = self?.handler {
                DispatchQueue.main.async {
                    handler()
                }
            }
            
            if self?.repeats == false {
                self?.invalidate()
            }
        }
    }
}
