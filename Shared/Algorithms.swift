//
//  Algorithms.swift
//  AsyncAlgorithmsVisualization
//
//  Created by Chris Eidhof on 27.04.22.
//

import Foundation
import AsyncAlgorithms

enum Algorithm: String, CaseIterable, Identifiable {
    case merge
    case chain
    
    var id: Self {
        self
    }
}

extension Array where Element == Event {
    @MainActor
    func stream(speedFactor: Double) -> AsyncStream<Event> {
        AsyncStream { cont in
            let events = sorted()
            for event in events {
                Timer.scheduledTimer(withTimeInterval: event.time/speedFactor, repeats: false) { _ in
                    cont.yield(event)
                    if event == events.last {
                        cont.finish()
                    }
                }
            }
        }
    }
}

func run(algorithm: Algorithm, _ events1: [Event], _ events2: [Event]) async -> [Event] {
    let factor: Double = 10
    let stream1 = await events1.stream(speedFactor: factor)
    let stream2 = await events2.stream(speedFactor: factor)
    
    switch algorithm {
    case .merge:
        let merged = merge(stream1, stream2)
        return await Array(merged)
    case .chain:
        var result: [Event] = []
        let startDate = Date()
        for await event in chain(stream1, stream2) {
            let interval = Date().timeIntervalSince(startDate) * factor
            result.append(Event(id: event.id, time: interval, color: event.color, value: event.value))
        }
        return result
    }
}
