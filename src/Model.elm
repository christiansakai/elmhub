module Model exposing ( Model
                      , SearchOptions
                      , SearchResult
                      , initialModel
                      )


type alias Model = 
  { query : String 
  , options : SearchOptions
  , results : List SearchResult
  }

  
type alias SearchOptions =
    { minStars : Int
    , minStarsError : Maybe String
    , searchIn : String
    , userFilter : String
    }


type alias SearchResult =
    { id : Int
    , name : String
    , stars : Int
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
  , results =
      [ { id = 0
        , name = "Elm"
        , stars = 1
        }
      , { id = 1
        , name = "Elixir"
        , stars = 2
        }
      , { id = 3
        , name = "Learn"
        , stars = 3
        }
      ]
  }
