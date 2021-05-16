module Main exposing (..)

import Browser
import Date exposing (Date)
import Element exposing (column, layout, padding, spacing)
import Html exposing (Html)
import Time exposing (Month(..))
import UiBase.AircraftDetails exposing (aircraftDetailsColumn)
import UiBase.AircraftTypes exposing (AircraftType(..), GenericAircraftData, RelatedToAircraft, RelatedToSearch, TypedAircraftData, TypedAircraftList)
import UiBase.Product exposing (Product, SortDescription, SortDirection(..))
import UiBase.ProductTable exposing (productTable)
import UiBase.SearchResults exposing (searchAircraftList)
import Vector3
import Vector4


main =
    Browser.sandbox { init = init, update = update, view = view }


type Msg
    = SelectAircraft TypedAircraftData
    | ToggleSort String (Product -> String)
    | DisplayImage Int


type alias Model =
    { message : String }


init : Model
init =
    { message = "Hello World" }


update : Msg -> Model -> Model
update msg model =
    case msg of
        _ ->
            model


view : Model -> Html Msg
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

        noManufacturers : TypedAircraftList
        noManufacturers =
            TypedAircraftList ManufacturerType []

        someAircraft : TypedAircraftList
        someAircraft =
            TypedAircraftList AircraftType [ spitfire ]

        noVariants : TypedAircraftList
        noVariants =
            TypedAircraftList VariantType []

        noCommonNames : TypedAircraftList
        noCommonNames =
            TypedAircraftList CommonNameType []

        relatedToManufacturerLists : Vector3.Vector3 TypedAircraftList
        relatedToManufacturerLists =
            Vector3.from3 someAircraft noVariants noCommonNames

        relatedToSearchLists : Vector4.Vector4 TypedAircraftList
        relatedToSearchLists =
            Vector4.from4 noManufacturers someAircraft noVariants noCommonNames

        relatedAircraftData : RelatedToAircraft
        relatedAircraftData =
            RelatedToAircraft base relatedToManufacturerLists

        relatedSearchData : RelatedToSearch
        relatedSearchData =
            RelatedToSearch relatedToSearchLists

        sortDescription : SortDescription
        sortDescription =
            SortDescription "Description" .description Ascending
    in
    layout []
        (column [ padding 30, spacing 40 ]
            [ searchAircraftList SelectAircraft (Just relatedSearchData)
            , aircraftDetailsColumn SelectAircraft (Just relatedAircraftData)
            , aircraftDetailsColumn SelectAircraft Nothing
            , productTable ToggleSort DisplayImage currentDate sortDescription products
            ]
        )


currentDate =
    Date.fromCalendarDate 1 Jan 2001


products : List Product
products =
    let
        product : Product
        product =
            { id = 1
            , source = "Hannants"
            , manufacturer = "Eduard"
            , product_code = "P00001"
            , description = "Eduard Spitfire"
            , scale = "1:72"
            , category = "Kit"
            , url = "https://www.hannants.co.uk/"
            , image_url = Nothing
            , price = "475,21 Kč"
            , display_short_description = False
            , indexed = True
            , first_seen = currentDate
            , last_price_update = currentDate
            }
    in
    [ product ]
