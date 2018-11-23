//
//  main.swift
//  VectorClocks
//
//  Created by Brendon Earl on 2018-11-21.
//  Copyright © 2018 Brendon Earl. All rights reserved.
//

var vectorClocks: [String: VectorClock]

// Initialization
let node1 = Node("1")
vectorClocks = ["A": node1.vclk.copy()]
let node2 = Node("2")
vectorClocks["F"] = node2.vclk.copy()
let node3 = Node("3")
vectorClocks["K"] = node3.vclk.copy()

node1.startChain([node2])
vectorClocks["B"] = node1.vclk.copy()
vectorClocks["G"] = node2.vclk.copy()

// Inspection Point 1
print("Inspection Point 1")
print(node1)
print(node2)
print(node3)
print()

node1.event()
vectorClocks["C"] = node1.vclk.copy()
node2.startChain([node3])
vectorClocks["H"] = node2.vclk.copy()
vectorClocks["L"] = node3.vclk.copy()

// Inspection Point 2
print("Inspection Point 2")
print(node1)
print(node2)
print(node3)
print()

node2.startChain([node1])
vectorClocks["I"] = node2.vclk.copy()
vectorClocks["D"] = node1.vclk.copy()
node3.startChain([node2])
vectorClocks["M"] = node3.vclk.copy()
vectorClocks["J"] = node2.vclk.copy()

// Inspection Point 3
print("Inspection Point 3")
print(node1)
print(node2)
print(node3)
print()

node1.startChain([node3])
vectorClocks["E"] = node1.vclk.copy()
vectorClocks["N"] = node3.vclk.copy()

// Inspection Point 4
print("Inspection Point 4")
print(node1)
print(node2)
print(node3)
print()

// Print snapshot of vector clocks
var sortedVectorClocks = vectorClocks.sorted(by: { $0.0 < $1.0 })
for vectorClock in sortedVectorClocks {
    print(vectorClock)
}
print()

// Sample Vector clocks
vectorClocks["A"]!.printCompare(vectorClocks["B"]!)
vectorClocks["B"]!.printCompare(vectorClocks["A"]!)
vectorClocks["A"]!.printCompare(vectorClocks["G"]!)
vectorClocks["C"]!.printCompare(vectorClocks["H"]!)
vectorClocks["A"]!.printCompare(vectorClocks["L"]!)
vectorClocks["I"]!.printCompare(vectorClocks["M"]!)
vectorClocks["J"]!.printCompare(vectorClocks["E"]!)
vectorClocks["E"]!.printCompare(vectorClocks["L"]!)
vectorClocks["A"]!.printCompare(vectorClocks["N"]!)
print()

