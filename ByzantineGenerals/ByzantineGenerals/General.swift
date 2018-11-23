//
//  General.swift
//  ByzantineGenerals
//
//  Created by Brendon Earl on 2018-11-21.
//  Copyright © 2018 Brendon Earl. All rights reserved.
//

enum Order {
    case ATTACK
    case RETREAT
}

class General {
    let id: Int
    let traitor: Bool
    var records: [Order]

    init(_ id: Int, traitor: Bool) {
        self.id = id
        self.traitor = traitor
        self.records = []
    }

    func hearOrder(_ order: Order, _ generals: Array<General>, m: Int, from: Int?) {
        records.append(order)
        
        if m >= 0 {
            self.distributeOrder(generals, m: m, from: from)
        }
    }
    
    func distributeOrder(_ generals: Array<General>, m: Int, from: Int?) {
        for general in generals {
            if self.id != general.id && from ?? -1 != general.id {
                self.shareOrder(general, generals, m: m-1)
            }
        }
    }
    
    func shareOrder(_ general: General, _ generals: Array<General>, m: Int) {
        if self.traitor == true && (general.id) % 2 == 0 {
            switch self.majority() {
            case Order.ATTACK: general.hearOrder(Order.RETREAT, generals, m: m, from: self.id)
            case Order.RETREAT: general.hearOrder(Order.ATTACK, generals, m: m, from: self.id)
            }
        }
        else {
           general.hearOrder(self.majority(), generals, m: m, from: self.id)
        }
    }
    
    func majority() -> Order {
        var attack_count = 0
        var retreat_count = 0
        
        for (order) in records {
            switch order {
            case Order.ATTACK: attack_count += 1
            case Order.RETREAT: retreat_count += 1
            }
        }
        print("General\(self.id) :: [Attack: \(attack_count), Retreat: \(retreat_count)]")
        if attack_count > retreat_count { return Order.ATTACK }
        else if attack_count < retreat_count { return Order.RETREAT }
        else { return Order.RETREAT }
    }
}
