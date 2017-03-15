---
layout: post
---

Given two words (beginWord and endWord), and a dictionary's word list, find all shortest transformation sequence(s) from beginWord to endWord, such that:

    Only one letter can be changed at a time
    Each intermediate word must exist in the word list
    

For example,

Given: beginWord = "hit" endWord = "cog" wordList = ["hot","dot","dog","lot","log"]

Return

[ ["hit","hot","dot","dog","cog"], ["hit","hot","lot","log","cog"] ]

Note:

    All words have the same length.
    All words contain only lowercase alphabetic characters.
    

#### 算法分析

*  从起始词开始搜索字符串列表，寻找可以只改变一个字符而可以转化的字符串(set)。
*  将搜索到的字符串添加到拓扑树里面。并且从字符串列表中删除set中的字符串，防止循环路径。
*  遍历set中的字符串，对每一个字符串寻找只改变一个字符而可以转化的字符串 set2（和第1步类似）。把set2中的所有字符加入map。
*  如果map为空，说明没有一条路径符合条件。如果map包含结束词则退出循环。
*  重复2-3.
*  遍历拓普树，搜索所有以结束词结束的路径。

#### The solution:

```java
    public class Solution {
    
    class GraphNode {
        String str;
        List<GraphNode> next = new LinkedList<>();
    
        GraphNode(String str) {
            this.str = str;
        }
    
        void add(GraphNode nextNode) {
            next.add(nextNode);
        }
    }
    
    public List<List<String>> findLadders(String beginWord, String endWord, Set<String> wordList) {
        GraphNode head = new GraphNode(beginWord);
        HashMap<String, GraphNode> map = new HashMap<>();
        map.put(head.str, head);
    
        wordList.remove(beginWord);
        wordList.add(endWord);
        // replace the word list as a hashset to improve the performance
        HashSet<String> newSet = new HashSet<>();
        newSet.addAll(wordList);
        wordList = newSet;
    
        /*
          This while loop will build a topology graph that start from the begin word. For example:
          beginWord = "hit" endWord = "cog"  wordList = ["hot","dot","dog","lot","log"]
                               lot - log
                             /            \
                  hit  - hot                cog
                             \            /
                               dot - dog
    
         */
        while (!wordList.isEmpty() && wordList.contains(endWord)) {
            HashMap<String, GraphNode> tmpMap = new HashMap<>();
    
            for (Map.Entry<String, GraphNode> e : map.entrySet()) {
                Set<String> res = closeWords(wordList, e.getKey());
                //add strs to the topology graph
                for (String ns : res) {
                    GraphNode n = tmpMap.get(ns);
                    if (n == null) {
                        n = new GraphNode(ns);
                        tmpMap.put(ns, n);
                    }
                    e.getValue().add(n);
                }
            }
    
            wordList.removeAll(tmpMap.keySet());
            map = tmpMap;
            if (map.size() == 0) { // no solution
                return new LinkedList<>();
            }
        }
    
        // prepare the result
        List<List<String>> result = new LinkedList<>();
        getResult(head, new LinkedList<String>(), result, endWord);
        return result;
    }
    
    /**
     * Visit the topology graph and add all the routes that ends with the end word.
     * @param node
     * @param route
     * @param result
     * @param end
     */
    private void getResult(GraphNode node, List<String> route, List<List<String>> result, String end) {
        route.add(node.str);
        // this route ends with the end word, and it is one of the solution
        if (node.str.equals(end)) {
            result.add(route);
            return;
        }
    
        // visit each path
        for (GraphNode n : node.next) {
            List<String> newRoute = new LinkedList<>();
            newRoute.addAll(route);
            getResult(n, newRoute, result, end);
        }
    }
    
    /**
     * Find out all the words that can be converted from (by changing only one character) the specified word.
     * @param wordList
     * @param begin
     * @return
     */
    private Set<String> closeWords(Set<String> wordList, String begin) {
        Set<String> res = new HashSet<>();
        for (String str : wordList) {
            if (oneCharDiff(begin, str)) {
                res.add(str);
            }
        }
    
        return res;
    }
    
    /**
     * Check whether the two strings only have one different character.
     * @param str1
     * @param str2
     * @return
     */
    private boolean oneCharDiff(String str1, String str2) {
        int diff = 0;
        for (int i = 0; i < str1.length(); i++) {
            if (str1.charAt(i) != str2.charAt(i)) {
                diff++;
                if (diff == 2) {
                    return false;
                }
            }
        }
    
        return true;
    }
    
    public void printResult(List<List<String>> result, PrintStream out) {
        if (out == null) {
            out = System.out;
        }
    
        out.println("[");
        for (List<String> list : result) {
            out.print("\t[");
            for (int i = 0; i < list.size(); i++) {
                if (i > 0) {
                    out.print(", ");
                }
                out.print(list.get(i));
            }
            out.println("]");
        }
        out.println("]");
    }
}
```    

The code of unit test:

```
    public class TestWordLadderII {
    
    @Test
    public void testSimple() {
        String[] words = {"hot","dot","dog","lot","log"};
        String[][] expected = {
                {"hit", "hot", "lot", "log", "cog"},
                {"hit", "hot", "dot", "dog", "cog"}
        };
        test("hit", "cog", words, expected);
    
        String[] words2 = {"a", "b", "c"};
        String[][] expected2 = { {"a", "c"} };
        test("a", "c", words2, expected2);
    }
    
    @Test
    public void testExmple2() {
        String[] words = {"kid","tag","pup","ail","tun","woo","erg","luz","brr","gay","sip","kay","per","val","mes","ohs","now","boa","cet","pal","bar","die","war","hay","eco","pub","lob","rue","fry","lit","rex","jan","cot","bid","ali","pay","col","gum","ger","row","won","dan","rum","fad","tut","sag","yip","sui","ark","has","zip","fez","own","ump","dis","ads","max","jaw","out","btu","ana","gap","cry","led","abe","box","ore","pig","fie","toy","fat","cal","lie","noh","sew","ono","tam","flu","mgm","ply","awe","pry","tit","tie","yet","too","tax","jim","san","pan","map","ski","ova","wed","non","wac","nut","why","bye","lye","oct","old","fin","feb","chi","sap","owl","log","tod","dot","bow","fob","for","joe","ivy","fan","age","fax","hip","jib","mel","hus","sob","ifs","tab","ara","dab","jag","jar","arm","lot","tom","sax","tex","yum","pei","wen","wry","ire","irk","far","mew","wit","doe","gas","rte","ian","pot","ask","wag","hag","amy","nag","ron","soy","gin","don","tug","fay","vic","boo","nam","ave","buy","sop","but","orb","fen","paw","his","sub","bob","yea","oft","inn","rod","yam","pew","web","hod","hun","gyp","wei","wis","rob","gad","pie","mon","dog","bib","rub","ere","dig","era","cat","fox","bee","mod","day","apr","vie","nev","jam","pam","new","aye","ani","and","ibm","yap","can","pyx","tar","kin","fog","hum","pip","cup","dye","lyx","jog","nun","par","wan","fey","bus","oak","bad","ats","set","qom","vat","eat","pus","rev","axe","ion","six","ila","lao","mom","mas","pro","few","opt","poe","art","ash","oar","cap","lop","may","shy","rid","bat","sum","rim","fee","bmw","sky","maj","hue","thy","ava","rap","den","fla","auk","cox","ibo","hey","saw","vim","sec","ltd","you","its","tat","dew","eva","tog","ram","let","see","zit","maw","nix","ate","gig","rep","owe","ind","hog","eve","sam","zoo","any","dow","cod","bed","vet","ham","sis","hex","via","fir","nod","mao","aug","mum","hoe","bah","hal","keg","hew","zed","tow","gog","ass","dem","who","bet","gos","son","ear","spy","kit","boy","due","sen","oaf","mix","hep","fur","ada","bin","nil","mia","ewe","hit","fix","sad","rib","eye","hop","haw","wax","mid","tad","ken","wad","rye","pap","bog","gut","ito","woe","our","ado","sin","mad","ray","hon","roy","dip","hen","iva","lug","asp","hui","yak","bay","poi","yep","bun","try","lad","elm","nat","wyo","gym","dug","toe","dee","wig","sly","rip","geo","cog","pas","zen","odd","nan","lay","pod","fit","hem","joy","bum","rio","yon","dec","leg","put","sue","dim","pet","yaw","nub","bit","bur","sid","sun","oil","red","doc","moe","caw","eel","dix","cub","end","gem","off","yew","hug","pop","tub","sgt","lid","pun","ton","sol","din","yup","jab","pea","bug","gag","mil","jig","hub","low","did","tin","get","gte","sox","lei","mig","fig","lon","use","ban","flo","nov","jut","bag","mir","sty","lap","two","ins","con","ant","net","tux","ode","stu","mug","cad","nap","gun","fop","tot","sow","sal","sic","ted","wot","del","imp","cob","way","ann","tan","mci","job","wet","ism","err","him","all","pad","hah","hie","aim","ike","jed","ego","mac","baa","min","com","ill","was","cab","ago","ina","big","ilk","gal","tap","duh","ola","ran","lab","top","gob","hot","ora","tia","kip","han","met","hut","she","sac","fed","goo","tee","ell","not","act","gil","rut","ala","ape","rig","cid","god","duo","lin","aid","gel","awl","lag","elf","liz","ref","aha","fib","oho","tho","her","nor","ace","adz","fun","ned","coo","win","tao","coy","van","man","pit","guy","foe","hid","mai","sup","jay","hob","mow","jot","are","pol","arc","lax","aft","alb","len","air","pug","pox","vow","got","meg","zoe","amp","ale","bud","gee","pin","dun","pat","ten","mob"};
        String[][] expected = {
                {"cet", "get", "gee", "gte", "ate", "ats", "its", "ito", "ibo", "ibm", "ism"},
                {"cet", "cat", "can", "ian", "inn", "ins", "its", "ito", "ibo", "ibm", "ism"},
                {"cet", "cot", "con", "ion", "inn", "ins", "its", "ito", "ibo", "ibm", "ism"}
        };
        test("cet", "ism", words, expected);
    }
    
    private void test(String start, String end, String[] words, String[][] expected) {
        HashSet<String> set = new HashSet<>();
        for (String w : words) {
            set.add(w);
        }
    
        Solution s = new Solution();
        List<List<String>> result = s.findLadders(start, end, set);
    
        for (int i = 0; i < expected.length; i++) {
            verify(result.get(i), expected[i]);
        }
    
        s.printResult(result, null);
    }
    
    private void verify(List<String> str, String[] expected) {
        HashSet<String> set = new HashSet<>();
        set.addAll(str);
    
        for (String s : expected) {
            Assert.assertTrue(set.contains(s));
            set.remove(s);
        }
    }
}
```    
