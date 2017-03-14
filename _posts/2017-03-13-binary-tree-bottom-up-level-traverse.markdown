Given a binary tree, return the bottom-up level order traversal of its nodes’ values. 
(ie, from left to right, level by level from leaf to root). For example:

```
Given binary tree {3,9,20,#,#,15,7},
    3
   / \
  9  20
    /  \
   15   7
return its bottom-up level order traversal as:
[
  [15,7]
  [9,20],
  [3],
]
```

#### Analysis

- We first add the nodes of each level into a queue. 
- When do step 1, we count the number of nodes in each level.
- We traverse the queue from right to left and put the value of each level in a list.

```java
public ArrayList<ArrayList<Integer>> levelOrderBottom(TreeNode root) {
    ArrayList<ArrayList<Integer>> res = 
                        new ArrayList<ArrayList<Integer>>();
    if(root == null) return res;
    ArrayList<TreeNode> nodes = new ArrayList<TreeNode>();
    nodes.add(root);
    traverseLevelBottom(res, nodes, 1, 0);
    return res;
}
    
public void traverseLevelBottom(ArrayList<ArrayList<Integer>> res, 
                    ArrayList<TreeNode> nodes, int len, int from){
    ArrayList<Integer> arr = new ArrayList<Integer>();      
    TreeNode n = null;
    int nlen = 0;
    for(int i = from; i < from + len; i++){
        n = nodes.get(i);
        if(n.right != null){
            nodes.add(n.right);
            nlen++;
        }
        if(n.left != null){
            nodes.add(n.left);
            nlen++;
        }
    }
    
    if(nlen > 0) 
      traverseLevelBottom(res, nodes, nlen, from + len);
    //visit last level
    for(int i = from + len - 1; i >= from; i--){
        arr.add(nodes.get(i).val);
    }
        
    res.add(arr);
}            
```
