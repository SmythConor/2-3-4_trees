data Tree t = Empty
	| Two t (Tree t) (Tree t)
	|	Three t t (Tree t) (Tree t) (Tree t)
	| Four t t t (Tree t) (Tree t) (Tree t) (Tree t)
		deriving (Eq, Ord, Show)

twoNode x = Two x Empty Empty
threeNode x y = Three x y Empty Empty Empty
fourNode x y z = Four x y z Empty Empty Empty Empty

addNode :: Ord a => a -> Tree a -> Tree a
-- Add twoNode, normal stuff
addNode x Empty = twoNode x
addNode x (Two a left right)
	| x < a = Two a (addNode x left) right
	| otherwise = Two a left (addNode x right)
-- Add threeNode, eh
addNode x (Three a b left middle right)
	| x <= a = Three a b (addNode x left) middle right
	| x >= b = Three a b left middle (addNode x right)
	| otherwise = Three a b left (addNode x middle) right

myTree = Empty
myTree1 = addNode 4 myTree
