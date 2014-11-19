2-3-4 Trees Haskell
===========

Haskell Assignment on 2-3-4 Trees. Due 10:00 Monday 15th December 2014

---

2-3-4 Trees are a type of "self balancing" tree. There are 3 types of nodes:

* Nodes that contain one data item and have two subtrees, called a 2-node. Every thing in the left subtree is less than or equal to the node's data item. Everything in the right subtree is greater than the node's data item.
* Nodes that contain two data item and have three subtrees, called a 3-node. Every thing in the left subtree is less than or equal to the node's first data item. Everything in the middle subtree is greater than the node's first data item and less than or equal to the node's second data item. Everything in the right subtree is greater than the node's second data item.
* Nodes that contain three data item and have four subtrees, called a 4-node. Every thing in the first (left) subtree is less than or equal to the node's first data item. Everything in the second subtree is greater than the node's first data item and less than or equal to the node's second data item. Everything in the third subtree is greater than the node's second data item and less than or equal to the node's third data item. Everything in the fourth (right) subtree is greater than the node's third data item.

---

Implement an ___insertion function___, ___search function___ and ___display function___ for 2-3-4 trees.

The display function should display the 2-3-4 tree in as intuitive manner as possible. Marks will be given for the "niceness" of the result. Hence

```
Root 15 (Root 2 4 8 (Root 1 Empty Empty) (Root 3 Empty Empty) (Root 6 Empty Empty)) (Root 9 Empty Empty)) (Root 20 Empty (Root 25 Empty Empty))
```

would not get many marks whereas

```
                      [15]
    [2   4    8]              [20]
 [1]  [3]  [6]  [9]                  [25]
 ```
 
 would get lots of marks.

---

The rules for insertion into a 2-3-4 tree are:

* Find the lowest node it can be added into.
* This will modify the node the data was added to:
    * This will convert a 2-node into a 3-node.
    * This will convert a 3-node into a 4-node.
    * In the case of a 4-node, take the middle data item and add it to the node's parent. This will modify the parent node:
      * If the parent node is a 2-node, it will covert into a 3-node.
      * If the parent node is a 3-node, it will covert into a 4-node.
      * If the parent node is a 4-node, then take the middle data element and promote it to its parent. If the parent is the root and it is a 4-node, split it into a 2-node with two 3-node children.
      
  For the 2-3-4 tree above, if we add 10 and 11 we will get:
```
                           [15]
    [2   4    8]                   [20]
 [1]  [3]  [6]  [9 10 11]                  [25]
 ```
  Adding 12 would result in a node [9 10 11 12], which would be split, promoting the 10 to its parent. The parent would then be [2 4 6 10], which would be split promting the 4 to its parent. The final result would be:
```
                              [4 15]
    [2]         [8 10]                   [20]
 [1]   [3]   [6] [9]  [11 12]                  [25]
 ```

---

Individual assignment
