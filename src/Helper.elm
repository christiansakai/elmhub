port module Helper exposing ( Model
                       , SearchOptions
                       , SearchResult
                       , initialModel
                       )

import Json.Decode as D
import Json.Decode.Pipeline as P
import Auth as A
import Model as M
import Update as U


-- responseDecoder : D.Decoder (List SearchResult)
-- responseDecoder =
--     Json.Decode.at [ "items" ] (Json.Decode.list searchResultDecoder)


-- searchResultDecoder : Decoder SearchResult
-- searchResultDecoder =
--     decode SearchResult
--         |> required "id" Json.Decode.int
--         |> required "full_name" Json.Decode.string
--         |> required "stargazers_count" Json.Decode.int


-- decodeGithubResponse : Json.Decode.Value -> Msg
-- decodeGithubResponse value =
--     case Json.Decode.decodeValue responseDecoder value of
--         Ok results ->
--             HandleSearchResponse results

--         Err err ->
--             HandleSearchError (Just err)


-- decodeResponse : Json.Decode.Value -> Msg
-- decodeResponse json =
--     case Json.Decode.decodeValue responseDecoder json of
--         Err err ->
--             HandleSearchError (Just err)

--         Ok results ->
--             HandleSearchResponse results


port githubSearch : String -> Cmd msg


port githubResponse : (D.Value -> msg) -> Sub msg


getQueryString : M.Model -> String
getQueryString model =
    -- See https://developer.github.com/v3/search/#example for how to customize!
    "access_token="
        ++ A.token
        ++ "&q="
        ++ model.query
        ++ "+in:"
        ++ model.options.searchIn
        ++ "+stars:>="
        ++ (toString model.options.minStars)
        ++ "+language:elm"
        ++ (if String.isEmpty model.options.userFilter then
                ""
            else
                "+user:" ++ model.options.userFilter
           )
