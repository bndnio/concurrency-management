//
//  main.swift
//  ByzantineGenerals
//
//  Created by Brendon Earl on 2018-11-21.
//  Copyright © 2018 Brendon Earl. All rights reserved.
//

var generals: Array<General>
generals = []

for i in 0..<4 {
    let isTraitor = (i+1)%3 == 0 ? true : false
    generals.append(General(i, traitor: isTraitor))
}

let commanderId = 2
generals[2].hearOrder(Order.ATTACK, generals, m: 1, from: nil)

print()
for general in generals {
    if general.traitor == true {
        print("General\(general.id) :: Traitor: is traitor")
    }
    if general.id == commanderId {
        print("General\(general.id) :: is first commander")
    }
    
}
for general in generals {
    print("General\(general.id) :: votes \(general.majority())")
}
