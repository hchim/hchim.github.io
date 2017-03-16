---
layout: post
categories: Leetcode
tags: [linked-list]

---

Given a linked list, determine if it has a cycle in it. Follow up: Can you solve it without using extra space?

#### Floyd’s cycle-finding algorithm

Use two pointers, a fast pointer and a slow pointer. Point both of them to the head at the beginning.
The fast pointer moves two steps in each iteration and the slow pointer moves 1 step in each iteration.
When they met the next time, there is a cycle.

```java
public boolean hasCycle(ListNode head) {
    if(head == null || head.next == null 
            || head.next.next == null)
        return false;

    ListNode fast, slow;
    fast = head.next.next; 
    slow = head.next;
    boolean result = false;
    while(slow != fast){
        if(fast.next == null 
        || fast.next.next == null){
            break;
        }
        fast = fast.next.next; 
        slow = slow.next;           
    }
    result = (fast == slow);
    return result;
}
```

### Linked List Cycle II

Given a linked list, return the node where the cycle begins. If there is no cycle, return null. 

Follow up: Can you solve it without using extra space?

#### Analysis

For the list a1,…,an, assume the length of the cycle is v, n - v = u. When the fast pointer and the 
slow pointer meet at am, assume the slow pointer had moved x steps in the cycle. Then we have:

```
          -------------
          |           |
a1, a2,...as....am...an
//the fast pointer moved steps is two times of the slow pointer
2(u+x) = u + kv + x

so , u + x = kv => u = kv - x
```

The steps that the slow pointer moves are k times of the length of the cycle.
So, if the slow pointer moves from the head and the fast pointer moves from current position once again, 
they will meet at the first position of the cycle.

```java
public ListNode detectCycle(ListNode head) {
    if(head == null || head.next == null 
            || head.next.next == null)
        return null;
    ListNode fast, slow;
    fast = head.next.next; 
    slow = head.next;
    while(slow != fast){
        if(fast.next == null 
        || fast.next.next == null){
            break;
        }
        fast = fast.next.next; 
        slow = slow.next;           
    }
    
    if(fast != slow) 
      return null;
    slow = head;
    while(slow != fast){
        slow = slow.next;
        fast = fast.next;
    }
    return slow;
}
```
