module Main exposing (..)

import Browser
import Date exposing (Date)
import Dict exposing (Dict, get, insert)
import Element exposing (column, layout, padding, spacing)
import Html exposing (Html)
import Maybe exposing (withDefault)
import Time exposing (Month(..))
import UiBase.AircraftDetails exposing (aircraftDetailsColumn)
import UiBase.AircraftTypes exposing (AircraftType(..), GenericAircraftData, RelatedToAircraft, RelatedToSearch, TypedAircraftData, TypedAircraftList)
import UiBase.Help exposing (HelpControl)
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
    | ToggleTip String Bool


type alias Model =
    { message : String, toolTipsOpen : Dict String Bool }


init : Model
init =
    { message = "Hello World", toolTipsOpen = Dict.empty |> insert "Source" False }


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleTip key value ->
            { model | toolTipsOpen = model.toolTipsOpen |> insert key value }

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

        productTableSorting =
            { toggleSort = ToggleSort
            , sortDescription = sortDescription
            }

        productTableDescription =
            { sorting = productTableSorting
            , setDisplayImage = DisplayImage
            , currentDate = currentDate
            , sourceHelpControl = Just (helpControl "Source" model)
            , imageHelpControl = Nothing
            }
    in
    layout []
        (column [ padding 30, spacing 40 ]
            [ searchAircraftList SelectAircraft (Just relatedSearchData)
            , aircraftDetailsColumn SelectAircraft (Just relatedAircraftData)
            , aircraftDetailsColumn SelectAircraft Nothing
            , productTable productTableDescription products
            ]
        )


helpControl : String -> { a | toolTipsOpen : Dict String Bool } -> HelpControl Msg
helpControl key model =
    HelpControl
        (ToggleTip key)
        (model.toolTipsOpen
            |> get key
            |> withDefault False
        )


currentDate =
    Date.fromCalendarDate 2021 Jan 1


products : List Product
products =
    let
        product : Product
        product =
            { id = 1
            , source = "Hannants"
            , manufacturer = "Eduard"
            , product_code = "P00001"

            -- use a very long description to test wrapping
            , description = "History of RAF 19 Sqn 1935 - 91 (8) Gloster Gauntlet Mk.I K4095 Duxford 1935; North-American P-51B Mustang III FZ164 QV-V 'Wilf' Flt.Lt. T.H.Drinkwater RAF Gravesend 1944; Supermarine Spitfire Mk.XVIe TE470 QV-B RAF Biggin Hill 1946; de Havilland Hornet F.1 PX284/H RAF Linton-0n-Ouse 1946; Gloster Meteor F.8 WE863 Coronation Review RAF Odiham 1953; Hawker Hunter F.6 XG152/X RAF Church Fenton 1958; McDonnell-Douglas FGR.2 Phantom XV474/F RAF Wildenrath at Jubilee Review RAF Finningley 1977 green/grey camouflage; McDonnell-Douglas FGR.2 Phantom XV419/AA RAF Wildenrath 1991 Camouflaged Grey with Blue fin."
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
