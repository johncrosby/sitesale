module UI exposing (layout)

import Gen.Route as Route exposing (Route)
import Html exposing (Html)
import Html.Attributes as Attr
import Shared exposing (viewPropertyList, viewPropertyListFeed)


layout : List (Html msg) -> List (Html msg)
layout children =
    let
        viewLink : String -> Route -> Html msg
        viewLink label route =
            -- Html.a [ Attr.href (Route.toHref route) ] [ Html.text label ]
            Html.li [] [ Html.a [ Attr.href (Route.toHref route) ] [ Html.text label ] ]
    in
    [ Html.div [ Attr.class "wrapper" ]
        [ Html.div [ Attr.class "box box1" ]
            [ Html.ul []
                -- [ Html.ul [ Attr.class "navbar" ]
                [ viewLink "Home" Route.Home_
                , viewLink "For Sale" Route.ForSale
                , viewLink "Sold" Route.Sold
                ]
            ]
        , Html.main_ [ Attr.class "container" ] children
        , Html.footer [ Attr.class "box box3" ] [ Html.text "Crosby Estates, 2a Fairbridge Road, London, N19 3HZ. Tel: 020 8895 6456" ]
        ]
    ]
