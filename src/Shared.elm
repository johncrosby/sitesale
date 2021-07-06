module Shared exposing
    ( Flags
    , Model
    , Msg
    , Property
    , Status
    , fetchData
    , forSale
    , init
    , sold
    , subscriptions
    , update
    , viewDetailedItem
    , viewItem
    , viewPropertyListFeed
    )

-- import Html.Attributes exposing (property)
-- import Gen.Route.Properties.Name_ as Route

import FormatNumber exposing (format)
import FormatNumber.Locales exposing (Decimals(..), Locale, usLocale)
import Gen.Params.Properties.Name_ exposing (Params)
import Html exposing (Html, div, li, text, ul)
import Html.Attributes as Attr exposing (property)
import Json.Decode as Json
import Request exposing (Request)


type alias Flags =
    Json.Value


type Status
    = ForSale
    | Sold


statusToString : Status -> String
statusToString status =
    case status of
        ForSale ->
            "For Sale"

        Sold ->
            "Sold"


type alias Id =
    Int


type alias Feed =
    List Property


type alias Model =
    { feed : Maybe Feed }


type alias Property =
    { id : Id
    , link : String
    , name : String
    , price : Int
    , description : String
    , status : Status
    }


type Msg
    = NoOp


init : Request -> Flags -> ( Model, Cmd Msg )
init _ _ =
    ( { feed =
            Just
                [ { id = 1
                  , link = "59-61-palermo-road-kensal-green-london-nw10-5ys"
                  , name = "59-61 Palermo Road, Kensal Green, London, NW10 5YS"
                  , price = 1750000
                  , description = "Palermo Road is great!"
                  , status = Sold
                  }
                , { id = 2
                  , link = "270-282-hornsey-road-islington-london-n7-7qz"
                  , name = "270-282 Hornsey Road, Islington, London, N7 7QZ"
                  , price = 2500000
                  , description = "Hornsey Road development site"
                  , status = Sold
                  }
                , { id = 3
                  , link = "1a-highgate-road-kentish-town-london-nw5-1jy"
                  , name = "1A Highgate Road, Kentish Town, London NW5 1JY"
                  , price = 800000
                  , description = "An old piano warehouse"
                  , status = Sold
                  }
                , { id = 4
                  , link = "13-15-tollington-way-islington-london-n7-6rg"
                  , name = "13-15 Tollington Way, Islington, London N7 6RG"
                  , price = 750000
                  , description = "Shes a nightmare!"
                  , status = ForSale
                  }
                , { id = 5
                  , link = "79-evershot-road-sslington-london-n4-3df"
                  , name = "79 Evershot Road, Islington, London N4 3DF"
                  , price = 1350000
                  , description = "Currently has cars parked"
                  , status = ForSale
                  }
                ]
      }
    , Cmd.none
    )



{--
format : Locale -> Float -> String
format { decimals = Exact 2, thousandSeparator = ".", decimalSeparator = ",", negativePrefix = "−", negativeSuffix = "", positivePrefix = "", positiveSuffix = "", zeroPrefix = "", zeroSuffix = "" } 123456.789
--}


viewPropertyList : Property -> Html msg
viewPropertyList property =
    li [] [ Html.a [ Attr.href ("/properties/" ++ property.link) ] [ text (property.name ++ " £" ++ format { usLocale | decimals = Exact 0 } (toFloat property.price)) ] ]



-- format (Locale (Exact 0) "," "." "−" "" "" "" "" "") 1e9


viewPropertyListFeed : Maybe Feed -> Status -> Html msg
viewPropertyListFeed maybeFeed status =
    case maybeFeed of
        Just feed ->
            let
                myList =
                    List.filter (\record -> record.status == status) feed
            in
            div [] (List.map viewPropertyList myList)

        Nothing ->
            div [] [ text "Loading Feed..." ]


{--}
viewDetailedItem : Property -> Html msg
viewDetailedItem property =
    div []
        [ Html.h1 [] [ text property.name ]
        , Html.h2 [] [ text ("Status: " ++ statusToString property.status) ]
        , Html.p [] [ text property.description ]
        ]
--}


{--}
viewItem : Maybe Feed -> String -> Html msg
viewItem maybeFeed link =
    case maybeFeed of
        Just feed ->
            let
                myList =
                    List.filter (\record -> record.link == link) feed
            in
            div [] (List.map viewDetailedItem myList)

        Nothing ->
            div [] [ text "Loading item..." ]
--}


forSale : Model -> Html msg
forSale model =
    div []
        [ ul []
            [ viewPropertyListFeed model.feed ForSale
            ]
        ]


sold : Model -> Html msg
sold model =
    div []
        [ ul []
            [ viewPropertyListFeed model.feed Sold
            ]
        ]


{--}
pathList : Maybe Feed -> List String
pathList maybeFeed =
    case maybeFeed of
        Just feed ->
            List.map (\record -> record.link) feed

        Nothing ->
            []
--}


{--}
fetchData : String -> Model -> Html msg
fetchData path model =
    if List.member path (pathList model.feed) then
        Html.div [] [ viewItem model.feed path ]

    else
        Html.text "Invalid page"
--}


update : Request -> Msg -> Model -> ( Model, Cmd Msg )
update _ msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


subscriptions : Request -> Model -> Sub Msg
subscriptions _ _ =
    Sub.none
