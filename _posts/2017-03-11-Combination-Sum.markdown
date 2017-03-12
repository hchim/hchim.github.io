---
layout: post
---

The solution of this problem is like a tree. We can use depth first search to find out the solutions on each branch.

### Combination Sum I

Given a set of candidate numbers (C) (without duplicates) and a target number (T),
find all unique combinations in C where the candidate numbers sums to T.
The same repeated number may be chosen from C unlimited number of times.

Note:
    All numbers (including target) will be positive integers.
    The solution set must not contain duplicate combinations.

For example, given candidate set [2, 3, 6, 7] and target 7,
A solution set is:
```
[
  [7],
  [2, 2, 3]
]
```

#### Analysis

The solution tree is shown as follows. We can use depth first search to find out the path that has summation as the target.

```
                   ""
  2           3           6       7
2  3  6  7  3   6   7   6    7     7   
...
```

```
    public List<List<Integer>> combinationSum(int[] candidates, int target) {
        List<List<Integer>> result = new ArrayList<>();
        dfs(candidates, target, 0, result, new ArrayList<Integer>());
        return result;
    }

    public void dfs(int[] candidates, int target, int start, List<List<Integer>> result, ArrayList<Integer> temp) {
        for (int i = start; i < candidates.length; i++) {
            if (candidates[i] == target) { //a solution
                addSolution(result, temp, candidates[i]);
            } else if (candidates[i] < target) {
                temp.add(candidates[i]);
                dfs(candidates, target - candidates[i], i, result, temp);
                temp.remove(temp.size() - 1);
            }
            //otherwise, the branch has no solution
        }
    }

    public void addSolution(List<List<Integer>> result, ArrayList<Integer> temp, int value) {
        ArrayList<Integer> solution = new ArrayList<>();
        solution.addAll(temp);
        solution.add(value);
        result.add(solution);
    }
```    

### Combination Sum II

 Given a collection of candidate numbers (C) and a target number (T), find all unique combinations in C where the candidate numbers sums to T.

Each number in C may only be used once in the combination.

Note:

    All numbers (including target) will be positive integers.
    The solution set must not contain duplicate combinations.

For example, given candidate set [10, 1, 2, 7, 6, 1, 5] and target 8,
A solution set is:

```
[
  [1, 7],
  [1, 2, 5],
  [2, 6],
  [1, 1, 6]
]
```

#### Analysis

Different to I, each number can only be used once. To eliminate the duplicated solutions, we changed the code:

1. Sort the array.
1. Visit the next level from index i + 1.
1. Skip the same numbers when traversing each row.

```
    public List<List<Integer>> combinationSum2(int[] candidates, int target) {
        Arrays.sort(candidates);
        List<List<Integer>> result = new ArrayList<>();
        dfs(candidates, target, 0, result, new ArrayList<Integer>());
        return result;
    }

    public void dfs(int[] candidates, int target, int start, List<List<Integer>> result, ArrayList<Integer> temp) {
        for (int i = start; i < candidates.length;) {
            if (candidates[i] == target) { //a solution
                addSolution(result, temp, candidates[i]);
            } else if (candidates[i] < target) {
                temp.add(candidates[i]);
                dfs(candidates, target - candidates[i], i + 1, result, temp);
                temp.remove(temp.size() - 1);
            }
            //otherwise, the branch has no solution
            //skip the same numbers
            int pre = candidates[i++];
            while (i < candidates.length && pre == candidates[i]) {
                i++;
            }
        }
    }

    public void addSolution(List<List<Integer>> result, ArrayList<Integer> temp, int value) {
        ArrayList<Integer> solution = new ArrayList<>();
        solution.addAll(temp);
        solution.add(value);
        result.add(solution);
    }
```

### Combination Sum III



Find all possible combinations of k numbers that add up to a number n, given that only numbers from 1 to 9 can 
be used and each combination should be a unique set of numbers.

```
Example 1:
Input: k = 3, n = 7
Output:
[[1,2,4]]

Example 2:
Input: k = 3, n = 9
Output:
[[1,2,6], [1,3,5], [2,3,4]]
```

#### Analyis

We need to add level into dfs search so as to only return the paths of level k.

```
    public List<List<Integer>> combinationSum3(int k, int n) {
        List<List<Integer>> result = new ArrayList<>();
        dfs(k, n, 1, result, new ArrayList<Integer>());
        return result;
    }

    public void dfs(int level, int target, int start, List<List<Integer>> result, ArrayList<Integer> temp) {
        for (int i = start; i < 10; i++) {
            if (i == target && level == 1) { //a solution
                addSolution(result, temp, i);
            } else if (i < target && level > 1) {
                temp.add(i);
                dfs(level - 1, target - i, i + 1, result, temp);
                temp.remove(temp.size() - 1);
            }
            //otherwise, the branch has no solution
        }
    }

    public void addSolution(List<List<Integer>> result, ArrayList<Integer> temp, int value) {
        ArrayList<Integer> solution = new ArrayList<>();
        solution.addAll(temp);
        solution.add(value);
        result.add(solution);
    }
````    
