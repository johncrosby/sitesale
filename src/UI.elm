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
            ]
        , Html.main_ [] children
        , Html.footer [ Attr.class "footer" ] [ Html.text "Crosby Estates, 2a Fairbridge Road, London, N19 3HZ" ]
        ]
    ]
