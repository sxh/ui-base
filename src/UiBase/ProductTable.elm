module UiBase.ProductTable exposing (productTable)

{-| Provide a consistent Product table experience


# Table

@docs productTable

-}

import Colors.Opaque exposing (cornflowerblue, skyblue, white)
import Date exposing (Date, Unit(..))
import Element exposing (Attribute, Color, Element, IndexedColumn, centerY, el, fill, fillPortion, height, htmlAttribute, image, link, maximum, mouseOver, none, padding, paddingEach, paragraph, px, row, shrink, spacing, text, width)
import Element.Background as Background
import Element.Events exposing (onClick)
import Element.Font as Font
import Html.Attributes exposing (name)
import Maybe exposing (withDefault)
import UiBase.Product exposing (Product, SortDescription, SortDirection(..), sortDirection)
import UiBase.Sizes exposing (largeFontSize, normalFontSize)
import UiBase.SvgExtensions exposing (downArrow, upArrow)


{-| The overall table
-}
productTable : (String.String -> (Product -> String.String) -> msg) -> (Int -> msg) -> Date -> SortDescription -> List Product -> Element msg
productTable toggleSort setDisplayImage currentDate sortDescription products =
    Element.indexedTable [ width fill, spacing 2 ]
        { data = products
        , columns =
            [ textColumn toggleSort 3 (productTextToLink .source) "Source" .source sortDescription
            , textColumn toggleSort 3 (productTextToLink .manufacturer) "Manufacturer" .manufacturer sortDescription
            , textColumn toggleSort 3 (productTextToLink .product_code) "Code" .product_code sortDescription
            , textColumn toggleSort 16 (productTableDescriptionElement currentDate) "Description" .description sortDescription
            , textColumn toggleSort 1 (productTextToLink .scale) "Scale" .scale sortDescription
            , textColumn toggleSort 1 (productTextToLink .price) "Price" .price sortDescription
            , textColumn toggleSort 4 (productTextToLink .category) "Category" .category sortDescription
            , productColumn 4 (columnHeading [] (text "Image")) (imageCell setDisplayImage .image_url)
            ]
        }


{-| Single column heading
-}
columnHeading : List (Attribute msg) -> Element msg -> Element msg
columnHeading attributes heading =
    let
        commonAttributes =
            [ Font.heavy, largeFontSize, paddingEach { left = 4, right = 4, top = 15, bottom = 10 } ]
    in
    el (commonAttributes ++ attributes) heading


{-| Image cell, contains thumbnail of image
-}
imageCell : (Int -> msg) -> (Product -> Maybe String) -> Product -> Element msg
imageCell setDisplayImage selector product =
    let
        maxImageSize =
            150

        attributes =
            [ width (fill |> maximum maxImageSize)
            , height (fill |> maximum maxImageSize)
            , onClick (setDisplayImage product.id)
            ]

        idString =
            String.fromInt product.id
    in
    product
        |> selector
        |> Maybe.map
            (\url ->
                link [ htmlAttribute (name idString) ]
                    { url = "#" ++ idString, label = image attributes { src = url, description = "Product image" } }
            )
        |> withDefault none


{-| Link to the source page for the product
-}
productTextToLink : (Product -> String) -> Product -> Element msg
productTextToLink selector product =
    product
        |> selector
        |> text
        |> (\text -> link [ mouseOver [ Font.color cornflowerblue ] ] { url = product.url, label = text })


{-| Single text cell
-}
textCell : (Product -> Element msg) -> Product -> Element msg
textCell contentBuilder product =
    product
        |> contentBuilder
        |> (\x -> paragraph [ normalFontSize ] [ x ])


{-| Single column
-}
productColumn : Int -> Element msg -> (Product -> Element msg) -> IndexedColumn Product msg
productColumn proportion headerContent cellContent =
    { header = headerContent
    , width = fillPortion proportion
    , view =
        \index product ->
            cellContent product
                |> el [ centerY ]
                |> el [ height fill, Background.color (productRowColour index), padding 8 ]
    }


{-| Rows have alternating colours
-}
productRowColour : Int -> Color
productRowColour rowNumber =
    case modBy 2 rowNumber of
        0 ->
            skyblue

        _ ->
            white


{-| Description cell
-}
productTableDescriptionElement : Date -> Product -> Element msg
productTableDescriptionElement currentDate product =
    let
        newIconSize =
            25

        i =
            image
                [ width (px newIconSize), height (px newIconSize) ]
                { src = "./new.png", description = "New" }
    in
    case Date.compare product.first_seen (Date.add Months -1 currentDate) of
        GT ->
            row [ height shrink ] [ i, productTextToLink .description product ]

        _ ->
            productTextToLink .description product


{-| Single text column
-}
textColumn : (String.String -> (Product -> String.String) -> msg) -> Int -> (Product -> Element msg) -> String -> (Product -> String) -> SortDescription -> IndexedColumn Product msg
textColumn toggleSort proportion contentBuilder headingText accessor sortDescription =
    let
        sortIndicator : Element msg
        sortIndicator =
            case sortDirection headingText sortDescription of
                Ascending ->
                    upArrow

                Descending ->
                    downArrow

                Unsorted ->
                    none
    in
    productColumn proportion
        (columnHeading
            [ onClick (toggleSort headingText accessor) ]
            (row [ spacing 5 ] [ text headingText, sortIndicator ])
        )
        (textCell contentBuilder)
