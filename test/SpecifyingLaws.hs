-- | Specifying Laws
module SpecifyingLaws where

import Test.QuickCheck
import Test.Invariant

prop_commutativeAdd0 :: Int -> Int -> Bool
prop_commutativeAdd0 x y = x + y == y + x

prop_commutativeAdd :: Int -> Int -> Bool
prop_commutativeAdd = commutative (+)

j :: IO ()
j = quickCheck prop_commutativeAdd

k :: IO ()
k = quickCheck $ associative ((+) :: Int -> Int -> Int)

-- | fails like:
-- *** Failed! Falsified (after 4 tests and 5 shrinks):    
-- 0.1
-- 1.0
-- -1.6418279729338716
-- l = quickCheck $ associative ((+) :: Double -> Double -> Double)
-- uncomment to see ^
