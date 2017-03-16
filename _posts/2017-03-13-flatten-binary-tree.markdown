---
layout: post
categories: Leetcode
tags: [binary-tree]

---

Given a binary tree, flatten it to a linked list in-place. For example,

```
Given

         1
        / \
       2   5
      / \   \
     3   4   6
The flattened tree should look like:
   1
    \
     2
      \
       3
        \
         4
          \
           5
            \
             6
```

```java
public void flatten(TreeNode root) {
    if(root == null) return;
    flattenSubTree(root);
}   

//return the right most node of the tree   
private TreeNode flattenSubTree(TreeNode node){
    if(node.left == null && node.right == null) 
        return node;
    if(node.left != null){
        TreeNode rightMost = flattenSubTree(node.left);
        rightMost.right = node.right;
        node.right = node.left;
        node.left = null;
        
        //right subtree is not empty
        if(rightMost.right != null)
            return flattenSubTree(rightMost.right);
        else    
            return rightMost;
    }else{//left is null so right is not null
        return flattenSubTree(node.right);
    }
}
```
