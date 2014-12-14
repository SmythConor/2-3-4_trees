-- insert 5 
-- search 3
-- display 5
-- style 2
-- Total 15
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
                                                    | x <= a1 -> Three (b1,a) (addNode x (Two a1 l1 m1)) (Two c1 m2 r1) r
                                                    | otherwise -> Three (b1,a) (Two a1 l1 m1) (addNode x (Two c1 m2 r1)) r
                       _ -> Two a (addNode x l) r
  | otherwise = case r of (Four (a1,b1,c1) l1 m1 m2 r1)
                                                       | x >= c1 -> Three (a,b1) l (addNode x (Two a1 l1 m1)) (Two c1 m2 r1)
                                                       | otherwise -> Three (a,b1) l (Two a1 l1 m1) (addNode x (Two c1 m2 r1))
                          _ -> Two a l (addNode x r)

addNode x (Three (a,b) l m r)
  | x <= a = case l of (Four (a1,b1,c1) l1 m1 m2 r1)
                                                    | x <= b1 -> Four (b1,a,b) (addNode x (Two a1 l1 m1)) (Two c1 m2 r1) m r
                                                    | otherwise -> Four (b1,a,b) (Two a1 l1 m1) (addNode x (Two c1 m2 r1)) m r
                       _ -> Three (a,b) (addNode x l) m r
  | x >= b = case r of (Four (a1,b1,c1) l1 m1 m2 r1)
                                                   | x >= b1 -> Four (a,b,b1) l m (addNode x (Two a1 l1 m1)) (Two c1 m2 r1)
                                                   | otherwise -> Four (a,b,b1) l m (Two a1 l1 m1) (addNode x (Two c1 m2 r1))
                       _ -> Three (a,b) l m (addNode x r)
  | otherwise = case m of (Four (a1,b1,c1) l1 m1 m2 r1)
                                                       | x <= b1 -> Four (a,b1,b) l (addNode x (Two a1 l1 m1)) (Two c1 m2 r1) r
                                                       | otherwise -> Four (a,b1,b) l (Two a1 l1 m1) (addNode x (Two c1 m2 r1)) r
                          _ -> Three (a,b) l (addNode x m) r
addNode x (Four (a,b,c) l m1 m2 r)
  | x <= a = Two b (addNode x (Two a l m1)) (Two c m2 r)
  | otherwise = Two b (Two a l m1) (addNode x (Two c m2 r))

makeTree :: Ord t => [t] -> Tree t
makeTree x = mTree x Empty

mTree :: Ord t => [t] -> Tree t -> Tree t
mTree [] t = t
mTree (x:xs) t = mTree xs (addNode x t)

