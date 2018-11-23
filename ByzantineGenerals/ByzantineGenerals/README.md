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
Most of these parameters are passed along to distribute order if the recursion level left is greater than -1. 
While all that's left for `hearOrder` to do is record the order.  
`distributeOrder` iterates through the list of generals and calls `shareOrder` with each of them if they are not themself or the general which passed the order to them most recently.  
`shareOrder` determines what order to send to the general specified. 
If the general sharing the order is a traitor, it will send it's majority order if the receiving general has an odd, otherwise it will send the opposite of their majority vote.  
`majority` finds and returns the majority decision in that general's `record`. 

## Validation

While it appears the algorithm may be implemented when performing a static analysis. 
Upon running tests, its apparent this implementation doesn't execute the command in layers as the algorithm guideline suggests. 

With 4 generals, none of them being traitors, with _m_ = 0 gives us:  
```
General0 :: is first commander
General0 :: [Attack: 1, Retreat: 0]
General0 :: votes ATTACK
General1 :: [Attack: 1, Retreat: 0]
General1 :: votes ATTACK
General2 :: [Attack: 1, Retreat: 0]
General2 :: votes ATTACK
General3 :: [Attack: 1, Retreat: 0]
General3 :: votes ATTACK
```

So our base case execute correctly.  
Setting _m_ = 1 then yields:  
```
General0 :: is first commander
General0 :: [Attack: 3, Retreat: 0]
General0 :: votes ATTACK
General1 :: [Attack: 3, Retreat: 0]
General1 :: votes ATTACK
General2 :: [Attack: 1, Retreat: 0]
General2 :: votes ATTACK
General3 :: [Attack: 3, Retreat: 0]
General3 :: votes ATTACK
```

Which again is correct. 

Once we introduce a traitor who is not the first commander, we still see the correct result!  
```
General0 :: is first commander
General2 :: Traitor: is traitor
General0 :: [Attack: 1, Retreat: 0]
General0 :: votes ATTACK
General1 :: [Attack: 3, Retreat: 0]
General1 :: votes ATTACK
General2 :: [Attack: 3, Retreat: 0]
General2 :: votes ATTACK
General3 :: [Attack: 3, Retreat: 0]
General3 :: votes ATTACK
```

It's only once they are set to the commander that we see the problem arrise:  
```
General2 :: Traitor: is traitor
General2 :: is first commander
General0 :: [Attack: 0, Retreat: 3]
General0 :: votes RETREAT
General1 :: [Attack: 1, Retreat: 2]
General1 :: votes RETREAT
General2 :: [Attack: 1, Retreat: 0]
General2 :: votes ATTACK
General3 :: [Attack: 1, Retreat: 2]
General3 :: votes RETREAT
```

This is because the algorithm is meant for the OM(_m_) algorithm to run on the first commander. 
Then OM(_m_-1) to run on all but the first commander, then OM(_m_-2) to run on all the commanders for each time they're called from the OM(_m_-1 algorithm). 
Instead this implementation calls OM(_m_) on the first commander, then OM(_m_-1) on the first general the first general the commander calls, then OM(_m_-2) on all the other generals called by that most recently called general by the top level commander. 
Once the bottom layer has full executed, the call stack then goes to the OM algorithm just above for the next general. 
This means that the algorithm is going to be regularly called on nearly empty records because every generals's record will first filled with low id generals results. 

To fix this, each layer needs to be completed before calling the next. 
My tricky has been that I'm uncertain how to stop execution and resume when operating on a single-thread application in Swift. 

## Biography

[1] L. Lamport et al., “The Byzantine Generals Problem ,” ACM Transactions on Programming Languages and Systems, July 1982, pp. 382-401. [Onlineserial]. Available: https://www.microsoft.com/en-us/research/uploads/prod/2016/12/The-Byzantine-Generals-Problem.pdf. [Accessed Nov. 22, 2018].
