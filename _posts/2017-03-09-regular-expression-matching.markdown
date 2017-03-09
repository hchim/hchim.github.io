### Regular Expression Matching

Implement regular expression matching with support for '.' and '*'.

'.' Matches any single character.
'*' Matches zero or more of the preceding element.

The matching should cover the entire input string (not partial).

The function prototype should be:
bool isMatch(const char *s, const char *p)

Some examples:
isMatch("aa","a") → false
isMatch("aa","aa") → true
isMatch("aaa","aa") → false
isMatch("aa", "a*") → true
isMatch("aa", ".*") → true
isMatch("ab", ".*") → true
isMatch("aab", "c*a*b") → true

#### Analysis

Add # to the end of the pattern string. Then we can define the state transition table as follows:
The row is current char, the column is next char.

|    |  .  |  *  |  ch  |  #  |
|----|-----|-----|------|-----|   
| .  |i++, j++|  push(i+1), push(j), j+2   | i++, j++  | return true if i == S.length - 1; otherwise RET |
| *  |     |     |      |     |
| ch | RET if S[i] != P[j]; otherwise i++, j++ | j+2 if S[i] != P[j]; otherwise push(i+1), push(j), j+2  |  RET if S[i] != P[j]; otherwise i++, j++    |  return true if S[i] == P[j] && i == S.length - 1; otherwise RET  |

Notes:

- i is the index of the maching string
- j is the index of the pattern string
- for .*  : match 0 chars by push(i+1), push(j), j+2 (when resume the state from stack, maches 1 char)
- RET : check the stack, if stack is empty return false, otherwise j=pop() i=pop(), resume to state, i, j

