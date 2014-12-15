-- Conor Smyth 12452382
-- 2-3-4 Tree
-- All work is my own

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

-- Add to Three tree

addNode x (Three (a,b) Empty Empty Empty)
	| x <= a = Four (x,a,b) Empty Empty Empty Empty
	| x >= b = Four (a,b,x) Empty Empty Empty Empty
	| otherwise = Four (a,x,b) Empty Empty Empty Empty

-- If the child node is a Four tree, promote the middle element and turn it into
-- a three tree

addNode x (Two a l r)
  | x <= a = case l of (Four (a1,b1,c1) l1 m1 m2 r1)
                                                    | x <= b1 -> Three (b1,a) (addNode x (Two a1 l1 m1)) (Two c1 m2 r1) r
                                                    | otherwise -> Three (b1,a) (Two a1 l1 m1) (addNode x (Two c1 m2 r1)) r
                       _ -> Two a (addNode x l) r
  | otherwise = case r of (Four (a1,b1,c1) l1 m1 m2 r1)
                                                       | x >= b1 -> Three (a,b1) l (addNode x (Two a1 l1 m1)) (Two c1 m2 r1)
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

-- Add to a Four tree

addNode x (Four (a,b,c) l m1 m2 r)
  | x <= b = Two b (addNode x (Two a l m1)) (Two c m2 r)
  | otherwise = Two b (Two a l m1) (addNode x (Two c m2 r))

{-- Make a tree from a list
		Needed for testing
-}

makeTree :: Ord t => [t] -> Tree t
makeTree [x] = Two x Empty Empty
makeTree (x:xs) = addNode x (makeTree xs)

{-- Search
		Checks the parent item then each node
		Returns false if item not found

		Usage: search 5 myTree
-}

search :: Ord a => a -> Tree a -> Bool
search x Empty = False

search x (Two a l r)
  | x == a = True
  | x < a = search x l
  | otherwise = search x r

search x (Three (a,b) l m r)
  | x == a = True
  | x == b = True
  | x < a = search x l
  | x > b = search x r
  | otherwise = search x m

search x (Four (a,b,c) l m1 m2 r)
  | x == a = True
  | x == b = True
  | x == c = True
  | x < a = search x l
  | x > c = search x r
  | x < b = search x m1
  | otherwise = search x m2

{-- indent
		Adds indent
-}
indent :: [String] -> [String]
indent = map ("  \t"++)

{-- layoutTree
		Lays out the tree in a string list
-}

layoutTree :: Show a => Tree a -> [String]
layoutTree Empty = []
layoutTree (Two a l r) 
         = indent (layoutTree r) ++ [show a] ++ indent (layoutTree l)
layoutTree (Three (a,b) l m r)
         = indent (layoutTree r) ++ [show b] ++ indent (layoutTree m) ++ [show a] ++ indent (layoutTree l)
layoutTree (Four (a,b,c) l m1 m2 r)
         = indent (layoutTree r) ++ [show c] ++ indent (layoutTree m2) ++ [show b] ++ indent (layoutTree m1) ++ [show a] ++ indent (layoutTree l)

{-- dTree
		Returns the list of tree as a string
-}
dTree :: Show a => Tree a -> String
dTree = unlines.layoutTree

{-- displayTree
		Displays the tree horizontally
		Not as pretty as hoped

		Usage: displayTree myTree
-}

displayTree :: Show a => Tree a -> IO()
displayTree t = putStrLn (dTree t)

-- Test tree

myTree = makeTree [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
