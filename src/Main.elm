module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Material.List as List
import Material.List.Item as ListItem


type alias Model =
    { listElements : List String
    }


init : {} -> ( Model, Cmd Msg )
init _ =
    ( { listElements = [] }, Cmd.none )


type Msg
    = AddElement


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        AddElement ->
            ( { model | listElements = model.listElements ++ [ "element" ] }, Cmd.none )


view : Model -> Html Msg
view model =
    let
        itemConfig =
            ListItem.config
                |> ListItem.setAttributes [ class "autocomplete-option", class "autocomplete-selected" ]

        data =
            model.listElements
    in
    div [ class "container" ]
        [ h1 [] [ text "Repro" ]
        , p [] [ text "Try clicking 'Add element' to add an element to the Material Design list, and it will break" ]
        , button [ onClick AddElement ] [ text "Add element" ]
        , data
            |> List.indexedMap
                (\i item ->
                    ListItem.listItem itemConfig
                        [ text <| String.fromInt i ++ " " ++ item ]
                )
            |> List.list List.config
        ]


main : Program {} Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , view =
            \m ->
                { title = "MCWE bug?"
                , body = [ view m ]
                }
        , subscriptions = \_ -> Sub.none
        }
