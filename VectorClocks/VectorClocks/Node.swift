//
//  Node.swift
//  VectorClocks
//
//  Created by Brendon Earl on 2018-11-21.
//  Copyright © 2018 Brendon Earl. All rights reserved.
//

class Node {
    public let id: String
    let vclk: VectorClock
    
    init(_ id: String) {
        self.id = id
        self.vclk = VectorClock(id)
    }
    
    func startChain(_ chain: [Node]) {
        self.msgChain(Packet(vclk: self.vclk, pl: chain))
    }
    
    func msgChain(_ pkt: Packet) {
        print("Node \(self.id):: msgChain called")
        print("Node \(self.id):: Vector Clock: \(self.vclk)")
        self.vclk.update(pkt.vclk)
        print("Node \(self.id):: Merged Clock: \(self.vclk)")
        self.vclk.increment()
        print("Node \(self.id):: Update Clock: \(vclk)")
        switch pkt.pl {
        case let pl as Array<Node>:
            if pl.count == 0 { return }
            let nextDest = pl[0]
            print("Node \(self.id):: Triggering Node: \(nextDest.id)\n")
            nextDest.msgChain(Packet(vclk: self.vclk, pl: Array(pl.dropFirst())))
        default:
            break
        }
        
    }
}
