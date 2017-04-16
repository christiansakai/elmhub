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
    , h1 [] [ text (toString model) ]
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
      -- (optionsSearchIn options)
      Html.map U.Options (optionsOwnedBy options)
    -- , (optionsMinimumStars options)
    ]


optionsSearchIn : M.SearchOptions -> Html U.Msg
optionsSearchIn options = 
  div [ class "options" ] 
    [ label [ class "options__label" ] [ text "Search In" ]
    , select [ class "options__content"
             , value options.searchIn 
             -- , onChange U.SetSearchIn
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


optionsMinimumStars : M.SearchOptions -> Html U.Msg
optionsMinimumStars options =
  div [ class "options"] 
    [ label [ class "options__label" ] [ text "Minimum Stars" ]
    , input [ class "options__content"
            , type_ "text"
            , value (toString options.minStars) 
            -- , onInput SetMinStars
            ] []
    ]


searchResults : M.Model -> Html U.Msg
searchResults model =
  yesResults


yesResults : Html U.Msg
yesResults =
  section [ class "search-results" ]
    [ resultsHeader
    , resultsBody
    ]


noResults : Html U.Msg
noResults =
  section [ class "no-results" ]
    [ h2 [] [ text "No results" ] ]


resultsHeader : Html U.Msg
resultsHeader =
  div [ class "results__row" ]
    [ h3 [ class "results__row__col0" ] [ text "Stars" ]
    , h3 [ class "results__row__col1" ] [ text "Name" ]
    ]


resultsBody : Html U.Msg
resultsBody =
  div []
    [ resultsRow
    , resultsRow
    , resultsRow
    , resultsRow
    , resultsRow
    , resultsRow
    ]
  

resultsRow : Html U.Msg
resultsRow =
  div [ class "results__row" ]
    [ span [ class "results__row__col0" ] [ text "300" ]
    , div [ class "results__row__col1" ]
        [ a [ href "#" ] [ text "#######" ]
        , button [] [ text "X" ]
        ]
    ]

