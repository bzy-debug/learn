module Main exposing (..)

import Browser
import Html exposing (Html, div, text, textarea)
import Html.Events exposing (onInput)


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { code : String
    }


init : Model
init =
    { code = ""
    }


type Msg
    = Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newCode ->
            { model | code = newCode }


view : Model -> Html Msg
view model =
    div []
        [ textarea [ onInput Change ] []
        , div [] [ text model.code ]
        ]
