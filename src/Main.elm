module Main exposing (..)

import Browser
import Element exposing (layout)
import Html exposing (Html)
import UiBase.AircraftDetails exposing (aircraftDetailsColumn)
import UiBase.AircraftTypes exposing (TypedAircraftData)


main =
    Browser.sandbox { init = Nothing, update = update, view = view }


type Msg
    = SelectAircraft TypedAircraftData


update : Msg -> Maybe TypedAircraftData -> Maybe TypedAircraftData
update msg model =
    case msg of
        SelectAircraft _ ->
            model


view : Maybe TypedAircraftData -> Html Msg
view _ =
    let
        data =
            Nothing
    in
    --  aircraftDetailsColumn : (TypedAircraftData -> msg) -> Maybe RelatedToAircraft -> Element msg
    layout [] (aircraftDetailsColumn SelectAircraft data)
