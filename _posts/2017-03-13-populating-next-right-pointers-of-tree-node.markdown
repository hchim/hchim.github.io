---
layout: post
categories: Leetcode
---

 Given a binary tree
```
    struct TreeLinkNode {
      TreeLinkNode *left;
      TreeLinkNode *right;
      TreeLinkNode *next;
    }
```
Populate each next pointer to point to its next right node. If there is no next right node, the next pointer should be set to NULL.

Initially, all next pointers are set to NULL.

Note:

    You may only use constant extra space.
    You may assume that it is a perfect binary tree (ie, all leaves are at the same level, and every parent has two children).
```
For example,
Given the following perfect binary tree,

         1
       /  \
      2    3
     / \  / \
    4  5  6  7

After calling your function, the tree should look like:

         1 -> NULL
       /  \
      2 -> 3 -> NULL
     / \  / \
    4->5->6->7 -> NULL
```

#### Analysis

When we try to connect the second level, we can see that the first level is already connected. 
Similarly, when we try to connect the third level, the second level is connected.

So, we use two pointers pointer to the parent level and its child level. While we traverse 
the parent level, we connect the child level.

```java
public void connect(TreeLinkNode root) {
    if(root == null) return;
    TreeLinkNode parent = root,
        pre = null, child = null;       
        
    while(parent != null && parent.left != null){
        //connect the child layer
        pre = child = parent.left;
        while(parent != null){
            if(parent.left != null && pre != parent.left){
                pre.next = parent.left;
                pre = pre.next;
            }
            if(parent.right != null){
                pre.next = parent.right;
                pre = pre.next;
            }
            parent = parent.next;
        }
        //prepare for the next level
        parent = child;
    }           
}
```

### Populating Next Right Pointers in Each Node II

Follow up for problem “Populating Next Right Pointers in Each Node”.

What if the given tree could be any binary tree? Would your previous solution still work?

Note: You may only use constant extra space. 

```
For example, Given the following binary tree,

         1
       /  \
      2    3
     / \    \
    4   5    7
After calling your function, the tree 
should look like:
         1 -> NULL
       /  \
      2 -> 3 -> NULL
     / \    \
    4-> 5 -> 7 -> NULL
```

Different with previous problem. We cannot assume parent.left as the head of the next level. 
We need to find out the head of the next level when we try to connect the next level.

```java
    public void connect(TreeLinkNode root) {
        TreeLinkNode parent = root;

        while (parent != null) {
            TreeLinkNode p = parent;
            TreeLinkNode child = null, // point to the first node of the child layer
                    pre = null;
            //traverse parent level
            while (p != null) {
                if (p.left != null) {
                    if (child == null) { // first node in the next layer
                        child = pre = p.left;
                    } else { // connect p.left
                        pre.next = p.left;
                        pre = pre.next;
                    }
                }

                if (p.right != null) {
                    if (child == null) { // first node in the next layer
                        child = pre = p.right;
                    } else {
                        pre.next = p.right;
                        pre = pre.next;
                    }
                }
                // move to the next node on this level
                p = p.next;
            }

            //parent
            parent = child;
        }

    }                   
```
