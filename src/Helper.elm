port module Helper exposing ( getQueryString
                            , githubSearch
                            , githubResponse
                            , decodeResponse
                            )

import Json.Decode as D
import Json.Decode.Pipeline as P
import Auth as A
import Model as M
import Message as Ms


port githubSearch : String -> Cmd msg


getQueryString : M.Model -> String
getQueryString model =
    -- See https://developer.github.com/v3/search/#example 
    -- for how to customize!
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


port githubResponse : (D.Value -> msg) -> Sub msg


decodeResponse : D.Value -> Ms.Msg
decodeResponse json =
  case D.decodeValue responseDecoder json of
    Ok results ->
      Ms.HandleSearchResponse results

    Err err ->
      Ms.HandleSearchError (Just err)


responseDecoder : D.Decoder (List M.SearchResult)
responseDecoder =
  D.at [ "items" ] (D.list searchResultDecoder)


searchResultDecoder : D.Decoder M.SearchResult
searchResultDecoder =
  P.decode M.SearchResult
    |> P.required "id" D.int
    |> P.required "full_name" D.string
    |> P.required "stargazers_count" D.int
