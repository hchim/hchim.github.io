---
layout: post
categories: Leetcode
tags: [binary-tree]

---

Given a binary tree, find the maximum path sum. The path may start and end at any node in the tree. For example:

Given the below binary tree,
```
       1
      / \
     2   3
```
Return 6.

#### Analysis

At a node i, the maximum path sum of this subtree has the following 6 possibilities:

- The maximum path is in the left child of i.
- The maximum path is in the right child of i.
- A path, which starts from i’s left child, and includes i’s left child and i ,forms the maximum path.
- A path, which starts from i’s right child, and includes i’s right child and i ,forms the maximum path.
- A path, which starts from i’s left child and ends in i’s right child, forms the maximum path.
- The max path contains only node i.

We use recursive method to traverse the tree. For each sub tree we find the max path sum. 
Then, case 1 and 2 are solved when visit the left and right sub tree. So, we get the following implementation.

```java
public int maxPathSum(TreeNode root) {
    if(root == null) return 0;
    int[] max = {Integer.MIN_VALUE};
    findSum(root, max);
    return max[0];
}
    
//returns the max path sum from a child to the node.
public int findSum(TreeNode node, int[] max){
    if(node == null) return 0;
    int left = findSum(node.left, max);
    int right = findSum(node.right, max);
           
    int tmp = Math.max(left, right) + node.val;
    int tmp2 = Math.max(tmp, left + right + node.val);
    int tmp3 = Math.max(node.val, tmp2);
    max[0] = Math.max(max[0], tmp3); 
    return Math.max(tmp, node.val);
}
```
