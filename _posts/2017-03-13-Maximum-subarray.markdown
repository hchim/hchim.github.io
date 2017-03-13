---
layout: post
categories: Leetcode
---

Find the contiguous subarray within an array (containing at least one number) which has the largest sum.

For example, given the array [-2,1,-3,4,-1,2,1,-5,4], the contiguous subarray [4,-1,2,1] has the largest sum = 6. 

#### Analysis

For sub array A[0..i] there exist k such that A[k..i] is maximum, denoted as m[i]. So for the sub array A[0..i+1].

- If m[i] > 0, m[i+1] = A[i+1]+m[i]
- otherwise, m[i+1] = A[i+1]

```java
public int maxSubArrayDPSimple(int[] A) {
    if(A.length == 1) return A[0];
    int max = A[0];
    int pre = A[0];//this is m[i-1]
    for(int i = 1; i < A.length; i++){
        if(pre < 0) {
            pre = A[i];//set dp[i]
        }else{          
            pre = pre+A[i];
        }
        max = Math.max(max, pre);           
    }
    return max;
}
```
