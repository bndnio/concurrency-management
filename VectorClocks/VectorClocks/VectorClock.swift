//
//  VectorClock.swift
//  VectorClocks
//
//  Created by Brendon Earl on 2018-11-21.
//  Copyright © 2018 Brendon Earl. All rights reserved.
//

class VectorClock: CustomStringConvertible {
    let id: String
    var clks: [String: Int]
    
    init(_ id: String) {
        self.id = id
        self.clks = [self.id: 0]
    }
    
    public var description: String {
        return clks.description
    }
    
    public func increment() {
        self.clks[self.id]! += 1
    }
    
    public func update(_ nvclk: VectorClock) {
        for (id, clk) in nvclk.clks {
            if self.clks[id] ?? 0 < clk {
                self.clks[id] = clk
            }
        }
    }
}
