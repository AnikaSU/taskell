{-# LANGUAGE TemplateHaskell #-}

module Taskell.IO.HTTP.Aeson where

import ClassyPrelude

import           Data.Aeson          (defaultOptions, fieldLabelModifier)
import qualified Data.Aeson.TH       as TH (deriveFromJSON)
import           Language.Haskell.TH (Dec, Name, Q)

import Data.FileEmbed (embedFile)

deriveFromJSON :: Name -> Q [Dec]
deriveFromJSON = TH.deriveFromJSON defaultOptions {fieldLabelModifier = drop 1}

parseError :: String -> Text
parseError err = decodeUtf8 $(embedFile "templates/api-error.txt") <> "\n\n" <> pack err
