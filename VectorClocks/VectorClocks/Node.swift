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

class Node: CustomStringConvertible {
    let id: String
    let vclk: VectorClock
    
    init(_ id: String) {
        self.id = id
        self.vclk = VectorClock(id)
    }
    
    // String for print() call
    public var description: String {
        return "Node\(self.id): \(vclk.description)"
    }
    
    // Print relation between self and another node
    func printCompare(_ onode: Node) {
        // print comparision
        print("Node\(self.id) is \(self.vclk.compare(onode.vclk)!) with Node\(onode.id)")
    }
    
    // Mark event occurence
    func event() {
        self.vclk.increment()
    }
    
    // Start chain of messages
    func startChain(_ chain: [Node]) {
        self.send(chain[0], Packet(vclk: self.vclk, pl: Array(chain.dropFirst())))
    }
    
    // Recieve message with Packet
    func msg(_ pkt: Packet) {
        // Mark event and update vector clock
        self.event()
        self.vclk.update(pkt.vclk)
        switch pkt.pl {
        case let pl as Array<Node>:
            // If payload empty, abort
            if pl.count == 0 { return }
            // Otherwise drop first pl element and trigger send to next hop
            let nextDest = pl[0]
            self.send(nextDest, Packet(vclk: self.vclk, pl: Array(pl.dropFirst())))
        default:
            break
        }
    }
    
    // Send message with Packet
    func send(_ nextDest: Node, _ pkt: Packet) {
        // Mark event and and message
        self.event()
        nextDest.msg(pkt)
    }
}
