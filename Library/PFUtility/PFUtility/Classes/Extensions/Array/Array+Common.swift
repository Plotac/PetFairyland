//
//  Array+Common.swift
//  PFUtility
//
//  Created by Ja on 2023/9/21.
//

import Foundation

public extension Array {

    // Map函数的带Index版本
     func mapIndex<T>(_ event: @escaping (_ value: Element, _ index: Int) -> T) -> [T] {
        return indices.map { event(self[$0], $0) }
    }

    // ForEach函数的带Index版本
     func forEachIndex(_ event: @escaping (_ value: Element, _ index: Int) -> Void) {
        indices.forEach { event(self[$0], $0) }
    }

    // Reduce函数的带Index版本
     func reduceIndex<T>(_ inital: T, combine: (T, (value: Element, index: Int)) -> T) -> T {
        return indices.reduce(inital, { combine($0, (value: self[$1], index: $1)) })
    }

    // Filter函数的带Index版本
     func filterIndex(_ event: @escaping (_ value: Element, _ index: Int) -> Bool) -> [Element] {
        return indices.filter { event(self[$0], $0) }.map { self[$0] }
    }

    func safeIndex(newIndex: Int) -> Element? {
        if newIndex < 0 {
            return nil
        }
        if newIndex < count {
            return self[newIndex]
        } else {
            return nil
        }
    }
}
