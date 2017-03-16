---
layout: post
categories: Leetcode
tags: [string]

---

Given a string s, partition s such that every substring of the partition is a palindrome.
Return all possible palindrome partitioning of s.
For example, given s = "aab",
Return

```
[
  ["aa","b"],
  ["a","a","b"]
]
```

P(S) is the partions of S
if S[0..i] is a palindrome
   S[0..i] and P(S_i+1) form a group of partitions
   
In the recursive method, duplicated compution exists. We use hash map to store the partitions of
substring S_i, i is the key.

```java
    public List<List<String>> partition(String s) {
        HashMap<Integer, List<List<String>>> tempResult = new HashMap<>();
        return partitionOfSubStr(s, 0, tempResult);
    }

    public List<List<String>> partitionOfSubStr(String s, int start, HashMap<Integer, List<List<String>>> tempResult) {
        if (tempResult.containsKey(start)) {
            return tempResult.get(start);
        }

        List<List<String>> result = new ArrayList<>();

        for (int i = start; i < s.length(); i++) {
            if (!isPalindrome(s, start, i)) {
                continue;
            }

            String str = s.substring(start, i + 1);

            List<List<String>> partitions = partitionOfSubStr(s, i + 1, tempResult);
            //DO not modify the returned list
            if (partitions.size() == 0) { //partitions is empty only when the substring from i+1 is empty
                List<String> list = new ArrayList<>();
                list.add(str);
                result.add(list);
            } else {
                for (List<String> list : partitions) {
                    List<String> nList = new ArrayList<>();
                    nList.add(str);
                    nList.addAll(list);
                    result.add(nList);
                }
            }
        }

        tempResult.put(start, result);
        return result;
    }

    public boolean isPalindrome(String s, int start, int end) {
        while (start < end) {
            if (s.charAt(start++) != s.charAt(end--))
                return false;
        }
        return true;
    }
```

### Palindrome partition II

Given a string s, partition s such that every substring of the partition is a palindrome.
Return the minimum cuts needed for a palindrome partitioning of s.
For example, given s = "aab",
Return 1 since the palindrome partitioning ["aa","b"] could be produced using 1 cut. 

#### Analysis

The previous method can be optimized. To find out whehter S_i_j is a palindrome or not, we can leverage the result of S_i-1_j-1.
So, we store palindrome result in a table.

```java
    public boolean[][] palindromeTable(String s) {
        boolean[][] table = new boolean[s.length()][s.length()];
        for (int i = 0; i < s.length(); i++) {
            table[i][i] = true;
            if ((i+1) < s.length()) {
                table[i][i + 1] = (s.charAt(i) == s.charAt(i + 1));
            }
        }


        for (int diff = 2; diff < s.length(); diff++) {
            int len = s.length() - diff;
            for (int i = 0; i < len; i++) {
                int j = i + diff;
                table[i][j] = (s.charAt(i) == s.charAt(j)) & table[i+1][j-1];

            }
        }
        return table;
    }

    public int minCut(String s) {
        int[] table = new int[s.length() + 1];
        Arrays.fill(table, - 1);
        boolean[][] pTable = palindromeTable(s);

        return minCut(s, 0, table, pTable);
    }

    //mincut of substring s[start..n]
    public int minCut(String s, int start, int[] table, boolean[][] pTable) {
        if (table[start] >= 0 || start == s.length()) { //has a value or empty substr
            return table[start];
        }

        int min = Integer.MAX_VALUE;
        for (int i = start; i < s.length(); i++) {
            if (!pTable[start][i]) {
                continue;
            }
            //if substring is empty, minSub = -1
            int minSub = minCut(s, i + 1, table, pTable);
            if ((minSub + 1) < min)
                min = minSub + 1;
        }

        table[start] = min;
        return min;
    }
```
