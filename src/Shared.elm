module Shared exposing
    ( Flags
    , Model
    , Msg
    , init
    , subscriptions
    , update
    , view
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



-- viewStatusList


viewDetailedProperty : Property -> Html msg
viewDetailedProperty property =
    li [] [ text (property.name ++ " " ++ String.fromInt property.price ++ " " ++ statusToString property.status) ]


viewFeed : Maybe Feed -> Html msg
viewFeed maybeFeed =
    case maybeFeed of
        Just feed ->
            div [] (List.map viewDetailedProperty feed)

        Nothing ->
            div [] [ text "Loading Feed..." ]


view : Model -> Html msg
view model =
    div []
        [ ul []
            [ viewFeed model.feed
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
