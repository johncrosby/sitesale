module Pages.ForSale exposing (page)

-- import Gen.Route
-- import Gen.Params.Static exposing (Params)

import Gen.Params.ForSale exposing (Params)
import Html
import Html.Attributes exposing (href, style)
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
            [ Html.div [ style "padding" "0em 1em 0em 1em" ]
                [ Html.h1
                    [ style "padding" "0.5em 0em 0.5em 1em"
                    , style "background-color" "white"
                    ]
                    [ Html.text "Crosby Estates - For Sale" ]
                ]
            , Shared.forSale shared
            ]
    }
