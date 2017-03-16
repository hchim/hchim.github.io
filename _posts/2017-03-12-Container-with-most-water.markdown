---
layout: post
categories: Leetcode
tags: [array]

---

Given n non-negative integers a1, a2, ..., an, where each represents a point at coordinate (i, ai). 
n vertical lines are drawn such that the two endpoints of line i is at (i, ai) and (i, 0). Find two 
lines, which together with x-axis forms a container, such that the container contains the most water.

Note: You may not slant the container and n is at least 2. 

#### Analysis

Let S(i, j) be the area that composed by ai and aj.

S(i, j) = min(ai, aj) * (j - i)

For S(i', j') >= S(i, j)  (i' >= i; j' <= j)
because j' - i' <= j - i, we must have min(ai', aj') >= min(ai, aj)

So, we can use two pointers: left and right

```
if a_left < a_right
   left++
else
   right--
```

```java
    public int maxArea(int[] height) {
        if(height == null || height.length <= 1 )
            return 0;

        int max = 0;
        int i = 0, j = height.length - 1;

        while(i < j) {
            max = Math.max(max, Math.min(height[i], height[j]) * (j - i));
            if(height[i] > height[j])
                j--;
            else
                i++;
        }

        return max;
    }
```
