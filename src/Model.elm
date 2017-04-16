module Model exposing (Model, SearchOptions, initialModel)


type alias Model = 
  { query : String 
  , options : SearchOptions
  }

  
type alias SearchOptions =
    { minStars : Int
    , searchIn : String
    , userFilter : String
    }


initialModel : Model
initialModel =
  { query = "elm"
  , options =
      { minStars = 0
      , searchIn = "name"
      , userFilter = ""
      }
  }
