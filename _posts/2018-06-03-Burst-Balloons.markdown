---
layout: post
categories: Leetcode
tags: [array, dynamic-programming]

---

Given n balloons, indexed from 0 to n-1. Each balloon is painted with a number on it represented by array nums. You are asked to burst all the balloons. If the you burst balloon i you will get nums[left] * nums[i] * nums[right] coins. Here left and right are adjacent indices of i. After the burst, the left and right then becomes adjacent.

Find the maximum coins you can collect by bursting the balloons wisely.

Note:

    You may imagine nums[-1] = nums[n] = 1. They are not real therefore you can not burst them.
    0 ≤ n ≤ 500, 0 ≤ nums[i] ≤ 100

Example:

```
Input: [3,1,5,8]
Output: 167 
Explanation: nums = [3,1,5,8] --> [3,5,8] -->   [3,8]   -->  [8]  --> []
             coins =  3*1*5      +  3*5*8    +  1*3*8      + 1*8*1   = 167
```


Let, `DP[i, j]` to be the max coins of array `A[i..j]`
     `k` to be the last balloon to burst to get max coins. `i <= k <= j`
Then, `DP[i, j] = A[k] * A[i-1] * A[j+1] + P[i, k-1] + P[k+1, j]`.
Based on this equation we can divide the problem to two subproblems. Because
some of the subproblems are duplicates if we solve the problem recursively, we
can use dynamic method to memorize the solutions of subproblems to optimize the
time complexity of the algorithm. The time complexity of the dynamic programming
solution is O(n^3).

```java
    public int maxCoins(int[] nums) {
        int[][] table = new int[nums.length][nums.length];

        return dp(nums, 0, nums.length - 1, table);
    }

    private int dp(int[] nums, int i, int j, int[][] table) {
        if (i > j) {
            return 0;
        }

        if (table[i][j] > 0) {
            return table[i][j];
        }

        int left = (i - 1 < 0) ? 1 : nums[i - 1];
        int right = (j + 1 == nums.length) ? 1 : nums[j + 1];
        for (int k = i; k <= j; k++) {
            table[i][j] = Math.max(table[i][j],
                left * right * nums[k] + dp(nums, i, k - 1, table) + dp(nums, k + 1, j, table));
        }
        return table[i][j];
    }
```