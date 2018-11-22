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
    
    func distributeOrder(_ generals: Array<General>) {
        for general in generals {
            if self.id != general.id {
                shareOrder(general)
            }
        }
        
        var attack_count = 0
        var retreat_count = 0
        for (_, order) in records {
            switch order {
            case Order.ATTACK: attack_count += 1
            case Order.RETREAT: retreat_count += 1
            }
        }
        print("General \(self.id):: concensus \(attack_count > retreat_count ? Order.ATTACK : Order.RETREAT)")
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
