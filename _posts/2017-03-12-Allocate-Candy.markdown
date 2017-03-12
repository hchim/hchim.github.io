---
layout: post
---

There are N children standing in a line. Each child is assigned a rating value. You are giving candies to these children subjected to the following requirements:

Each child must have at least one candy.
Children with a higher rating get more candies than their neighbors.
What is the minimum candies you must give?

#### Analysis

1. Scan the array from the first one to the last one. If ratings[i] > ratings[i-1], 
   allocate one more candy than i-1, otherwise allocate 1 candy. Save the result in table1.
1. Scan the array from the last one to the first one. If ratings[i] > ratings[i+1], allocate 
   one more candy than i+1, otherwise allocate one candy. Save the result in table2.
1. Combine the previous two allocation results. For position i, allocate the max(table1[i], table2[i]) candies.

```
public int candySimple(int[] ratings){
    if(ratings == null || ratings.length == 0) 
      return 0;
    if(ratings.length == 1) 
      return 1;
    int[] temp = new int[ratings.length];       
    temp[0] = 1;
    // scan from left to right
    for(int i = 1; i < ratings.length; i++){
        if(ratings[i] > ratings[i-1])
            temp[i] = temp[i-1] + 1;
        else temp[i] = 1;
    }
        
    temp[ratings.length - 1] = Math.max(1, temp[ratings.length - 1]);   
    int last = 1, total = temp[ratings.length - 1];
    // scan from right to left
    for(int i = ratings.length - 2; i >= 0 ; i--){
        if(ratings[i] > ratings[i+1])
            last = last + 1;
        else last = 1;
        // the number to allocate for the ith child  
        temp[i] = Math.max(temp[i], last);
        total += temp[i];
    }

    return total;
}
```
