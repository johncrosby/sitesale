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



-- baseUrl : String
-- baseUrl =
--     "https://res.cloudinary.com/yonks/image/upload/"


init : Request -> Flags -> ( Model, Cmd Msg )
init _ _ =
    ( { feed =
            Just
                [ { id = 9
                  , link = "17-19-beethoven-street-north-kensington-london-w10-4lg"
                  , name = "Beethoven Street, London, W10."
                  , price = 1450000
                  , description = "A pair of freehold buildings to convert and extend with new-build development potential at the rear. Sold to Public Limited Company unconditionally."
                  , status = Sold
                  , image = "https://res.cloudinary.com/yonks/image/upload/c_scale,w_650/v1628429332/beethoven_street_wiwhrm.jpg"
                  }
                , { id = 8
                  , link = "28-elsdale-street-hackney-london-e9-6qy"
                  , name = "Elsdale Street, Hackney, London, E9."
                  , price = 1450000
                  , description = "Airspace development subject to planning permission fo 7 flats. Sold To RGK Properties."
                  , status = Sold
                  , image = "https://res.cloudinary.com/yonks/image/upload/c_scale,w_650/v1628427184/elsdale_street_dsbtd7.jpg"
                  }
                , { id = 7
                  , link = "59-61-palermo-road-kensal-green-london-nw10-5ys"
                  , name = "Palermo Road, Kensal Green, London, NW10."
                  , price = 1450000
                  , description = "Currently an MOT and car repair garage. The site is suitable for redevelopment and has been sold subject to planning consent to central London development company"
                  , status = Sold
                  , image = "https://res.cloudinary.com/yonks/image/upload/c_scale,w_650/v1628417841/palermo_road_ofl7oq.jpg"
                  }
                , { id = 6
                  , link = "270-282-hornsey-road-islington-london-n7-7qz"
                  , name = "Hornsey Road, Islington, London, N7."
                  , price = 1750000
                  , description = "Hornsey Road development site. Income producing investment let to NHS with future development potential while retaining doctors surgery. Sold unconditionally to north London developers."
                  , status = Sold
                  , image = "https://res.cloudinary.com/yonks/image/upload/c_scale,w_650/v1628420935/hornsey_road_endil8.jpg"
                  }
                , { id = 5
                  , link = "1a-highgate-road-kentish-town-london-nw5-1jy"
                  , name = "Highgate Road, Kentish Town, London, NW5."
                  , price = 2000000
                  , description = "An old piano warehouse with failed planning application for five houses. Sold unconditionally to north London developers."
                  , status = Sold
                  , image = "https://res.cloudinary.com/yonks/image/upload/c_scale,w_650/v1628422851/highgate_road_i29prt.jpg"
                  }
                , { id = 4
                  , link = "13-15-tollington-way-islington-london-n7-6rg"
                  , name = "Tollington Way, Islington, London N7."
                  , price = 3000000
                  , description = "Existing investment of 5 flats, workshop and shop uniit. With refurb / development and change of use potential."
                  , status = ForSale
                  , image = "https://res.cloudinary.com/yonks/image/upload/c_scale,h_488,w_650/v1627642637/ab_sjwott.jpg"
                  }
                , { id = 3
                  , link = "79-evershot-road-islington-london-n4-3df"
                  , name = "Evershot Road, Islington, London N4."
                  , price = 1000000
                  , description = "Existing office and yard with residential development potential"
                  , status = ForSale
                  , image = "https://res.cloudinary.com/yonks/image/upload/c_scale,w_650/v1628425410/evershot_road.jpg_ruobuo.jpg"
                  }
                , { id = 2
                  , link = "9-11-elm-road-collier-row-romford-rm7-8hh"
                  , name = "Elm road, Collier Row, Romford, RM7."
                  , price = 350000
                  , description = "Backlands consisting of 25 garages with residential development potential. Sold to private developer. Planning consent was subsequently approved on appeal for seven houses."
                  , status = Sold
                  , image = "https://res.cloudinary.com/yonks/image/upload/c_scale,w_650/v1628423751/elm_road_w5ec0r.jpg"
                  }
                , { id = 1
                  , link = "rear-of-83-christchurch-road-london-sw2-3dh"
                  , name = "Christchurch Road, Streatham, London, SW2."
                  , price = 600000
                  , description = "Rear garden facing road side with failed planning application for 7 flats. Sold unconditionally to private developer and subsequently obtained planning permission for five houses."
                  , status = Sold
                  , image = "https://res.cloudinary.com/yonks/image/upload/c_scale,w_650/v1628424456/christchurch_road_owrbn2.jpg"
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
    div [ Attr.class "this" ]
        [ Html.h1 [] [ text property.name ]
        , Html.h2 [] [ text ("Status: " ++ statusToString property.status) ]
        , Html.p [ Attr.class "description" ] [ text property.description ]
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
            div [ Attr.class "details" ] (List.map viewDetailedItem myList)

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
        viewItem model.feed path

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
