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
    let generals: Array<General>
    var record: [Int: Order]
    
    init(_ id: Int, order: Order, traitor: Bool, generals: Array<General>) {
        self.id = id
        self.traitor = traitor
        self.order = order
        self.generals = generals
        self.record = [self.id: self.order]
    }
    
    func distributeOrder() {
        for general in generals {
            shareOrder(general)
        }
    }
    
    func shareOrder(_ general: General) {
        if general.id % 2 == 0 {
            general.hearOrder(self.id, self.order)
        }
        switch self.order {
        case Order.ATTACK: general.hearOrder(self.id, Order.RETREAT)
        case Order.RETREAT: general.hearOrder(self.id, Order.ATTACK)
        }
    }
    
    func hearOrder(_ tellId: Int, _ order: Order) {
        record[tellId] = order
    }
}
