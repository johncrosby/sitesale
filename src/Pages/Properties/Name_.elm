module Pages.Properties.Name_ exposing (page)

import Gen.Params.Dynamic.Name_ exposing (Params)
import Html exposing (Html)
import Page exposing (Page)
import Request
import Shared
import UI
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page
page shared req =
    Page.static
        { view = view shared req.params
        }


view : Shared.Model -> Params -> View msg
view shared params =
    { title = "Dynamic: " ++ params.name
    , body =
        UI.layout
            [ Html.h1 [] [ Html.text "Dynamic Page" ]
            , Html.h2 [] [ Html.text params.name ]
            , Html.div [] [ Shared.sold shared ]
            ]
    }
