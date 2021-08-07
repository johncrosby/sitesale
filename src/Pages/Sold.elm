module Pages.Sold exposing (page)

import Gen.Params.Sold exposing (Params)
import Gen.Route as Route exposing (Route)
import Html
import Html.Attributes as Attr
import Page exposing (Page)
import Request
import Shared
import UI
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page
page shared _ =
    Page.static
        { view = view shared
        }


view shared =
    { title = "Crosby Estates | Sold"
    , body =
        UI.layout
            [ Shared.sold shared
            ]
    }
