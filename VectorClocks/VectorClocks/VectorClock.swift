//
//  VectorClock.swift
//  VectorClocks
//
//  Created by Brendon Earl on 2018-11-21.
//  Copyright © 2018 Brendon Earl. All rights reserved.
//

enum Relation {
    case EQUAL
    case HAPPENS_BEFORE
    case HAPPENS_AFTER
    case CONCURRENT
}

class VectorClock: CustomStringConvertible {
    let id: String
    var clks: [String: Int]
    
    init(_ id: String) {
        self.id = id
        self.clks = [self.id: 1]
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
    
    // Compare VectorClocks, return Relation
    public func compare(_ ovclk: VectorClock) -> Relation? {
        var relation: Relation?
        
        // Get union of ids in both vector clocks
        func extractId (_ id: String, _: Int) -> String { return id }
        let ids: [String] = Array(Set(ovclk.clks.map(extractId) + self.clks.map(extractId)))

        for id in ids {
            // get my and their time from vector clocks, defaults to 0
            let myTime = self.clks[id] ?? 0
            let theirTime = ovclk.clks[id] ?? 0
            
            if relation != nil {
                // based on set relation, keep or transition relations based on condition
                switch relation! {
                case Relation.EQUAL:
                    if myTime < theirTime { relation = Relation.HAPPENS_BEFORE }
                    else if myTime > theirTime { relation = Relation.HAPPENS_AFTER }
                case Relation.HAPPENS_BEFORE:
                    if myTime > theirTime { relation = Relation.CONCURRENT }
                case Relation.HAPPENS_AFTER:
                    if myTime < theirTime { relation = Relation.CONCURRENT }
                case Relation.CONCURRENT: continue
                }
            // if relation has not yet been set (first round)
            } else {
                // based on first value, declare what the relation looks like
                if myTime < theirTime { relation = Relation.HAPPENS_BEFORE }
                else if myTime > theirTime { relation = Relation.HAPPENS_AFTER }
                else if myTime == theirTime { relation = Relation.EQUAL }
                else { relation = Relation.CONCURRENT }
            }
        }
        return relation
    }
}
