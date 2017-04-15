module Main exposing (..)


import Html exposing (Html)
import Model exposing (Model, initialModel)
import Update exposing (Msg, update)
import View exposing (view)


main =
  Html.beginnerProgram
    { view = view
    , update = update
    , model = initialModel
    }




-- main : Program String Model Msg
-- main =
    -- Html.programWithFlags
    --     { view = view
    --     , init = init
    --     , update = update
    --     , subscriptions = \_ -> Sub.none
    --     }

---- MODEL ----

-- init : String -> ( Model, Cmd Msg )
-- init path =
--     ( initialModel path, Cmd.none )
