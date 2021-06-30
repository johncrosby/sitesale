module Pages.Sold exposing (page)

import Gen.Params.Sold exposing (Params)
import Html
import Page exposing (Page)
import Request
import Shared
import UI
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page
page shared req =
    Page.static
        { view = view
        }


view : View msg
view =
    { title = "Sold"
    , body = UI.layout [ Html.h1 [] [ Html.text "Sold" ] ]
    }
