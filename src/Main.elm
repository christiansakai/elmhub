module Main exposing (..)


import Html exposing (Html)
import Model as M
import Update as U
import View as V


main =
  Html.program
    { view = V.view
    , update = U.update
    , init = ( M.initialModel, Cmd.none )
    , subscriptions = \_ -> Sub.none
    }

