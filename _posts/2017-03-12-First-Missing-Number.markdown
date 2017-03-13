---
layout: post
---

Given an unsorted integer array, find the first missing positive integer.
```
For example,
Given [1,2,0] return 3,
and [3,4,-1,1] return 2.
```
Your algorithm should run in O(n) time and uses constant space. 

#### Analysis

- If the number is in the range (1, nums.length), we put the number to the position number - 1. We swap two numbers 
  when four conditions are met.
  - nums[i] <= nums.length  && nums[i] > 0  : it is a valid number
  - nums[i] != i+1 : the number is not on the correct position
  - nums[i] != nums[nums[i] - 1] : the number does not equal to the value on the correct position
- Then we scan from left to right and find out the first missing number.


```java
    public int firstMissingPositive(int[] nums) {
        //put number n to position n - 1
        for (int i = 0; i < nums.length;) {
            if (nums[i] <= nums.length && nums[i] > 0 //valid number
                    && nums[i] != (i + 1)  //not on the correct position
                    && nums[i] != nums[nums[i] - 1]) { //not equal to the value on the correct position
                swap(nums, i, nums[i] - 1);
            } else {
                i++;
            }
        }

        for (int i = 0; i < nums.length; i++) {
            if (nums[i] != (i + 1)) {
                return  i + 1;
            }
        }

        return nums.length + 1;
    }

    private void swap(int[] nums, int i, int j) {
        int temp = nums[i];
        nums[i] = nums[j];
        nums[j] = temp;
    }
```
