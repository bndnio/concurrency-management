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
    let order: Order
    var records: [Int: Order]
    
    init(_ id: Int, order: Order, traitor: Bool) {
        self.id = id
        self.traitor = traitor
        self.order = order
        self.records = [self.id: self.order]
    }
    
    func vote() -> Order {
        var attack_count = 0
        var retreat_count = 0
        for (_, order) in records {
            switch order {
            case Order.ATTACK: attack_count += 1
            case Order.RETREAT: retreat_count += 1
            }
        }
        print("General\(self.id):: [Attack \(attack_count), Retreat \(retreat_count)]")
        if attack_count > retreat_count { return Order.ATTACK }
        else if attack_count < retreat_count { return Order.RETREAT }
        else { return Order.ATTACK }
    }
    
    func distributeOrder(_ generals: Array<General>, m: Int) {
        if m == 0 {
            print("General\(self.id):: voting \(self.vote())")
            return
        }
        
        for general in generals {
            if self.id != general.id {
                shareOrder(general)
            }
        }
        self.distributeOrder(generals, m: m-1)
    }
    
    func shareOrder(_ general: General) {
        print("General \(self.id):: sharing order with \(general.id)")
        if general.traitor == false || general.id % 2 == 0 {
            general.hearOrder(self.id, self.order)
        }
        else {
            switch self.order {
            case Order.ATTACK: general.hearOrder(self.id, Order.RETREAT)
            case Order.RETREAT: general.hearOrder(self.id, Order.ATTACK)
            }
        }
    }
    
    func hearOrder(_ tellId: Int, _ order: Order) {
        print("General \(self.id):: hearing order from \(tellId)")
        records[tellId] = order
        
    }
}
