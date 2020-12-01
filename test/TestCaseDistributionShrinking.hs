{-# LANGUAGE TemplateHaskell #-}
module TestCaseDistributionShrinking where

import Test.QuickCheck

---------------------------
return []
runTests0 :: IO Bool
runTests0 = $quickCheckAll

runTests :: IO Bool
runTests =
  $forAllProperties $
    quickCheckWithResult (stdArgs {maxSuccess = 10000})
