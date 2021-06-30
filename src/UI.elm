module UI exposing (layout)

import Gen.Route as Route exposing (Route)
import Html exposing (Html)
import Html.Attributes as Attr


layout : List (Html msg) -> List (Html msg)
layout children =
    let
        viewLink : String -> Route -> Html msg
        viewLink label route =
            Html.a [ Attr.href (Route.toHref route) ] [ Html.text label ]
    in
    [ Html.div [ Attr.class "container" ]
        [ Html.header [ Attr.class "navbar" ]
            [ viewLink "Home" Route.Home_
            , viewLink "For Sale" Route.ForSale
            , viewLink "Sold" Route.Sold
            , Html.div [ Attr.class "splitter" ] []
            , viewLink "Miranda Road" (Route.Properties__Name_ { name = "15-miranda-road-london-n19-3ra" })
            , viewLink "Hornsey Road" (Route.Properties__Name_ { name = "270-hornsey-road-london-n7-4bx" })
            ]
        , Html.main_ [] children
        ]
    ]
