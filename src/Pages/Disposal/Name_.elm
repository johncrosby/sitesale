module Pages.Disposal.Name_ exposing (page)

import Gen.Params.Disposal.Name_ exposing (Params)
import Html
import Page exposing (Page)
import Request
import Shared
import String.Case exposing (convertCase)
import UI
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page
page shared req =
    Page.static
        { view = view shared req
        }


view : Shared.Model -> Request.With Params -> View msg
view shared req =
    { title = "SiteSale | " ++ req.params.name
    , body =
        UI.layout
            [ Html.h1 [] [ Html.text ("Selling land in " ++ convertCase " " True True req.params.name ++ " " ++ "?") ]
            , Html.h3 [] [ Html.text "We can help you with the following options:" ]
            , Html.ol []
                [ Html.li [] [ Html.text "Sell unconditionally (without planning permission)." ]
                , Html.li [] [ Html.text "Sell with planning (where planning consent has already been obtained)." ]
                , Html.li [] [ Html.text "Sell subject to planning (Normally the buyer will obtain and pay for the planning application at their risk)." ]
                , Html.li [] [ Html.text "Partner with a developer as a joint venture." ]
                , Html.li [] [ Html.text "Pre sell units before construction begins" ]
                ]
            , Html.hr [] []
            , Html.h4 [] [ Html.text "Some case studies:" ]
            , Html.div [] [ Shared.sold shared ]
            ]
    }



{--
view : View msg
view =
    View.placeholder "Disposal.Name_"
--}
