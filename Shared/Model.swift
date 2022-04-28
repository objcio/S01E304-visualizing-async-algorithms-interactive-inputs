//
//  Model.swift
//  AsyncAlgorithmsVisualization
//
//  Created by Chris Eidhof on 27.04.22.
//

import Foundation
@preconcurrency import SwiftUI

enum Value: Hashable, Sendable {
    case int(Int)
    case string(String)
}

struct Event: Identifiable, Hashable, Sendable, Comparable {
    static func < (lhs: Event, rhs: Event) -> Bool {
        lhs.time < rhs.time
    }
    
    var id: Int
    var time: TimeInterval
    var color: Color = .green
    var value: Value
}

var sampleInt: [Event] = [
    .init(id: 0, time:  0, color: .red, value: .int(1)),
    .init(id: 1, time:  1, color: .red, value: .int(2)),
    .init(id: 2, time:  2, color: .red, value: .int(3)),
    .init(id: 3, time:  5, color: .red, value: .int(4)),
    .init(id: 4, time:  8, color: .red, value: .int(5)),
]

var sampleString: [Event] = [
    .init(id: 100_0, time:  1.5, value: .string("a")),
    .init(id: 100_1, time:  2.5, value: .string("b")),
    .init(id: 100_2, time:  4.5, value: .string("c")),
    .init(id: 100_3, time:  6.5, value: .string("d")),
    .init(id: 100_4, time:  7.5, value: .string("e")),
]
