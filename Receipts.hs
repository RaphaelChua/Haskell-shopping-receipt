-- University of Glasgow / SIT
-- Raphael Chua 2355346C 

-- file Receipts.hs

module Receipts  where

import Items 
import Data.List (sortBy)
import Data.Ord (comparing)
import Numeric

data Receipt = Receipt {
    normalitems :: String,
    bogofitems :: String,
    markdownitems :: String,
    fullprice :: Double,
    savingsfromoffers :: Double,
    savingsfromreduction :: Double,
    totalprice :: Double
} deriving (Show, Eq, Ord)

-- checkout function to take in the items from the main.hs
checkout :: [Item] -> Receipt
checkout it = 
    let normalitems' = listOfNormalItem it
        bogofitems' =  listOfSortedBOGOF $ sortBy (comparing name)(filter (\x -> offer x == True) it)
        markdownitems' = listOfMarkdownItems $ filter(\x -> reduction x > 0 ) it
        fullprice' = foldl(\acc x -> acc + price x) 0 it
        getreduction = filter(\x -> reduction x > 0 ) it
        savingsfromreduction' = foldl(\acc x -> acc + (price x -reduction x)) 0 getreduction
        savingsfromoffers' = listOfPriceSortedBOGOF $ sortBy (comparing name)(filter (\x -> offer x == True) it)
        totalprice' = fullprice' - (savingsfromreduction' + savingsfromoffers')
    in Receipt {normalitems = normalitems',bogofitems = bogofitems',
    markdownitems=markdownitems',savingsfromreduction=savingsfromreduction', savingsfromoffers=savingsfromoffers',
    fullprice = fullprice',totalprice = totalprice'}

-- get all the items
listOfNormalItem :: [Item] -> String
listOfNormalItem [] = []
listOfNormalItem (x:xs) = "+ " ++ show(itemindex x) ++ " " ++ name x ++ " " ++showFFloat(Just 2) (price x)"" ++ "\n" ++ listOfNormalItem xs  

-- get each offer item and pair them up and show before and after price
listOfSortedBOGOF ::[Item] -> String
listOfSortedBOGOF [] = []
listOfSortedBOGOF (x:xs) =
    if length xs /= 0
        then 
            if name x == name (xs!!0) then "+ "++ show(itemindex x) ++ " " ++ show(itemindex(xs!!0)) ++" "++ showFFloat(Just 2)(price x *2)"" ++" " ++ showFFloat(Just 2)(price x)"" ++"\n" ++ listOfSortedBOGOF (tail xs)
            else listOfSortedBOGOF xs 
    else ""

-- get offer price savings
listOfPriceSortedBOGOF ::[Item] -> Double
listOfPriceSortedBOGOF [] = 0
listOfPriceSortedBOGOF (x:xs) =
    if length xs /= 0
        then 
            if name x == name (xs!!0) 
                then  price x + listOfPriceSortedBOGOF (tail xs)
            else listOfPriceSortedBOGOF xs 
    else 0

-- get each markdown price savings
listOfMarkdownItems :: [Item] -> String
listOfMarkdownItems [] = []
listOfMarkdownItems (x:xs) = "+ " ++ show(itemindex x )++" " ++ showFFloat(Just 2) (price x)"" ++ " " ++ showFFloat(Just 2) (reduction x)"" ++ "\n"  ++ listOfMarkdownItems xs

-- tag each item a position index
itemIndexValue :: [Item] -> Int -> [Item]
itemIndexValue [] _ = []
itemIndexValue (x:xs) acc =
    let acc' = acc + 1
    in [x{itemindex = acc'}] ++ itemIndexValue xs acc'

-- if there is no markdown, it would not display the markdown items
checkreduction :: String -> String
checkreduction rdt =
    if rdt == "" then ""
    else "* Reduced Items \n\n" ++ rdt ++ "\n"

-- if there is no markdown, it would not display the markdown price
checkmarkdownreduction :: Double -> String
checkmarkdownreduction rdt = 
    if rdt == 0.0 then ""
    else "+ " ++ "Savings from Reductions :: " ++ showFFloat(Just 2) rdt "" ++ "\n"

-- if there is no offer, it would not display the offer items
checkoffer :: String -> String
checkoffer cof = 
    if cof == "" then ""
    else "* Offers Applied \n\n" ++ cof ++ " \n"

-- if there is no offer, it would not display the offer price
checkofferreduction :: Double -> String
checkofferreduction cof =
    if cof == 0.0 then ""
    else  "+ " ++ "Savings from Offers :: " ++ showFFloat(Just 2) cof "" ++ "\n"

-- function to print out the receipt items
toString :: Receipt -> String
toString r = "* Item purchased \n" ++ normalitems r ++ "\n" ++ 
            checkoffer(bogofitems r) ++ 
            checkreduction(markdownitems r) ++
            "* Totals \n\n"++
            "+ " ++ "Full Price :: "++ showFFloat(Just 2) (fullprice r) "" ++ "\n" ++
            checkofferreduction(savingsfromoffers r) ++ 
            checkmarkdownreduction(savingsfromreduction r) ++
            "+ " ++ "Total Price :: " ++ showFFloat(Just 2) (totalprice r) "" ++ "\n"
