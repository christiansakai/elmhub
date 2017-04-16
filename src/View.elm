module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Model as M
import Update as U

view : M.Model -> Html U.Msg
view model =
  div [ class "container" ]
    [ header 
    , searchBar model
    , searchResults model
    -- , h1 [] [ text (toString model) ]
    ]


header : Html U.Msg
header =
  section [ class "header" ]
    [ h1 [ class "header__title" ] [ text "ElmHub" ] 
    , span [ class "header__subtitle" ] [ text "Like GitHub, but for Elm things." ] 
    ] 


searchBar : M.Model -> Html U.Msg
searchBar model =
  section [ class "search-bar" ]
    [ searchInput model
    , searchOptions model.options
    ]


searchInput : M.Model -> Html U.Msg
searchInput model =
  div [ class "search-input" ]
    [ input [ class "search-input__input"
            , value model.query
            , onInput U.SetQuery 
            ] [] 
    , button [ class "search-input__button" ] [ text "Search" ] 
    ]


searchOptions : M.SearchOptions -> Html U.Msg
searchOptions options =
  div [ class "search-options" ]
    [ 
      Html.map U.Options (optionsSearchIn options)
    , Html.map U.Options (optionsOwnedBy options)
    , Html.map U.Options (optionsMinimumStars options)
    ]


optionsSearchIn : M.SearchOptions -> Html U.OptionsMsg
optionsSearchIn options = 
  div [ class "options" ] 
    [ label [ class "options__label" ] [ text "Search In" ]
    , select [ class "options__content"
             , value options.searchIn 
             , onInput U.SetSearchIn
             ] 
        [ option [ value "name" ] [ text "Name" ] 
        , option [ value "description" ] [ text "Name and Description" ]
        ]
    ]


optionsOwnedBy : M.SearchOptions -> Html U.OptionsMsg
optionsOwnedBy options =
  div [ class "options" ] 
    [ label [ class "options__label" ] [ text "Owned By" ]
    , input [ class "options__content"
            , type_ "text"
            , placeholder "Enter a username"
            , value options.userFilter 
            , onInput U.SetUserFilter
            ] []
    ]


optionsMinimumStars : M.SearchOptions -> Html U.OptionsMsg
optionsMinimumStars options =
  let
    inputClass =
        case options.minStarsError of
          Just _  -> "options__content options__content--error"
          Nothing -> "options__content"

  in
    div [ class "options"] 
      [ label [ class "options__label" ] [ text "Minimum Stars" ]
      , input [ class inputClass
              , type_ "text"
              , value (toString options.minStars) 
              , onInput U.SetMinStars
              ] []
      ]


searchResults : M.Model -> Html U.Msg
searchResults model =
  case model.results of
    []  -> noResult
    _   -> yesResults model.results


yesResults : List M.SearchResult -> Html U.Msg
yesResults searchResults =
  section [ class "search-results" ]
    [ resultsHeader
    , resultsBody searchResults
    ]


noResult : Html U.Msg
noResult =
  section [ class "no-results" ]
    [ h2 [] [ text "No results" ] ]


resultsHeader : Html U.Msg
resultsHeader =
  div [ class "results__row" ]
    [ h3 [ class "results__row__col0" ] [ text "Stars" ]
    , h3 [ class "results__row__col1" ] [ text "Name" ]
    ]


resultsBody : List M.SearchResult -> Html U.Msg
resultsBody searchResults =
  div [] (List.map resultsRow searchResults)
  

resultsRow : M.SearchResult -> Html U.Msg
resultsRow searchResult =
  div [ class "results__row" ]
    [ span [ class "results__row__col0" ] [ text (toString searchResult.stars) ]
    , div [ class "results__row__col1" ]
        [ a [ href ("https://github.com/" ++ searchResult.name)
            , target "_blank"
            ]
          [ text searchResult.name ]
        , button [ onClick (U.RemoveResult searchResult.id) ] [ text "X" ]
        ]
    ]
