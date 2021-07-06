module Pages.Properties.Name_ exposing (page)

-- import Gen.Route

import Gen.Params.Properties.Name_ exposing (Params)
import Html exposing (Html, div, param, text)
import Html.Attributes exposing (property)
import Page exposing (Page)
import Request exposing (Request)
import Shared exposing (Msg, Property, fetchData)
import UI
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page
page shared req =
    Page.static
        { view = view shared req
        }



-- boolToString : Bool -> String
-- boolToString bool =
--     if bool == True then
--         "True"
--     else
--         "False"


view : Shared.Model -> Request.With Params -> View msg
view shared req =
    { title = req.params.name
    , body =
        UI.layout
            -- [ Html.h1 [] [ Html.text "Property Details:" ]
            [ Html.div [] [ fetchData req.params.name shared ]
            ]
    }
