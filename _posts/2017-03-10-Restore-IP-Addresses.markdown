---
layout: post
---

Given a string containing only digits, restore it by returning all possible valid IP address combinations.

For example:
Given "25525511135",

return ["255.255.11.135", "255.255.111.35"]. (Order does not matter) 

#### Analysis

The solutions of this problem forms a tree. We can use depth first search to search the solutions on the tree. 
To optimize the code, we need to cut the invalid branches based on the following rules.

1. Except 0, the number should not start with 0.
1. The number should not larger than 255.
1. The depth of a valid path is 4.

```
    public List<String> restoreIpAddresses(String s){
        List<String> result = new ArrayList<>();
        if(s.length() < 4) 
            return result;
        
        String sol = "";
        recursive(s, 0, result, sol, 4);
        return result;
    }

    /**
     * @param s
     * @param pos
     * @param result  final result
     * @param sol the temp solution of s[0..pos]
     * @param level The max depth of substring s[pos..n]
     */
    private void recursive(String s, int pos,
                           List<String> result, String sol, int level){
        int len = s.length() - pos;
        if(level > len) return;//substring not long enough
        if(level == 0){//leaf node, one of the solution
            if(len == 0)
                result.add(sol.substring(1));
            return;
        }

        int value = 0;
        for(int i = 0; i < 3 && pos+i < s.length(); i++){
            value = value * 10 + s.charAt(pos + i) - '0';
            if(value < 256) //visit an valid branch
                recursive(s, pos+i+1, result,
                        sol+"."+value, level-1);
            if(value == 0) break; //if the digit is 0, the next branch is invalid
        }
    }
```
