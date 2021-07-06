module Pages.ForSale exposing (page)

import Gen.Params.Static exposing (Params)
import Gen.Route
import Html
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
    { title = "For Sale"
    , body =
        UI.layout
            [ Html.h1 [] [ Html.text "For Sale" ]
            , Html.div [] [ Shared.forSale shared ]
            ]
    }
