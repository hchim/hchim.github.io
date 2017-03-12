### Best Time to Buy and Sell Stock I

Say you have an array for which the ith element is the price of a given stock on day i. If you were only permitted to complete at most one transaction (ie, buy one and sell one share of the stock), design an algorithm to find the maximum profit. For example,

input = 7, 1, 2, 5, 4, 1
buy one stock in day 2 and sell the stock in day 4 
will get the highest profit.

#### Analysis

For this question we need to find two days i and j such that p[j]-[p[i] is maximum and j > i.
We notice that in day i the max profit is p[i] - min(p[1], ..., p[i-1]). So we can solve the problem as follows:

```
public int maxProfit(int[] prices) {
    if (prices.length <= 1) return 0;
    int profit = 0;
    int min = prices[0];
    for (int i = 0; i < prices.length; i++) {
        //find the min price in day 1 to day i-1
        min = Math.min(min, prices[i]);
        profit = Math.max(profit, prices[i] - min);
    }
    return profit;
}
```

### Buy and Sell Stock II

Say you have an array for which the ith element is the price of a given stock on day i. 
Design an algorithm to find the maximum profit. You may complete as many transactions as 
you like (ie, buy one and sell one share of the stock multiple times). However, you may 
not engage in multiple transactions at the same time (ie, you must sell the stock before you buy again).

#### Analysis

Since we could make more than one transactions, we can buy stock at each foot and sell it at the following peak.
Assume between a foot and the following peak exists day i, such that p[foot] <= p[i] <= p[peak]. We sell a stock 
and then buy a stock does not influence the final profit. So, whenever p[i] > p[i-1] we make a transaction could 
simplify the implementation.

```
public int maxProfit_simple(int[] prices) {
    if (prices.length <= 1) return 0;
    int totalProfit = 0;
    for (int i = 1; i < prices.length; i++) {
        if(prices[i] > prices[i - 1])
            totalProfit += (prices[i] - prices[i-1]);
    }
    return totalProfit;
}
```

### Buy And Sell Stock III

Say you have an array for which the ith element is the price of a given stock on day i. Design an algorithm 
to find the maximum profit. You may complete at most two transactions.

#### Analysis

In day i, we need to find out the max profit for day i + 1 to day n. The max profit is 
Max(max_profit(1, i) + max_profit(i+1, n)), 1<= i <=n. 
However, there is duplicated computation in max_profit(i+1, n). To optimize it, we can 
solve this part in O(n) time complexity first, and then solve the problem in O(n) time.

```
public int maxProfit(int[] prices) {
    if (prices.length <= 1) return 0;
    // table[i] saves the max profit from day i to day n
    int[] table = new int[prices.length + 1];
    table[prices.length] = 0;
        
    int max = prices[prices.length - 1];
    //calculate the max profit from day i to day n
    for(int i = prices.length - 1; i >= 0; i--){
        table[i] = max - prices[i];
        max = Math.max(max, prices[i]);
    }
    
    //calculate the max profit from day 1 to day i
    //and the max profit from day 1 to day 
    int min = prices[0];
    int leftProfit = 0;
    max = 0;
    for (int i = 0; i < prices.length; i++) {
        min = Math.min(min, prices[i]);
        leftProfit = Math.max(leftProfit, prices[i] - min);
        //the max total profit
        max = Math.max(max, leftProfit + table[i+1]);
    }
        
    return max;
}
```
