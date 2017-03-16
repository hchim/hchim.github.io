---
layout: post
categories: Leetcode
tags: [binary-tree]

---

Two elements of a binary search tree (BST) are swapped by mistake.

Recover the tree without changing its structure.

Note: A solution using O(n) space is pretty straight forward. Could you devise a constant space solution?

#### Analysis

In traverse the tree, if the value of current node Y is less than previous node X. Then, the wrong order happens here.

If the wrong order happens once, we just need to switch these two nodes X and Y.
If the wrong order happens twice (X’, Y’ is two nodes of previous wrong order), we need to switch X’ with Y.
For example,

```
For inorder result,
[4, 7, 8, 9, (15), (12)]
              X      Y
Y < X, switch X and Y we get
[4, 7, 8, 9, 12, 15]

For inorder result,
[4, (15), 8, 9, 12, (7)]
     X'   Y'    X    Y 

Y' < X'  and Y < X,
switch X' and Y we get
[4, 7, 8, 9, 12, 15]
```

```java
public void recoverTree(TreeNode root) {
    if(root == null) return;
    if(root.left==null&&root.right==null) 
        return;
        TreeNode[] list = new TreeNode[2];
        inTraverse(root, list, null);
        if(list[0] != null){
            int val = list[0].val;
            list[0].val = list[1].val;
            list[1].val = val;
        }
}
    
public TreeNode inTraverse(TreeNode root, 
    TreeNode[] list, TreeNode last){
    if(root.left != null) 
        last = inTraverse(root.left,list,last);
    if(last != null && root.val < last.val){
        if(list[0] == null){
            list[0] = last;
            list[1] = root;
        }else{
            list[1] = root;
        }
    }
    last = root;
    if(root.right != null) 
        last=inTraverse(root.right,list,last);
    return last;
}
```
