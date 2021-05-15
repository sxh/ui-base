module Main exposing (..)

import Browser
import Date exposing (Date)
import Element exposing (column, layout, padding, spacing)
import Html exposing (Html)
import Time exposing (Month(..))
import UiBase.AircraftDetails exposing (aircraftDetailsColumn)
import UiBase.AircraftTypes exposing (AircraftType(..), GenericAircraftData, RelatedToAircraft, TypedAircraftData, TypedAircraftList)
import UiBase.Product exposing (Product, SortDescription, SortDirection(..))
import UiBase.ProductTable exposing (productTable)
import Vector3


main =
    Browser.sandbox { init = init, update = update, view = view }


type Msg
    = SelectAircraft TypedAircraftData
    | ToggleSort String (Product -> String)
    | DisplayImage Int


type alias Model =
    { currentDate : Date }


init : Model
init =
    { currentDate = Date.fromCalendarDate 1 Jan 2001 }


update : Msg -> Model -> Model
update msg model =
    case msg of
        _ ->
            model


view : Model -> Html Msg
view model =
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

        sortDescription : SortDescription
        sortDescription =
            SortDescription "Description" .description Ascending

        products =
            []
    in
    layout []
        (column [ padding 30, spacing 40 ]
            [ aircraftDetailsColumn SelectAircraft (Just relatedAircraftData)
            , aircraftDetailsColumn SelectAircraft Nothing
            , productTable ToggleSort DisplayImage model.currentDate sortDescription products
            ]
        )
