module Main exposing (..)

import Browser
import Element exposing (column, layout, padding, spacing)
import Html exposing (Html)
import UiBase.AircraftDetails exposing (aircraftDetailsColumn)
import UiBase.AircraftTypes exposing (AircraftType(..), GenericAircraftData, RelatedToAircraft, TypedAircraftData, TypedAircraftList)
import Vector3


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
        supermarine : GenericAircraftData
        supermarine =
            GenericAircraftData 0 "Supermarine" "" []

        spitfire : GenericAircraftData
        spitfire =
            GenericAircraftData 1 "Spitfire" "" []

        base : TypedAircraftData
        base =
            TypedAircraftData ManufacturerType supermarine

        someAircraft : TypedAircraftList
        someAircraft =
            TypedAircraftList AircraftType [ spitfire ]

        noVariants : TypedAircraftList
        noVariants =
            TypedAircraftList VariantType []

        noCommonNames : TypedAircraftList
        noCommonNames =
            TypedAircraftList CommonNameType []

        relatedLists : Vector3.Vector3 TypedAircraftList
        relatedLists =
            Vector3.from3 someAircraft noVariants noCommonNames

        relatedAircraftData : RelatedToAircraft
        relatedAircraftData =
            RelatedToAircraft base relatedLists
    in
    layout []
        (column [ padding 30, spacing 40 ]
            [ aircraftDetailsColumn SelectAircraft (Just relatedAircraftData)
            , aircraftDetailsColumn SelectAircraft Nothing
            ]
        )
