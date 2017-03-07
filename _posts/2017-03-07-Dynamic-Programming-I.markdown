###Distinct subsequence

Given a string S and a string T, count the number of distinct subsequences of T in S.

A subsequence of a string is a new string which is formed from the original string by deleting some (can be none) of the characters without disturbing the relative positions of the remaining characters. (ie, "ACE" is a subsequence of "ABCDE" while "AEC" is not).

Here is an example:
S = "rabbbit", T = "rabbit"

Return 3.

####Analysis

     Let    i = 0, j = 0
            S_i = S[i..m]
            T_j = T[j..n]
            N(S_i, T_j) be the number of distinct subsequence of S_i and T_j

     if (S[i] == T[j])
        N(S_i, T_j) = N(S_i+1, T_j+1) + N(S_i+1, T_j)
     else
        N(S_i, T_j) = N(S_i+1, T_j)

     In the recursive equations, there are many duplicated computations.
     We use an (m+1)X(n+1) array to store N(S_i, T_j) and fill the array from right bottom to left top.
     The last column of the array is 1 because N(S_i, T_n) = 1.

     Finally, table[0][0] = N(S, T)

```
    public int numDistinct(String s, String t) {
        int[][] table = new int[s.length() + 1][t.length() + 1];
        for (int i = 0, j = t.length(); i <= s.length(); i++)
            table[i][j] = 1;

        for (int j = t.length() - 1; j >= 0; j--) {
            for (int i = s.length() - 1; i >= 0; i--) {
                if (s.charAt(i) == t.charAt(j)) {
                    table[i][j] = table[i + 1][j + 1] + table[i + 1][j];
                } else {
                    table[i][j] = table[i + 1][j];
                }
            }
        }

        return table[0][0];
    }
```

###Edit distance

“Given two words word1 and word2, find the minimum number of steps required to convert word1 to word2. (each operation is counted as 1 step.) You have the following 3 operations permitted on a word:

Insert a character
Delete a character
Replace a character”

####Analysis

      if S[i] == T[j]
        MD(S_i, T_j) = MD(S_i+1, T_j+1)
      else
        MD(S_i, T_j) = Min( insert, delete, replace)
                    insert: 1 + MD(S_i, T_j+1)
                    delete: 1 + MD(S_i+1, T_j)
                    replace: 1 + MD(S_i+1, T_j+1)

     The value of the last column is [m,...,0]
     The value of the last row is [n,..,0]
     
```
    public int minDistance(String s, String t) {
        int[][] table = new int[s.length() + 1][t.length() + 1];
        for (int i = 0, j = t.length(); i <= s.length(); i++)
            table[i][j] = s.length() - i;

        for (int i = s.length(), j = 0; j <= t.length(); j++)
            table[i][j] = t.length() - j;

        for (int j = t.length() - 1; j >= 0; j--) {
            for (int i = s.length() - 1; i >= 0; i--) {
                if (s.charAt(i) == t.charAt(j)) {
                    table[i][j] = table[i + 1][j + 1];
                } else {
                    table[i][j] = 1 + Math.min(table[i][j+1], Math.min(table[i+1][j], table[i+1][j+1]));
                }
            }
        }

        return table[0][0];
    }
```

###Interleaving String

Given s1, s2, s3, find whether s3 is formed by the interleaving of s1 and s2.

For example,
Given:
s1 = "aabcc",
s2 = "dbbca",

When s3 = "aadbbcbcac", return true.
When s3 = "aadbbbaccc", return false.

####Analysis

     if S1_i == S3_k && S2_j == S3_k
       interleave = inter(S1_i+1, S2_j, S3_k+1) || inter(S1_i, S2_j+1, S3_k+1)
     else if S1_i == S3_k
       interleave = inter(S1_i+1, S2_j, S3_k+1)
     else if S2_j == S3_k
       interleave = inter(S1_i, S2_j+1, S3_k+1)
     else
       interleave = false

```
    public boolean isInterleave(String s1, String s2, String s3) {
        if ((s1.length() + s2.length()) != s3.length()) {
            return false;
        }

        boolean[][] table = new boolean[s1.length() + 1][s2.length() + 1];
        table[s1.length()][s2.length()] = true;
        for (int i = s1.length() - 1, j = s2.length(); i >= 0; i--) {
            if (s1.charAt(i) == s3.charAt(i + j)) {
                table[i][j] = true;
            } else {
                break;
            }
        }
        for (int i = s1.length(), j = s2.length() - 1; j >= 0; j--) {
            if (s2.charAt(j) == s3.charAt(i + j)) {
                table[i][j] = true;
            } else {
                break;
            }
        }

        for (int i = s1.length() - 1; i >= 0; i--) {
            for (int j = s2.length() - 1; j >= 0; j--) {
                char ch = s3.charAt(i + j);
                if (s1.charAt(i) == ch && s2.charAt(j) == ch) {
                    table[i][j] = table[i + 1][j] || table[i][j + 1];
                } else if (s1.charAt(i) == ch) {
                    table[i][j] = table[i+1][j];
                } else if (s2.charAt(j) == ch) {
                    table[i][j] = table[i][j+1];
                } else {
                    table[i][j] = false;
                }
            }
        }

        return table[0][0];
    }
```

###Longest palindrome

Given a string s, find the longest palindromic substring in s. You may assume that the maximum length of s is 1000.

Example:
Input: "babad"
Output: "bab"
Note: "aba" is also a valid answer.

####Analysis

     Let P(S_i_j) be whether S_i_j is a palindrome or not

     if S[i] == S[j] && P(S_i+1_j-1) = true
        P(S_i_j) = true
     else
        P(S_i_j) = false
        
```
    public String longestPalindrome(String s) {
        if (s.length() <= 1) {
            return s;
        }

        boolean[][] paTable = new boolean[s.length()][s.length()];
        int start = s.length() - 1, end = s.length();

        for (int i = 0; i < s.length(); i++) {
            paTable[i][i] = true;

            if ((i + 1) < s.length() && s.charAt(i) == s.charAt(i+1)) {
                paTable[i][i+1] = true;
                start = i;
                end = i + 2;
            }
        }

        //diff = j - i
        for (int diff = 2; diff < s.length(); diff++) {
            int len = s.length() - diff;
            for (int i = 0; i < len; i++) {
                int j = i + diff;
                if (s.charAt(i) == s.charAt(j) && paTable[i+1][j-1]) {
                    paTable[i][j] = true;
                    start = i;
                    end = j + 1;
                } else {
                    paTable[i][j] = false;
                }
            }
        }
        return s.substring(start, end);
    }
```
