module Shared exposing
    ( Flags
    , Model
    , Msg
    , Status
    , forSale
    , init
    , sold
    , subscriptions
    , update
    , viewFeed
    )

import Gen.Route exposing (Route(..))
import Html exposing (Html, div, li, text, ul)
import Html.Attributes exposing (property)
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
    , name : String
    , price : Int
    , status : Status
    }


type Msg
    = NoOp


init : Request -> Flags -> ( Model, Cmd Msg )
init _ _ =
    ( { feed =
            Just
                [ { id = 1
                  , name = "Kentish Town"
                  , price = 1500
                  , status = Sold
                  }
                , { id = 2
                  , name = "Camden Town"
                  , price = 1500
                  , status = ForSale
                  }
                , { id = 3
                  , name = "Archway"
                  , price = 1500
                  , status = Sold
                  }
                ]
      }
    , Cmd.none
    )


viewDetailedProperty : Property -> Html msg
viewDetailedProperty property =
    li [] [ text (property.name ++ " " ++ String.fromInt property.price ++ " " ++ statusToString property.status) ]


viewFeed : Maybe Feed -> Status -> Html msg
viewFeed maybeFeed status =
    case maybeFeed of
        Just feed ->
            let
                myList =
                    List.filter (\record -> record.status == status) feed
            in
            div [] (List.map viewDetailedProperty myList)

        Nothing ->
            div [] [ text "Loading Feed..." ]


forSale : Model -> Html msg
forSale model =
    div []
        [ ul []
            [ viewFeed model.feed ForSale
            ]
        ]


sold : Model -> Html msg
sold model =
    div []
        [ ul []
            [ viewFeed model.feed Sold
            ]
        ]


update : Request -> Msg -> Model -> ( Model, Cmd Msg )
update _ msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


subscriptions : Request -> Model -> Sub Msg
subscriptions _ _ =
    Sub.none
