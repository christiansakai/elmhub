module Model exposing (Model, SearchOptions, initialModel)


type alias Model = 
  { query : String 
  , options : SearchOptions
  }

  
type alias SearchOptions =
    { minStars : Int
    , minStarsError : Maybe String
    , searchIn : String
    , userFilter : String

    }


initialModel : Model
initialModel =
  { query = "elm"
  , options =
      { minStars = 0
      , minStarsError = Nothing
      , searchIn = "name"
      , userFilter = ""
      }
  }
