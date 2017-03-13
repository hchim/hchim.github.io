---
layout: post
---

“The count-and-say sequence is the sequence of integers beginning as follows:

1, 11, 21, 1211, 111221, ...
1 is read off as "one 1" or 11.
11 is read off as "two 1s" or 21.
21 is read off as "one 2, then one 1" or 1211.
Given an integer n, generate the nth sequence.

Note: The sequence of integers will be represented as a string.

#### Solution

- Count the occurrence number of the same digit.
- If the digit changes, put the number and the digit into StringBuffer and start to count the next digit.

```java
public String countAndSay(int n) {
    if(n < 1) return "";
    String str = "1";
    for(int i = 1; i < n; i++)
        str = say(str);
    return str;
}   
    
public String say(String str){
    char last = '0', ch;
    int num = 0;
    StringBuffer buf = new StringBuffer();
    
    for(int i = 0; i < str.length(); i++){
        ch = str.charAt(i);
        if(ch == last){
            num++;
        }else{
            if(last != '0'){
                buf.append(num).append(last);
            }
            num = 1;
            last = ch;
        }
    }
    if(last != '0')
        buf.append(num).append(last);
    return buf.toString();
}
```
