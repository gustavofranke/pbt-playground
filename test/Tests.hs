{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE DeriveGeneric #-}

module Main where

import Test.QuickCheck
import System.Exit

runTests :: IO Bool
runTests = $quickCheckAll

main :: IO ()
main = do
  good <- and <$> sequence [runTests]
  if good
     then exitSuccess
     else exitFailure
