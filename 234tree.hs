data Tree t = Empty
	| Two t (Tree t) (Tree t)
	|	Three (t,t) (Tree t) (Tree t) (Tree t)
	| Four (t,t,t) (Tree t) (Tree t) (Tree t) (Tree t)
	deriving (Eq, Ord, Show)

addNode :: Ord a => a -> Tree a -> Tree a

-- Add nodes

addNode x Empty = Two x Empty Empty

-- Add to Two tree

addNode x (Two a Empty Empty)
	| x <= a = Three (x,a) Empty Empty Empty
	| otherwise = Three (a,x) Empty Empty Empty

-- Add to Three

addNode x (Three (a,b) Empty Empty Empty)
	| x <= a = Four (x,a,b) Empty Empty Empty Empty
	| x >= b = Four (a,b,x) Empty Empty Empty Empty
	| otherwise = Four (a,x,b) Empty Empty Empty Empty

-- Add to two with values
-- if less than a add to left tree.
-- if greater than a add to right tree.
-- Must check for Four Three and Two node
-- If the left tree is a four tree move middle from four to the two above and

addNode x (Two a l r)
	| x <= a = case l of (Four (a1,b1,c1) l1 m1 m2 r1)
																											| x <= b1 -> (Three (b1,a) (addNode x (Two a1 l m1)) (Two c1 m2 r1) r)
																											| otherwise -> (Three (b1,a) l (addNode x (Two c1 m1 m2)) r)
											 (Three (a1,b1) l1 m1 r1)
											 																| x <= a1 -> (Four (x,a1,b1) l1 m1 Empty r1)
											 																| x >= b1 -> (Four (a1,b1,x) l1 m1 Empty r1)
																											| otherwise -> (Four (a1,x,b1) l1 m1 Empty r1)
											 (Two a1 l1 r1)
											 																| x <= a1 -> (Three (x,a1) l1 Empty r1)
											 																| otherwise -> (Three (a1,x) l1 Empty r1)
	| x >= a = case r of (Four (a1,b1,c1) l1 m1 m2 r1)
																											| x <= a1 -> (Four (a1,b1,c1) (addNode x l1) m1 m2 r1)
																											| x >= c1 -> (Four (a1,b1,c1) l1 m1 m2 (addNode x r1))
																											| x <= m1 -> (Four (a1,b1,c1) l1 (addNode x m1) m2 r1)
																											| otherwise -> (Four (a1,b1,c1) l1 m1 (addNode x m2) r1)
											 (Three (a1,b1) l1 m1 r1)
											 																| x <= a1 -> (Four (x,a1,b1) l1 m1 Empty r1)
											 																| x >= b1 -> (Four (a1,b1,x) l1 m1 Empty r1)
																											| otherwise -> (Four (a1,x,b1) l1 m1 Empty r1)
											 (Two a1 l1 r1)
											 																| x <= a1 -> (Three (x,a1) l1 Empty r1)
											 																| otherwise -> (Three (a1,x) l1 Empty r1)
	| otherwise = addNode x l

--addNode x (Two a l r)

-- Tests
myTree2 x = addNode x Empty
myTree3 x = addNode x (Two 10 Empty Empty)
myTree4 x = addNode x (Three (8,12) Empty Empty Empty)
myTree5 x = addNode x (Two 5 3 10)
