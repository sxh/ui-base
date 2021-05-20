module UiBase.ProductTable exposing (productTable)

{-| Provide a consistent Product table experience


# Table

@docs productTable

-}

import Colors.Opaque exposing (cornflowerblue, skyblue, white)
import Date exposing (Date, Unit(..))
import Element exposing (Attribute, Color, Element, IndexedColumn, centerX, centerY, column, el, fill, fillPortion, height, htmlAttribute, image, link, maximum, mouseOver, none, padding, paddingEach, paragraph, px, row, shrink, spacing, text, width)
import Element.Background as Background
import Element.Events exposing (onClick)
import Element.Font as Font
import Html.Attributes exposing (name)
import Maybe exposing (withDefault)
import String exposing (replace)
import UiBase.FontSizes exposing (largeFontSize, normalFontSize)
import UiBase.Product exposing (Product, SortDescription, SortDirection(..), sortDirection)
import UiBase.SvgExtensions exposing (downArrow, upArrow)


type alias ProductColumnDescription msg =
    { proportion : Int
    , heading : Element msg
    , cellContent : Product -> Element msg
    }


{-| The overall table
-}
productTable : (String -> (Product -> String) -> msg) -> (Int -> msg) -> Date -> SortDescription -> List Product -> Element msg
productTable toggleSort setDisplayImage currentDate sortDescription products =
    let
        textColumnDescription :
            Int
            -> String.String
            -> (Product -> String.String)
            -> (Product -> Element msg)
            -> ProductColumnDescription msg
        textColumnDescription proportion headingText accessor contentBuilder =
            let
                sortableTextColumnHeading : Element msg
                sortableTextColumnHeading =
                    columnHeading
                        [ onClick (toggleSort headingText accessor) ]
                        (row [ spacing 5 ]
                            [ text headingText
                            , sortIndicator headingText sortDescription
                            , text "toggle"
                            ]
                        )
            in
            ProductColumnDescription proportion sortableTextColumnHeading (textCell contentBuilder)
    in
    Element.indexedTable [ width fill, spacing 2 ]
        { data = products
        , columns =
            [ productColumn (textColumnDescription 3 "Source" .source (productTextToLink .source))
            , productColumn (textColumnDescription 3 "Manufacturer" .manufacturer (productTextToLink .manufacturer))
            , productColumn (textColumnDescription 3 "Code" .product_code (productTextToLink .product_code))
            , productColumn (textColumnDescription 16 "Description" .description (productTableDescriptionElement currentDate))
            , productColumn (textColumnDescription 1 "Scale" .scale (productTextToLink .scale))
            , productColumn (textColumnDescription 1 "Price" .price priceColumnContent)
            , productColumn (textColumnDescription 4 "Category" .category (productTextToLink .category))
            , productColumn (ProductColumnDescription 4 (columnHeading [] (text "Image")) (imageCell setDisplayImage .image_url))
            ]
        }


priceColumnContent : Product -> Element msg
priceColumnContent product =
    let
        priceRow =
            product.price
                |> nonBreakingSpaces
                |> text
                |> productLink product
                |> el [ centerX ]

        dateRow =
            product.last_price_update
                |> Date.format "d MMM YYYY"
                |> (\date -> "(" ++ date ++ ")")
                |> nonBreakingSpaces
                |> text
                |> productLink product
                |> el [ centerX ]
    in
    column [] [ priceRow, dateRow ]


nonBreakingSpaces : String -> String
nonBreakingSpaces string =
    let
        nonBreakingSpace =
            String.fromChar (Char.fromCode 160)
    in
    string |> replace " " nonBreakingSpace


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
        |> productLink product


productLink : { a | url : String } -> Element msg -> Element msg
productLink product labelContent =
    link [ mouseOver [ Font.color cornflowerblue ] ] { url = product.url, label = labelContent }


{-| Single text cell
-}
textCell : (Product -> Element msg) -> Product -> Element msg
textCell contentBuilder product =
    product
        |> contentBuilder
        |> (\x -> paragraph [ normalFontSize ] [ x ])


{-| Single column
-}
productColumn : ProductColumnDescription msg -> IndexedColumn Product msg
productColumn columnDefinition =
    { header = columnDefinition.heading
    , width = fillPortion columnDefinition.proportion
    , view =
        \index product ->
            columnDefinition.cellContent product
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


sortIndicator headingText sortDescription =
    case sortDirection headingText sortDescription of
        Ascending ->
            upArrow

        Descending ->
            downArrow

        Unsorted ->
            none
