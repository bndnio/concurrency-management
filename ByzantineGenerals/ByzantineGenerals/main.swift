//
//  main.swift
//  ByzantineGenerals
//
//  Created by Brendon Earl on 2018-11-21.
//  Copyright © 2018 Brendon Earl. All rights reserved.
//

//Part 2: Byzantine Generals [Due Nov 22nd]
//
//The OM(m) algorithm described in the Byzantine Generals Problem is foundational in distributed systems.  Using the programming language of your choice, implement your own version of this algorithm, and provide a testing framework for your system.
//
//    The inputs to your algorithm can be in an input file or on the command line, and should include the following:
//
//    m: the level of recursion in the algorithm, and assume m > 0.
//    G: A list of n generals: G0,G1,G2,…,Gn, each of which is either loyal or a traitor. G0 is the commander, and the remaining n−1 generals are the lieutenants.
//    Oc: The order the commander gives to its lieutenants (Oc ∈ {ATTACK,RETREAT})
//
//    If a general is loyal, and it has to relay an order O to general Gi, it always relays the value of O.
//    If a general is a traitor, and it has to relay an order O to general Gi, it will relay the value of O if i is odd, and it will send the opposite of O if i is even. Note that, in the case of a traitorous commander general, the order being relayed is still just Oc.
//
//When performing a majority vote, only ATTACK and RETREAT votes are taken into account, and it is enough for one of the two to have a relative majority (i.e., a plurality) to determine what action wins the vote. If the number of ATTACK and RETREAT votes is the same, then the result of the vote is a tie.

import Foundation

var generals: Array<General>
generals = []

for i in 0..<100 {
    generals.append(General(i, order: Order.ATTACK, traitor: false))
}

for general in generals {
    general.distributeOrder(generals)
}
