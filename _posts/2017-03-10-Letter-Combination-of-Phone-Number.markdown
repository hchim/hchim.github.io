---
layout: post
---

Given a digit string, return all possible letter combinations that the number could represent.

A mapping of digit to letters (just like on the telephone buttons) is given below.

Input:Digit string "23"
Output: ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"].

Note:
Although the above answer is in lexicographical order, your answer could be in any order you want. 

```
    static char[][] mapping = new char[][] {
            {'+'},
            {},
            {'a', 'b', 'c'},
            {'d', 'e', 'f'},
            {'g', 'h', 'i'},
            {'j', 'k', 'l'},
            {'m', 'n', 'o'},
            {'p', 'q', 'r', 's'},
            {'t', 'u', 'v'},
            {'w', 'x', 'y', 'z'}
    };

    public List<String> letterCombinations(String digits) {
        List<String> comb = new ArrayList<>();
        if (digits.length() == 0) {
            return comb;
        }

        comb.add("");
        for (int i = digits.length() - 1; i >= 0; i--) {
            comb = combinationOfSubStr(digits, i, comb);
        }

        return comb;
    }

    /**
     * @param digits
     * @param start the start position of the substring
     * @param comb the combination of substring s[start + 1]
     * @return
     */
    private List<String> combinationOfSubStr(String digits, int start, List<String> comb) {
        char[] chs = mapping[digits.charAt(start) - '0'];
        List<String> newList = new ArrayList<>();

        for (int i = 0; i < chs.length; i++) {
            for (String str : comb) {
                newList.add(chs[i] + str);
            }
        }

        return newList;
    }
```
