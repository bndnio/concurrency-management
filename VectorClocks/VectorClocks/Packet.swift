//
//  Packet.swift
//  VectorClocks
//
//  Created by Brendon Earl on 2018-11-21.
//  Copyright © 2018 Brendon Earl. All rights reserved.
//

struct Packet {
    var vclk: VectorClock
    let pl: Any
}
