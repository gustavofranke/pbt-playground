-- | Refining Generated Data
module RefiningGeneratedData where

import Test.QuickCheck.Instances ()
import qualified Data.ByteString.Internal as BL

import Codec.Binary.Base64

prop_decEnc :: BL.ByteString -> Bool
prop_decEnc b = decode (encode b) == Right b