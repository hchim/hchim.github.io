---
layout: post
categories: Leetcode
tags: [array]

---

There are N gas stations along a circular route, where the amount of gas at station i is gas[i].
You have a car with an unlimited gas tank and it costs cost[i] of gas to travel from station i to 
its next station (i+1). You begin the journey with an empty tank at one of the gas stations.

Return the starting gas station's index if you can travel around the circuit once, otherwise return -1.

Note:
The solution is guaranteed to be unique. 

#### Analysis

If we can make the journey, the total gas must not less than the total cost. After we find out 
the position i with the minimum gas in tank, then start from the i+1 position will make the journey.

```java
public int canCompleteCircuit(int[] gas, int[] cost) {
 if(gas == null || cost == null) 
        return -1;
    int sum = 0;
    int min = Integer.MAX_VALUE; 
    int minPos = 0;

    for(int i = 0; i < gas.length; i++){
        sum += (gas[i] - cost[i]);
        if(sum < min){
            min = sum;
            minPos = i;
        }
    }
    
    if(sum < 0) return -1;
    return (minPos + 1) % gas.length;
}                              
```
