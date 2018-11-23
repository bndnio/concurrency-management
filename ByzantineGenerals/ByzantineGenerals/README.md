#  Byzantine Generals

##  Background

First let's start with a quick background on Byzantine Generals problem. 
It's often used as an example to reason about untrustworthy servers. 
In particular, when a distributed computing network is faced with a problem regarding concensus. 

It's laid out as a problem where a series of armies approach a kingdom to attack.  
The generals must coordinate whether they will attack, or retreat. 
And every general _must_ decide on the same thing
All communication is done via. messages from a single general to another. 
While this seems simple if the generals are guaranteed reliable communication and information. 
But it's not! 
There may be generals who are traitors which could relay any order to others. 
The problem also states that if a message is lost, a default command is assumed. 

The algorithm to solve this is as follows: [1]

For Algorithm OM(0):  
1. The commander sends his value to every lieutenant.  
2. Each lieutenant uses the value he receives from the commander, or uses the value RETREAT if he receives no value.  

For Algorithm OM(_m_), _m_ > 0
1. The commander sends his value to every lieutenant.  
2. For each _i_, let _vi_ be the value Lieutenant _i_ recieves from the commander, or else be RETREAT if he receives no value. Lieutenant _i_ acts as the commander in Algorithm OM(_m_-1) to send the value _vi_ to each of the _n_-2 other lieutenants.  
3. For each _i_, and each _j_ =/= _i_, let _vj_ be the value Lieutenant _i_ received from Lieutenant _j_ in step (2) (using Algorithm OM(_m_-1)), or else RETREAT if he received no such value. Lieutenant _i_ uses the value _majority_(_v1_, ..., _v(n-1)_).

In practical terms, it means that for any 3_m_+1 generals, there may only be as many as _m_ traitors, and requries _m_ levels of recursion.  
A level of recursion can be describing as a round of every other general telling every other general (except the one that told them) their majority from that round. 

## Implementation

The Byzantine Generals problem is broken into two files. 

The main file, which contains code regarding coordination, and validation. 
And the General file, which holds the General class. 
The General class has a few key methods. 
`hearOrder` provides a method for other generals to communicate with that general. 
An order must be passed along with an array of other generals, recursion levels left, and who id of who the order came from. 
Most of these paramters are passed along to distribute order if the recrsion level left is greater than -1. 
While all that's left for `hearOrder` to do is record the order.  
`distributeOrder` iterates through the list of generals and calls `shareOrder` with each of them if they are not themself or the general which passed the order to them most recently.  
`shareOrder` determins what order to send to the general specified. 
If the general sharing the order is a traitor, it will send it's majority order if the recieving general has an odd, otherwise it will send the opposite of their majority vote.  
`majority` finds and returns the majority decision in that general's `record`. 

## Validation

While I believe the algorithm is implemented correctly 

## Biography

[1] L. Lamport et al., “The Byzantine Generals Problem ,” ACM Transactions on Programming Languages and Systems, July 1982, pp. 382-401. [Onlineserial]. Available: https://www.microsoft.com/en-us/research/uploads/prod/2016/12/The-Byzantine-Generals-Problem.pdf. [Accessed Nov. 22, 2018].
