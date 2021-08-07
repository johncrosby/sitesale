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
    , viewPropertyList
    , viewPropertyListFeed
    )

-- import Html.Attributes exposing (property)
-- import Gen.Route.Properties.Name_ as Route

import FormatNumber exposing (format)
import FormatNumber.Locales exposing (Decimals(..), Locale, base, usLocale)
import Gen.Params.Properties.Name_ exposing (Params)
import Html exposing (Html, a, div, h5, li, p, pre, text, ul)
import Html.Attributes as Attr exposing (class, property, src)
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
    , image : String
    }


type Msg
    = NoOp


baseUrl : String
baseUrl =
    "https://res.cloudinary.com/yonks/image/upload/"


init : Request -> Flags -> ( Model, Cmd Msg )
init _ _ =
    ( { feed =
            Just
                [ { id = 1
                  , link = "59-61-palermo-road-kensal-green-london-nw10-5ys"
                  , name = "59-61 Palermo Road, Kensal Green, London, NW10 5YS"
                  , price = 1450000
                  , description = "Currently an MOT and car repair garage. The site is suitable for redevelopment and has been sold to Fruition Properties"
                  , status = Sold
                  , image = baseUrl ++ "c_scale,w_650/v1627642642/b_akc6fk.jpg"
                  }
                , { id = 2
                  , link = "270-282-hornsey-road-islington-london-n7-7qz"
                  , name = "270-282 Hornsey Road, Islington, London, N7 7QZ"
                  , price = 1750000
                  , description = "Hornsey Road development site"
                  , status = Sold
                  , image = baseUrl ++ "c_scale,w_650/v1627642644/f_vojd4w.jpg"
                  }
                , { id = 3
                  , link = "1a-highgate-road-kentish-town-london-nw5-1jy"
                  , name = "1A Highgate Road, Kentish Town, London NW5 1JY"
                  , price = 2000000
                  , description = "An old piano warehouse"
                  , status = ForSale
                  , image = baseUrl ++ "c_scale,w_650/v1627642643/c_wfvuyx.jpg"
                  }
                , { id = 4
                  , link = "13-15-tollington-way-islington-london-n7-6rg"
                  , name = "13-15 Tollington Way, Islington, London N7 6RG"
                  , price = 3000000
                  , description = "Existing investment of 5 flats, workshop and shop uniit. With refurb / development and change of use potential."
                  , status = ForSale
                  , image = baseUrl ++ "c_scale,h_488,w_650/v1627642637/ab_sjwott.jpg"
                  }
                , { id = 5
                  , link = "79-evershot-road-islington-london-n4-3df"
                  , name = "79 Evershot Road, Islington, London N4 3DF"
                  , price = 1000000
                  , description = "Existing office and yard with residential development potential"
                  , status = ForSale
                  , image = baseUrl ++ "c_scale,w_650/v1627642642/b_akc6fk.jpg"
                  }
                , { id = 6
                  , link = "9-11-elm-road-collier-row-romford-rm7-8hh"
                  , name = "9-11 Elm road, Collier Row, RM7 8HH"
                  , price = 350000
                  , description = "Backlands consisting of 25 garages with residential development potential"
                  , status = Sold
                  , image = baseUrl ++ "c_scale,w_650/v1627642642/b_akc6fk.jpg"
                  }
                , { id = 6
                  , link = "rear-of-83-christchurch-road-london-sw2-3dh"
                  , name = "Rear of 83 Christchurch Road, London, SW2 3DH"
                  , price = 600000
                  , description = "Rear garden facing road side with failed planning application for 7 flats."
                  , status = Sold
                  , image = baseUrl ++ "c_scale,w_650/v1627642642/b_akc6fk.jpg"
                  }
                ]
      }
    , Cmd.none
    )


{--}
viewPropertyList : Property -> Html msg
viewPropertyList property =
    div [ Attr.class "items" ]
        [ Html.a [ Attr.href ("/properties/" ++ property.link), Attr.class "box box2" ]
            [ Html.img [ src property.image ] []
            , Html.p [] [ text (property.name ++ " £" ++ format { usLocale | decimals = Exact 0 } (toFloat property.price) ++ " " ++ statusToString property.status ++ " " ++ property.description) ]
            ]
        ]
--}


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
    div [ Attr.class "details" ]
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
    viewPropertyListFeed model.feed ForSale


sold : Model -> Html msg
sold model =
    viewPropertyListFeed model.feed Sold


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
