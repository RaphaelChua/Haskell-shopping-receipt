-- University of Glasgow / SIT
-- Raphael Chua 2355346C 

-- file Main.hs

module Main (main) where

import Receipts
import Items
    --  ------------------------------------------------------------------- [ Main ]
    
main :: IO ()
main = do
  let aliceReceipt = [apple,apple,apple,apple,apple,watermelon,coffee,lovage,cheese,cheese,creamCheese] 
  let bobReceipt = [pork,chicken,cheese,mozzarellaCheese,apple,apple,orange,cheese]
  let charlieReceipt = [porkreduction,apple,banana,cheesereduction,cheesereduction,cheesereduction]
  generateReceipt (toString (checkout (itemIndexValue aliceReceipt 0)))
  generateReceipt (toString (checkout (itemIndexValue bobReceipt 0)))
  generateReceipt (toString (checkout (itemIndexValue charlieReceipt 0)))
    
    
generateReceipt :: String -> IO ()
generateReceipt r = do
  putStrLn "<start>"
  putStr r
  putStrLn "<end>"
    
    --  -------------------------------------------------------------------- [ EOF ]