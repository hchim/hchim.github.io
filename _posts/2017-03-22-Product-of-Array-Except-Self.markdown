---
layout: post
categories: [Leetcode]
tags: [array]

---


Given an array of n integers where n > 1, nums, return an array output such that output[i] is equal to the product 
of all the elements of nums except nums[i].

Solve it without division and in O(n).

For example, given [1,2,3,4], return [24,12,8,6].

`Follow up:`

Could you solve it with constant space complexity? (Note: The output array does not count as extra space for the 
purpose of space complexity analysis.)

### Solution

result[i] = P[0..i-1] * P[i+1..n]

So we visit the array from left to right first and save P[0..i] to the result array.
Then we visit the array from right to left and calculate P[i..n] and result[i].


```
    public int[] productExceptSelf(int[] nums) {
        if (nums == null || nums.length == 0) {
            return nums;
        }

        int[] result = new int[nums.length];
        result[0] = 1;
        for (int i = 1; i < nums.length; i++) {
            result[i] = result[i - 1] * nums[i - 1];
        }

        int last = 1;
        for (int i = nums.length - 2; i >= 0; i--) {
            last = last * nums[i + 1];
            result[i] = last * result[i];
        }

        return result;
    }
```