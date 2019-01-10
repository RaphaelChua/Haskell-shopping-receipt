-- University of Glasgow / SIT
-- Raphael Chua 2355346C 

-- file Items.hs

module Items where



  data Item =  Item { name :: String, price :: Double, itemindex :: Int , offer :: Bool,reduction :: Double} deriving (Show)

  apple            = Item {name="Apples", price=0.50, itemindex=0,offer=True,reduction=0.00}
  watermelon       = Item {name="Watermelon", price=3.00, itemindex=0,offer=False,reduction=0.00}
  coffee           = Item {name="Sumatran Coffee Beans", price=6.00,itemindex=0,offer=False,reduction=0.00}
  lovage           = Item {name="Lovage", price=2.59, itemindex=0,offer=False,reduction=0.00}
  cheese           = Item {name="Cheese", price=3.00, itemindex=0,offer=True,reduction=0.00}
  creamCheese      = Item {name="Cream Cheese w. Black Pepper", price= 2.50, itemindex=0,offer=False,reduction=1.00}
  pork             = Item {name="Pork", price=4.00, itemindex=0,offer=False,reduction=0.00}
  chicken          = Item {name="Chicken", price=4.00, itemindex=0,offer=False,reduction=0.00}
  mozzarellaCheese = Item {name="Mozzarella Cheese", price=0.99, itemindex=0,offer=False,reduction=0.00}
  orange           = Item {name="Orange", price=3.00, itemindex=0,offer=False,reduction=0.00}
  banana           = Item {name="Banana", price=0.80, itemindex=0,offer=False,reduction=0.00}
  porkreduction    = Item {name="Pork", price=4.00, itemindex=0,offer=False,reduction=2.00}
  cheesereduction  = Item {name="Cheese", price=3.00, itemindex=0,offer=False,reduction=1.00}




  