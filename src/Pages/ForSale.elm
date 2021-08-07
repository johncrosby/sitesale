module Pages.ForSale exposing (page)

-- import Gen.Route
-- import Gen.Params.Static exposing (Params)

import Gen.Params.ForSale exposing (Params)
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
    { title = "Crosby Estates | For Sale"
    , body =
        UI.layout
            [ Shared.forSale shared
            ]
    }
