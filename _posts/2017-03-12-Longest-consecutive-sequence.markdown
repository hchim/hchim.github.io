---
layout: post
categories: Leetcode
---

Given an unsorted array of integers, find the length of the longest consecutive elements sequence. 
For example, Given [100, 4, 200, 1, 3, 2], The longest consecutive elements sequence is [1, 2, 3, 4]. 
Return its length: 4. Your algorithm should run in O(n) complexity.

#### Analysis

Basic idea:

1. push all number into a hash set in O(n) time.
1. for each number in the hash set, find the consecutive numbers that both larger than and less 
   than current number. Remove these numbers and count the length of this sequence. 
   It is O(n) time complexity because numbers belongs to a consecutive sequence are removed.

```java
public int longestConsecutive(int[] num) {
    HashSet<Integer> set = new HashSet<Integer>();
    for(int i = 0; i < num.length; i++)
        set.add(num[i]);
    int max = 0, temp;
    while(!set.isEmpty()){
        temp = nextLength(set);
        if(temp > max) 
          max = temp;
    }
    return max;
}
    
private int nextLength(HashSet<Integer> set){
    Integer val = set.iterator().next();
    set.remove(val);
    int len = 1, nextVal;
    nextVal = val + 1;
    while(set.contains(nextVal)){
        len++;
        set.remove(nextVal);
        nextVal++;
    }
    nextVal = val - 1;
    while(set.contains(nextVal)){
        len++;
        set.remove(nextVal);
        nextVal--;
    }
    return len;
}
```
