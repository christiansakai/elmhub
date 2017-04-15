module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import Model exposing (Model)
import Update exposing (Msg)


view : Model -> Html Msg
view model =
  div [ class "container" ]
    [ header 
    , searchBar model
    , searchResults model
    ]


header : Html Msg
header =
  section [ class "header" ]
    [ h1 [ class "header__title" ] [ text "ElmHub" ] 
    , span [ class "header__subtitle" ] [ text "Like GitHub, but for Elm things." ] 
    ] 


searchBar : Model -> Html Msg
searchBar model =
  section [ class "search-bar" ]
    [ searchInput
    , searchOptions
    ]


searchInput : Html Msg
searchInput =
  div [ class "search-input" ]
    [ input [ class "search-input__input", defaultValue "elm" ] [] 
    , button [ class "search-input__button "] [ text "Search" ] 
    ]


searchOptions : Html Msg
searchOptions =
  div [ class "search-options" ]
    [ optionsSearchIn
    , optionsOwnedBy
    , optionsMinimumStars
    ]


optionsSearchIn : Html Msg
optionsSearchIn = 
  div [ class "options" ] 
    [ label [ class "options__label" ] [ text "Search In" ]
    , select [ class "options__content" ] 
        [ option [ value "name" ] [ text "Name" ] 
        , option [ value "description" ] [ text "Name and Description" ]
        ]
    ]


optionsOwnedBy : Html Msg
optionsOwnedBy =
  div [ class "options" ] 
    [ label [ class "options__label" ] [ text "Owned By" ]
    , input [ class "options__content"
            , type_ "text"
            , placeholder "Enter a username" ] []
    ]


optionsMinimumStars : Html Msg
optionsMinimumStars =
  div [ class "options"] 
    [ label [ class "options__label" ] [ text "Minimum Stars" ]
    , input [ class "options__content"
            , type_ "text"
            , placeholder "0" ] []
    ]


searchResults : Model -> Html Msg
searchResults model =
  yesResults


yesResults : Html Msg
yesResults =
  section [ class "search-results" ]
    [ resultsHeader
    , resultsBody
    ]


noResults : Html Msg
noResults =
  section [ class "no-results" ]
    [ h2 [] [ text "No results" ] ]


resultsHeader : Html Msg
resultsHeader =
  div [ class "results__row" ]
    [ h3 [ class "results__row__col0" ] [ text "Stars" ]
    , h3 [ class "results__row__col1" ] [ text "Name" ]
    ]


resultsBody : Html Msg
resultsBody =
  div []
    [ resultsRow
    , resultsRow
    , resultsRow
    , resultsRow
    , resultsRow
    , resultsRow
    ]
  

resultsRow : Html Msg
resultsRow =
  div [ class "results__row" ]
    [ span [ class "results__row__col0" ] [ text "300" ]
    , div [ class "results__row__col1" ]
        [ a [ href "#" ] [ text "#######" ]
        , button [] [ text "X" ]
        ]
    ]





-- tableConfig : Table.Config SearchResult Msg
-- tableConfig =
--     Table.config
--         { toId = .id >> toString
--         , toMsg = SetTableState
--         , columns = [ starsColumn, nameColumn ]
        -- }


-- viewStars : SearchResult -> Table.HtmlDetails Msg
-- viewStars result =
--     Table.HtmlDetails []
--         [ span [ class "star-count" ] [ text (toString result.stars) ] ]


-- viewSearchResult : SearchResult -> Table.HtmlDetails Msg
-- viewSearchResult result =
--     Table.HtmlDetails []
--         [ a [ href ("https://github.com/" ++ result.name), target "_blank" ]
--             [ text result.name ]
--         , button [ class "hide-result", onClick (DeleteById result.id) ]
--             [ text "X" ]
--         ]



-- starsColumn : Table.Column SearchResult Msg
-- starsColumn =
--     Table.veryCustomColumn
--         { name = "Stars"
--         , viewData = viewStars
--         , sorter = Table.increasingOrDecreasingBy (negate << .stars)
--         }


-- nameColumn : Table.Column SearchResult Msg
-- nameColumn =
--     Table.veryCustomColumn
--         { name = "Name"
--         , viewData = viewSearchResult
--         , sorter = Table.increasingOrDecreasingBy .name
--         }


---- PROGRAM ----

