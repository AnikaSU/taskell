{-# LANGUAGE NoImplicitPrelude #-}

module Utility.Parser where

import ClassyPrelude

import Data.Attoparsec.Text

lexeme :: Parser a -> Parser a
lexeme p = skipSpace *> p <* skipSpace

word :: Parser Text
word = lexeme $ pack <$> many1 letter