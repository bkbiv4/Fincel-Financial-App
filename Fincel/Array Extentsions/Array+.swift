//
//  Array+.swift
//  Fincel
//
//  Created by Bruce Beuzard IV on 12/12/22.
//

import Foundation

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
