module Subscriptions exposing ( subscriptions )

import Model as M
import Helper as H
import Message as Ms

subscriptions : M.Model -> Sub Ms.Msg
subscriptions _ =
    H.githubResponse H.decodeResponse
