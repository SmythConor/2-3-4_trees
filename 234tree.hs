data Tree t = Empty
	| Two t (Tree t) (Tree t)
	|	Three t t (Tree t) (Tree t) (Tree t)
	| Four t t t (Tree t) (Tree t) (Tree t) (Tree t)
		deriving (Eq, Ord, Show)

twoNode x = Two x Empty Empty
threeNode x y = Three x y Empty Empty Empty
fourNode x y z = Four x y z Empty Empty Empty Empty

addNode :: Ord a => a -> Tree a -> Tree a
-- Add nodes. Should work
addNode x Empty = twoNode x
addNode x (Two a left right)
	| x <= a = Three x a left Empty right
	| otherwise = Three a x left Empty right
addNode x (Three a b left Empty right)
	| x <= a = Four x a b left Empty right
	| x >= b = Four a b x left Empty right
	| otherwise = Four a x b left Empty right
addNode x (Four a b c left middle right)
	| x < a = Four a b c (addNode x left) middle right
	| x > c = Four a b c left middle (addNode x right)
	| otherwise = Four a b c left (addNode x middle) right
