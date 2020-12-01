{-# LANGUAGE TemplateHaskell #-}

-- | Specifying Laws
module SpecifyingLaws where

import Test.QuickCheck
import Test.Invariant

-- prop_commutativeAdd :: Gen Result
-- prop_commutativeAdd = do
--   (x, y) <- arbitrary :: Gen (Int, Int)
--   return $ if x + y == y + x
--     then succeeded
--     else failed { reason = "stupid non-commutative addition" }

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
---------------------------
return []
runTests0 :: IO Bool
runTests0 = $quickCheckAll

runTests :: IO Bool
runTests =
  $forAllProperties $
    quickCheckWithResult (stdArgs {maxSuccess = 10000})