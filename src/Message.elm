module Message exposing ( Msg ( SetQuery
                              , Options
                              , Search
                              , RemoveResult 
                              , HandleSearchResponse
                              , HandleSearchError
                              )
                        , OptionsMsg (..)
                        )

import Model as M

type Msg
    = SetQuery String
    | Options OptionsMsg
    | Search
    | RemoveResult Int
    | HandleSearchResponse (List M.SearchResult)
    | HandleSearchError (Maybe String)


type OptionsMsg
    = SetMinStars String
    | SetSearchIn String
    | SetUserFilter String

