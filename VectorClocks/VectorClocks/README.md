#  Vector Clocks

##  Background

First let's start with a quick background on Vector Clocks. 
Vector clocks are a tool used in concurrent programming to assist with execution order and tracability. 
At a high level, a Vector clock is a collection of Lamport Logical clocks, each are associated with a particular process (or here, Node). 
When Nodes communicate, the send along their Vector Clock, so the recieving node can update theirs. 
By looking any Node's Vector Clock and comparing it with another's at any moment it time, it can be determined if the have a "Concurrent", "Happens Before", "Happens After", or "Equal" relationship.

For demonstartion purposes, let's assume some details: 
1. When a Node is initialized, it initialized it's own Vector Clock
2. When a Vector Clock is initialized, it contains only a single Logical Clock
3. The Vector Clock then contains a Logical Clock which is associated to that Node through some unique identifier
4. The Local Clock is incremented for every event (send, recieve, other)

Lets say our system starts by initializing 3 nodes: Node1, Node2, and Node 3. 
Each node then contains a Vector Clock with, which each contains a single Logical Clock for themselves. 

It would look something like this:  
```
Node1: ["1": 1]  
Node2: ["2": 1]  
Node3: ["3": 1]  
```

If Node1 calls Node2, their Vector Clocks will appear as follows:  
```
Node1: ["1": 2]
Node2: ["2": 2, "1": 2]
```

Where Node1 has seen two events: Initialize, and Send. 
While Node 2 has seen two events as well: Initialize, and Recieve.

To further this demonstration, observe the states in the following diagram:
// TODO: Add Timeline diagram

To test my implementation, we will actually execute and inspect this timeline in the implementation. 
We can then check at every point that the Vector Clocks are correct. 
Then, because each nodes' relationship can be determined based on a set of rules and/or graphically, we can validate the compare function. 

## Implementation

The implemention of the portion of the project was made relatively easy with the use of swift. 
While this is my first time using the language and there of course a learning curve, the fact that it is strongly typed and compiled made for quick debugging. 

The code is broken into three chunks: main, Node, and VectorClocks.  

The main file orchestrates the sample laid out above. 
It creates nodes, triggers message sending and event occurances, and organizes the output of the program.  

The Node file's main purpose is to declare the Node class. 
The Node class is a representation of a "Process" in many vector clock explanations. 
The Node class is capable of printing it's state, comparing itself with another node, recieving an event trigger, and sending/recieving messages (and even message chains). 

The VectorClock is at the heart of this project, as it tackles implementing vector clocks, and providing functions to work with them. 
In particular the VectorClock class maintains a collection of logical clocks, can compare itself against another vector clock, and can update itself based on another vector clock. 
A highlight of the VectorClock class is the compare function, as it implements a state machine to determine it's relationship with another vector clock. 
(See the state machine in the validation section).


## Validation



// TODO: Add Relationship State Machine diagram
