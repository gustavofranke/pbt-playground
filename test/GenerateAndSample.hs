{-# LANGUAGE DeriveGeneric #-}

-- | Generating Random Test Cases
module GenerateAndSample where

import GHC.Generics

import Test.QuickCheck
import Test.QuickCheck.Arbitrary.Generic
import Test.QuickCheck.Instances ()

a :: IO Integer
a = generate $ elements [1,2,3]

b :: IO Char
b = generate $ choose ('a', 'z')

c :: IO Integer
c = generate $ return 1

d :: IO Bool
d = generate $ choose (False,True)

e :: IO Bool
e = generate (arbitrary :: Gen Bool)

data MyType = MyType {
    foo :: Int
  , bar :: Bool
  , baz :: Float
  } deriving (Show, Generic)

f :: IO MyType
f = generate $ MyType <$> arbitrary <*> arbitrary <*> arbitrary

f0 :: IO MyType
f0 = generate (genericArbitrary :: Gen MyType)

myList :: Arbitrary a => Gen [a]
myList =
  oneof
    [ return [],
      (:) <$> arbitrary <*> myList
    ]

myList' :: Arbitrary a => Gen [a]
myList' =
  frequency
    [ (1, return []),
      (4, (:) <$> arbitrary <*> myList')
    ]

flexList :: Arbitrary a => Gen [a]
flexList = sized $ \n ->
  frequency
    [ (1, return [])
    , (n, (:) <$> arbitrary <*> flexList)
    ]

g :: IO ()
g = sample (flexList :: Gen [Int])

h :: IO [Int]
h = generate (resize 1000 flexList :: Gen [Int])

i :: IO [Int]
i = generate (scale (*33) flexList :: Gen [Int])
