{-# LANGUAGE DeriveGeneric #-}

module Data.Taskell.List where

import GHC.Generics (Generic)
import Data.Aeson (FromJSON, ToJSON)

import Data.Sequence (Seq, (|>), (!?), deleteAt)
import qualified Data.Taskell.Seq as S

import Data.Taskell.Task (Task, blank)

data List = List {
    title :: String,
    tasks :: Seq Task
} deriving (Generic, Show, Eq)

instance FromJSON List
instance ToJSON List

-- useful functions
empty :: String -> List
empty t = List {
    title = t,
    tasks = S.empty 
}

new :: List -> List
new = append blank

append :: Task -> List -> List
append t l = l { tasks = tasks l |> t }

extract :: Int -> List -> Maybe (List, Task)
extract i l = do
    (xs, x) <- S.extract i (tasks l) 
    return (l { tasks = xs }, x)

update :: Int -> (Task -> Task) -> List -> Maybe List
update i fn l = do
    ts' <- S.updateFn i fn (tasks l)
    return $ l { tasks = ts' }

move :: Int -> Int -> List -> Maybe List
move from dir l = do
    ts' <- S.shiftBy from dir (tasks l)
    return $ l { tasks = ts' } 

deleteTask :: Int -> List -> List
deleteTask i l = l { tasks = deleteAt i (tasks l) }

getTask :: Int -> List -> Maybe Task
getTask i l = tasks l !? i