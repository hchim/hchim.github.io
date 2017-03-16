---
layout: post
categories: Leetcode
tags: [string]

---

Implement regular expression matching with support for '.' and '*'.

'.' Matches any single character.
'*' Matches zero or more of the preceding element.

The matching should cover the entire input string (not partial).

The function prototype should be:
bool isMatch(const char *s, const char *p)

Some examples:

```
isMatch("aa","a") → false
isMatch("aa","aa") → true
isMatch("aaa","aa") → false
isMatch("aa", "a*") → true
isMatch("aa", ".*") → true
isMatch("ab", ".*") → true
isMatch("aab", "c*a*b") → true
```

#### Analysis

Add ## to the end of the pattern string. Then we can define the state transition table as follows:
The row is current char, the column is next char.

|    |  .  |  *  |  ch  |  #  |
|:----|-----|-----|------|-----|   
| .  |i++, j++|  push(i+1), push(j), j+2   | i++, j++  | return true if i == S.length - 1; otherwise RET |
| *  |     |     |      |     |
| ch | RET if S[i] != P[j]; otherwise i++, j++ | j+2 if S[i] != P[j]; otherwise push(i+1), push(j), j+2  |  RET if S[i] != P[j]; otherwise i++, j++    |  return true if S[i] == P[j] && i == S.length - 1; otherwise RET  |
| #  | RET | RET | RET | RET |

Notes:

- i is the index of the maching string
- j is the index of the pattern string
- for .*  : match 0 chars by push(i+1), push(j), j+2 (when resume the state from stack, maches 1 char)
- RET : check the stack, if stack is empty return false, otherwise j=pop() i=pop(), resume to state, i, j

```java
    public boolean isMatch(String s, String p) {
        Stack<Integer> stack = new Stack<>();
        int i = 0; int j = 0;
        p += "##";
        boolean notMatch = false;

        while (j < p.length()) {
            //terminate check
            if (i == s.length()) {
                return isEndState(p, j);
            }

            char ch = s.charAt(i);
            char curChar = p.charAt(j);
            char nextChar = p.charAt(j + 1);

            switch (curChar) {
                case '.':
                    switch (nextChar) {
                        case '*':
                            stack.push(i + 1);
                            stack.push(j);
                            j += 2;
                            break;
                        case '#': //end state
                            if (i == (s.length() - 1)) {
                                return true;
                            } else {
                                notMatch = true;
                            }
                            break;
                        default: //. or char
                            i++; j++;
                            break;
                    }
                    break;
                case '*': // wrong pattern
                    break;
                case '#':
                    notMatch = true;
                    break;
                default:  // chars
                    switch (nextChar) {
                        case '*':
                            if (ch == curChar) {
                                stack.push(i + 1);
                                stack.push(j);
                            }
                            j += 2;
                            break;
                        case '#': //end state
                            if (ch == curChar && (s.length() - 1) == i) {
                                return true;
                            } else {
                                notMatch = true;
                            }
                            break;
                        default:
                            if (ch == curChar) {
                                i++; j++;
                            } else {
                                notMatch = true;
                            }
                            break;
                    }
                    break;
            }

            if (notMatch) { //current branch does not match, resume to another branch
                if (stack.isEmpty())
                    return false;

                notMatch = false;
                j = stack.pop();
                i = stack.pop();
            }
        }

        return false;
    }

    //a*b*#
    //.#
    //#
    private boolean isEndState(String p, int start) {
        for (int i = start; i < p.length() - 1; ) {
            char ch = p.charAt(i);
            if (ch == '#')
                return true;
            char ch2 = p.charAt(i + 1);
            if (ch != '*' && ch2 == '*') {
                i += 2;
            } else {
                return false;
            }
        }

        return true;
    }
```
