module Update exposing ( Msg ( SetQuery
                             , Options
                             )
                       , OptionsMsg (..)
                       , update )

import Model as M


type Msg
    = SetQuery String
    | Options OptionsMsg


type OptionsMsg
    = SetMinStars String
    | SetSearchIn String
    | SetUserFilter String


update : Msg -> M.Model -> M.Model
update msg model = 
  case msg of
    SetQuery query ->
      { model | query = query }

    Options optionsMsg ->
      { model | options = updateOptions optionsMsg model.options }


updateOptions : OptionsMsg -> M.SearchOptions -> M.SearchOptions
updateOptions optionsMsg options =
  case optionsMsg of
    SetMinStars minStars -> 
      case String.toInt minStars of
        Ok minStars -> 
          { options | minStars = minStars
                    , minStarsError = Nothing }
        
        Err _ ->
          { options | minStarsError = Just "Must be an integer!" }

    SetSearchIn searchIn ->
      { options | searchIn = searchIn }

    SetUserFilter userFilter ->
      { options | userFilter = userFilter }
