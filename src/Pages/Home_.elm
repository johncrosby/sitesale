module Pages.Home_ exposing (view)

import Html exposing (Html, a, footer, li, p, text, ul)
import Html.Attributes exposing (href, style)
import UI
import View exposing (View)


view : View msg
view =
    { title = "Crosby Estates"
    , body =
        UI.layout
            [ Html.h1 [ style "padding" "0.5em 1em 0em 0.5em" ] [ Html.text "Crosby Estates" ]
            , Html.h3 [ style "padding" "1em" ] [ Html.text "Investment & development agents based in north London. Serving clients throughout London and UK" ]
            ]
    }


viewLink : String -> String -> Html msg
viewLink path name =
    Html.div [] [ a [ href path ] [ text name ] ]
