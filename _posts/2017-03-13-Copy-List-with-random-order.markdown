---
layout: post
categories: Leetcode
tags: [linked-list]

---

A linked list is given such that each node contains an additional random pointer which could point to 
any node in the list or null. Return a deep copy of the list.

#### Analysis

For this kind of problem, we need to utilize the structure of the data structure. 
To locate the random pointer of the copied node, we first insert the copied node 
i into the original list right after the original node i. The new list shown as follows:

a1->a2->...->an is the original list.

after insert the copied list.

a1->b1->a2->b2->...->an->bn

In this new list, bi.random = ai.random.nex. So, we traverse the list again and pointer 
the random pointer of the copied nodes to the right position.

Finally, we can delete the copied nodes from the list and form the copied list.

```java
public RandomListNode copyRandomList(RandomListNode head) {
    if(head == null) return null;
    RandomListNode copyList = null;
    RandomListNode originPtr = head, copyPtr = null;
    //insert copied nodes
    while(originPtr != null){
        RandomListNode node = 
                new RandomListNode(originPtr.label);
        if(copyList == null) copyList = node;
        node.next = originPtr.next;
        originPtr.next = node;
        originPtr = originPtr.next.next;
    }
    //set the random pointer of the copied nodes
    originPtr = head;
    while(originPtr != null){ 
        originPtr.next.random = (originPtr.random == null)
        ? null:originPtr.random.next;
        originPtr = originPtr.next.next;
    }        
    //remove the copied nodes and form the copied list
    originPtr = head;
    while(originPtr != null){ 
        copyPtr = originPtr.next;
        originPtr.next = originPtr.next.next;
        copyPtr.next = (copyPtr.next == null) ? 
                        null:copyPtr.next.next;
        originPtr = originPtr.next;
    }   
    return copyList;
}
```
