-- | Running Multiple Tests
module Main where

import qualified GenerateAndSample as GS
import qualified SpecifyingLaws   as SL
import qualified RefiningGeneratedData as RG
import qualified TestCaseDistributionShrinking as TC

import System.Exit ( exitFailure, exitSuccess )

main :: IO ()
main = do
  good <- and <$> sequence [GS.runTests, SL.runTests, RG.runTests, TC.runTests]
  if good
     then exitSuccess
     else exitFailure
