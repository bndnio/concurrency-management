//
//  main.swift
//  VectorClocks
//
//  Created by Brendon Earl on 2018-11-21.
//  Copyright © 2018 Brendon Earl. All rights reserved.
//

let node1 = Node("1")
let node2 = Node("2")
let node3 = Node("3")

node3.startChain([node2, node1, node2, node2, node1, node3])
