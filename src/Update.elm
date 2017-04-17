module Update exposing ( update )

import Model as M
import Message as Ms
import Helper as H


update : Ms.Msg -> M.Model -> ( M.Model, Cmd Ms.Msg )
update msg model = 
  case msg of
    Ms.SetQuery query ->
      ( { model | query = query }, Cmd.none )

    Ms.Options optionsMsg ->
      ( { model | options = updateOptions optionsMsg model.options }, Cmd.none )

    Ms.Search -> 
      ( model, H.githubSearch (H.getQueryString model) )

    Ms.RemoveResult id ->
      ( { model | results = List.filter (\result -> id /= result.id) model.results }, Cmd.none )

    Ms.HandleSearchResponse searchResponse ->
      ( { model | results = searchResponse
                , errorMessage = Nothing }, Cmd.none )

    Ms.HandleSearchError error ->
      case error of
        Just errorMessage ->
          ( { model | errorMessage = Just errorMessage }, Cmd.none )

        Nothing ->
          ( { model | errorMessage = Nothing }, Cmd.none )


updateOptions : Ms.OptionsMsg -> M.SearchOptions -> M.SearchOptions
updateOptions optionsMsg options =
  case optionsMsg of
    Ms.SetMinStars minStars -> 
      case String.toInt minStars of
        Ok minStars -> 
          { options | minStars = minStars
                    , minStarsError = Nothing }
        
        Err _ ->
          { options | minStarsError = Just "Must be an integer!" }

    Ms.SetSearchIn searchIn ->
      { options | searchIn = searchIn }

    Ms.SetUserFilter userFilter ->
      { options | userFilter = userFilter }
