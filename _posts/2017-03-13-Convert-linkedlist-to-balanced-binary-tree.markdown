Given a singly linked list where elements are sorted in ascending order, convert it to a height balanced BST.


#### Analysis

Since we want to build a balanced BST. We can use a pointer to pointer to the left most node, and specify the number of nodes
to visit to build the left subtree. When the left subtree was built, the pointer points to the first node (root) of the right 
subtree.

```java
public TreeNode buildTree(int l, int h, ListNode[] pre) {
        if(l > h) return null;
        int m = (h+l)/2;
        //build left sub tree
        TreeNode left =buildTree(l, m - 1, pre);
        //after build left sub tree pre[0] points
        //to the next node in list to build the root
        TreeNode root = new TreeNode(pre[0].val);
        pre[0] = pre[0].next;
        root.left = left;
        //build right sub tree
        root.right = buildTree(m + 1, h, pre);          
        return root;
}

public TreeNode sortedListToBSTRec(ListNode head) {
        int n = 0;
        for(ListNode p = head; p != null; p = p.next) {
          n++;
        }
        ListNode[] pre = new ListNode[0];  
        pre[0] = head;
        return buildTree(0, n-1, pre);
}
```
