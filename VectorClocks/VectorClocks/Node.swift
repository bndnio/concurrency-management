//
//  Node.swift
//  VectorClocks
//
//  Created by Brendon Earl on 2018-11-21.
//  Copyright © 2018 Brendon Earl. All rights reserved.
//

struct Packet {
    var vclk: VectorClock
    let pl: Any
}

class Node {
    public let id: String
    let vclk: VectorClock
    
    init(_ id: String) {
        self.id = id
        self.vclk = VectorClock(id)
    }
    
    public func printCompare(_ onode: Node) {
        self.vclk.printCompare(onode.vclk)
    }
    
    public func event() {
        print("Node \(self.id):: Event Triggered")
        self.vclk.increment()
        print("Node \(self.id):: Event Clock: \(self.vclk)")
    }
    
    public func startChain(_ chain: [Node]) {
        self.msgChain(Packet(vclk: self.vclk, pl: chain))
    }
    
    public func msgChain(_ pkt: Packet) {
        print("Node \(self.id):: msgChain called")
        self.event()
        print("Node \(self.id):: Vector Clock: \(self.vclk)")
        self.vclk.update(pkt.vclk)
        print("Node \(self.id):: Merged Clock: \(self.vclk)")
        switch pkt.pl {
        case let pl as Array<Node>:
            if pl.count == 0 { return }
            self.event()
            print("Node \(self.id):: Sender Clock: \(self.vclk)")
            let nextDest = pl[0]
            print("Node \(self.id):: Triggering Node: \(nextDest.id)\n")
            nextDest.msgChain(Packet(vclk: self.vclk, pl: Array(pl.dropFirst())))
        default:
            break
        }
    }
}
