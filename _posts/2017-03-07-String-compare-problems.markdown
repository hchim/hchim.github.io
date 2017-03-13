---
layout: post
---

### Longest common prefix

Write a function to find the longest common prefix string amongst an array of strings.

* Find out the minimum length of the strings.
* Vist each column of characters and find out the first column that break this rule.

```java
    public String longestCommonPrefix(String[] strs) {
        if (strs == null || strs.length == 0) {
            return "";
        }

        int len = Integer.MAX_VALUE;
        for (int i = 0; i < strs.length; i++) {
            if (len > strs[i].length()) {
                len = strs[i].length();
            }
        }

        if (len == 0) {
            return "";
        }

        int i = 0;
        while (i < len && sameCharAt(strs, i)) {
            i++;
        }
        return strs[0].substring(0, i);
    }

    private boolean sameCharAt(String[] strs, int index) {
        char ch = strs[0].charAt(index);
        for (int i = 1; i < strs.length; i++) {
            if (strs[i].charAt(index) != ch) {
                return false;
            }
        }

        return true;
    }
```

### Longest Substring Without Repeating Characters

Given a string, find the length of the longest substring without repeating characters.

Examples:
Given "abcabcbb", the answer is "abc", which the length is 3.
Given "bbbbb", the answer is "b", with the length of 1.
Given "pwwkew", the answer is "wke", with the length of 3. Note that the answer must be a substring, "pwke" is a subsequence and not a substring.

* Record the last visited position of each character in table arr.
* Iterate each char of the string. 
    * If s[i] was not visited, mark the position of arr[s[i]] = i.
    * else, update the maximum length and reset start position as arr[s[i]] + 1. In addition, set arr[s[i]] = i

```java
    public int lengthOfLongestSubstring(String s) {
        if (s.length() <= 1) {
            return s.length();
        }

        int[] pos = new int[256]; //records the positions of last visited chars
        int startPos = 0; //the start position of the longest substring
        int max = 0;

        Arrays.fill(pos, -1);

        for (int i = 0; i < s.length(); i++) {
            int index = s.charAt(i);
            //not visited or last position is not in the current substring
            if (pos[index] == -1 || pos[index] < startPos) {
                pos[index] = i;
            } else {
                //compare with last max string
                if ((i - startPos) > max)
                    max = i - startPos;

                startPos = pos[index] + 1;
                pos[index] = i;
            }
        }

        return Math.max(max, s.length() - startPos);
    }
```

### Longest Valid Parentheses

 Given a string containing just the characters '(' and ')', find the length of the longest valid (well-formed) parentheses substring.
 For "(()", the longest valid parentheses substring is "()", which has length = 2.
 Another example is ")()())", where the longest valid parentheses substring is "()()", which has length = 4.
 
 * Use a stack to detect the valid pairs.
 * The top of the stack is the position of the last invalid position.
 * Whenever we found the current position is valid, i - stack.peak if the length of the current valid parentheses.
 
 ```java
    public int longestValidParentheses(String s) {
        Stack<Integer> stack = new Stack<>();
        int max = 0;
        stack.push(-1);

        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == '(') {
                stack.push(i);
            } else {
                int top = stack.pop();
                if (top != -1 && s.charAt(top) == '(') { // valid pair
                    max = Math.max(i - stack.peek(), max);
                } else {
                    stack.push(i);
                }
            }
        }

        return max;
    }
 ```
 
 ### Minimum window substring
 
 Given a string S and a string T, find the minimum window in S which will contain all the characters in T in complexity O(n).

For example,
S = "ADOBECODEBANC"
T = "ABC"
Minimum window is "BANC".

Note:
If there is no such window in S that covers all characters in T, return the empty string "".
If there are multiple such windows, you are guaranteed that there will always be only one unique minimum window in S.

* Count the number of chars in t and store the numbers in an array.
* Use two points L,R. Move R to the position such that S[L..R] is a valid substring.
* Try to shrink the window from L.
 
 ```java
     public String minWindow(String s, String t) {
        int[] validHash = validHash(t);
        int[] hash = new int[256];
        int start = 0, min = Integer.MAX_VALUE, pos = 0;
        boolean hasMinWindow = false;

        for (int i = 0; i < s.length(); i++) {
            char ch = s.charAt(i);
            if (validHash[ch] == 0) { //ch is not in t
                continue;
            }

            hash[ch]++;
            //if the current window does not contain all the chars in t
            if (!isSubstr(hash, validHash))
                continue;

            hasMinWindow = true;
            //try to shrink the window from left
            for (int j = start; j <= i; j++) {
                ch = s.charAt(j);
                if (validHash[ch] == 0) {//ch is not a char in t
                    start++;
                    continue;
                }

                //try to remove ch from the window
                if (hash[ch] > validHash[ch]) {
                    start++;
                    hash[ch]--;
                } else {
                    if ((i - start + 1) < min) {
                        min = Math.min(min, i - start + 1);
                        pos = start;
                    }
                    break;
                }
            }
        }

        return hasMinWindow ? s.substring(pos, pos + min) : "";
    }

    private int[] validHash(String t) {
        int[] hash = new int[256];

        for (int i = 0; i < t.length(); i++)
            hash[t.charAt(i)]++;

        return hash;
    }

    private boolean isSubstr(int[] hash, int[] validHash) {
        for (int i = 0; i < hash.length; i++) {
            if (hash[i] < validHash[i])
                return false;
        }
        return true;
    }
```
