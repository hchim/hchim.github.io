Given n non-negative integers representing the histogram's bar height where the width of each bar is 1, 
find the area of largest rectangle in the histogram.

Above is a histogram where width of each bar is 1, given height = [2,1,5,6,2,3].
The largest rectangle is shown in the shaded area, which has area = 10 unit.

For example,

Given heights = [2,1,5,6,2,3], return 10. 

#### Analysis

Solving the problem with O(n2) time complexity is trivial. At each position i, we scan at both 
sides of i and looking for histograms that is higher than position i. Then we get the max rectangular area that include i.

We can also solve this problem in O(n) time. We scan the array from left to right, and stores 
the position of unfinished subhistograms (heights[i] >= the height of the histogram) 
in a stack. When one of the subhistogram finishes (height[i] < the height of the histogram), 
we compare the area with the max area. We add a fake histogram of height 0 to finish the search process.

Be careful with the start and end position of each subhistogram.

- The end position is current position.
- The start position has two possibilities after poping a position, 
which is the position of the min height of that subhistogram.
  1. stack is empty, start from 0.
  1. stack is not empty, start is the peak of stack plus 1.

```java
public int largestRectangleAreaStack(int[] height){
    if(height == null || height.length == 0)
        return 0;
        
    Stack<Integer> stack = new Stack<Integer>();
    int val = 0, max = 0, len, pos;

    for(int i = 0; i <= height.length; ){
        // add 0 to the end to finish the search process
        val = i < height.length ? height[i]:0;
        if(stack.empty() || val > height[stack.peek()]) {
            stack.push(i++);
        } else {//subhistogram finishes
            pos = stack.pop();
            if(stack.empty()) 
                len = i;
            else
                len = i - stack.peek() - 1;
            max = Math.max(max, len * height[pos]);
        }
    }
    
    return max;
}
```
