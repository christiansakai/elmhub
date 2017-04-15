module Model exposing (Model, initialModel)

type alias Model = 
  { message : String
  , logo : String
  }

initialModel : Model
initialModel =
  { message = "ElmHub"
  , logo = "Logo"
  }

-- type alias Model =
--     { message : String
--     , logo : String
--     -- , tableState : Table.State
--     }

-- initialModel : String -> Model
-- initialModel path = 
--   { message = "Your Elm App is working!"
--   , logo = path
--   -- , tableState  = Table.initialSort "Stars"
--   }


