---
layout: post
---

A message containing letters from A-Z is being encoded to numbers using the following mapping:

'A' -> 1
'B' -> 2
...
'Z' -> 26
Given an encoded message containing digits, determine the total number of ways to decode it.For example,

Given encoded message “12”, it could be decoded as “AB” (1 2) or “L” (12). The number of ways decoding “12” is 2.

#### Analysis

We can use dynamic programming to solve this problem. For string s, the decode ways of s has the following cases:

- s[0] == ‘0’ , 0 ways to decode
- s[0] == ‘1’ , since we can either decode s[0] and s[1] as two chars or decode s[0..1] as one char, the decode ways of s is the sum of the decode ways of the substring s[1..n] and s[2..n].
- s[0] == ‘2’
  - if ‘0’ <= s[1] <= ‘6’, the decode ways of s is the sum of the decode ways of the substring s[1..n] and s[2..n].
  - if s[1] > ‘6’, the decode ways is the same as the substring s[1..n].
- s[0] > ‘2’ , the decode ways is the same as the substring s[1..n].

```
public int numDecodings(String s) {
    if(s == null || s.length() == 0 ) return 0;
    if(s.length() == 1){
        return s.charAt(0) == '0' ? 0 : 1;
    }
    
    int[] arr = new int[s.length() + 1];
    arr[s.length()] = 1;
    arr[s.length() - 1] = s.charAt(s.length() - 1) == '0' ? 0 : 1;

    char ch, next;
    for(int i = s.length() - 2; i >= 0; i--){
        ch = s.charAt(i);
        next = s.charAt(i + 1);
        if(ch == '0'){
            arr[i] = 0;
        } else if (ch == '1' || (ch == '2' && (next >= '0' && next <= '6'))) {
            arr[i] = arr[i+1] + arr[i+2];
        } else {
            arr[i] = arr[i+1];
        }
    }
    return arr[0];
}
```
