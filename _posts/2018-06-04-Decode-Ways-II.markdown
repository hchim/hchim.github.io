---
layout: post
categories: Leetcode
tags: [string, dynamic-programming]

---

A message containing letters from A-Z is being encoded to numbers using the following mapping way:

```
'A' -> 1
'B' -> 2
...
'Z' -> 26
```

Beyond that, now the encoded string can also contain the character '*', which can be treated as one of the numbers from 1 to 9.

Given the encoded message containing digits and the character '*', return the total number of ways to decode it.

Also, since the answer may be very large, you should return the output mod 109 + 7.

Example 1:

Input: "*"
Output: 9
Explanation: The encoded message can be decoded to the string: "A", "B", "C", "D", "E", "F", "G", "H", "I".

Example 2:

Input: "1*"
Output: 9 + 9 = 18

Note:

    The length of the input string will fit in range [1, 105].
    The input string will only contain the character '*' and digits '0' - '9'.

## Solution

We use dynamic programming to solve the problem. The problem has a lot of corner cases you need to consider.

```
    public static final int MOD = (int) Math.pow(10, 9) + 7;

    public int numDecodings(String s) {
        if (s == null || s.length() == 0) {
            return 1;
        }

        long[] table = new long[2];
        table[0] = decodeWaysOfSingleNumber(s.charAt(s.length() - 1));
        table[1] = 1;
        long value;

        for (int i = s.length() - 2; i >= 0; i--) {
            value = dp(s, i, table) % MOD;
            table[1] = table[0];
            table[0] = value;
        }

        return (int) (table[0] % MOD);
    }

    private int decodeWaysOfSingleNumber(char ch) {
        if (ch == '*') {
            return 9;
        } else if (ch == '0') {
            return 0;
        } else {
            return 1;
        }
    }

    private long dp(String s, int i, long[] table) {
        char ch1 = s.charAt(i), ch2 = s.charAt(i + 1);
        if (ch1 == '0') {
          return 0;
        } else if (ch1 == '1') {
            if (ch2 == '0') {
                return table[1];
            } else if (ch2 == '*') {
                return table[0] + (9 * table[1]);
            } else {
                return table[0] + table[1];
            }
        } else if (ch1 == '2') {
            if (ch2 == '0') {
                return table[1];
            } else if (ch2 == '*') {
                return table[0] + 6 * table[1];
            } else if (ch2 > '6') {
                return table[1];
            } else {
                return table[0] + table[1];
            }
        } else if (ch1 == '*') {
            //1* 2* 3* 4* 5* 6* 7* 8* 9*
            if (ch2 == '*') {
                return 9 * table[0] + 15 * table[1];
            } else if (ch2 == '0') {
                return 7 * table[0] + 2 * table[1];
            } else if (ch2 > '6') {
                return 9 * table[0] + table[1];
            } else {
                return 9 * table[0] + 2 * table[1];
            }
        } else {
            return table[0];
        }
    }
```
