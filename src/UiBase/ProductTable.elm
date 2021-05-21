module UiBase.ProductTable exposing
    ( ProductTableDescription, ProductTableSorting
    , productTable
    )

{-| Provide a consistent Product table experience


# Description

@docs ProductTableDescription, ProductTableSorting


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
import UiBase.Help exposing (HelpControl, withHelp)
import UiBase.Product exposing (Product, SortDescription, SortDirection(..), sortDirection)
import UiBase.SvgExtensions exposing (downArrow, upArrow)


{-| Three key attributes of each column
-}
type alias ProductColumnDescription msg =
    { proportion : Int
    , heading : Element msg
    , cellContent : Product -> Element msg
    }


{-| Shared attributes and state/events that must be provided by provided by consumers
-}
type alias ProductTableDescription msg =
    { sorting : ProductTableSorting (Product -> String) msg
    , setDisplayImage : Int -> msg
    , currentDate : Date
    , sourceHelpControl : Maybe (HelpControl msg)
    , imageHelpControl : Maybe (HelpControl msg)
    }


{-| Message used to change sorting direction, and the specification of the current sorting
-}
type alias ProductTableSorting c msg =
    { toggleSort : String -> c -> msg
    , sortDescription : SortDescription
    }


{-| The overall table
-}
productTable : ProductTableDescription msg -> List Product -> Element msg
productTable productTableDescription products =
    let
        sortableHeader =
            sortableTextColumnHeading productTableDescription.sorting

        textCellWithLink =
            productTextToLink >> textCell

        sellerHelp =
            withHelp [ "Products are included from:", "- Ebay", "- Eduard", "- Hannants", "- KingKit", "- Models For Sale" ] productTableDescription.sourceHelpControl

        imageHelp =
            withHelp [ "Click on the image and ", "a larger version will be displayed", "(if it is available)" ] productTableDescription.imageHelpControl
    in
    Element.indexedTable [ width fill, spacing 2 ]
        { data = products
        , columns =
            [ ProductColumnDescription 3 (sortableHeader "Source" .source |> sellerHelp) (textCellWithLink .source)
            , ProductColumnDescription 3 (sortableHeader "Manufacturer" .manufacturer) (textCellWithLink .manufacturer)
            , ProductColumnDescription 3 (sortableHeader "Code" .product_code) (textCellWithLink .product_code)
            , ProductColumnDescription 16 (sortableHeader "Description" .description) (productTableDescription.currentDate |> productTableDescriptionElement)
            , ProductColumnDescription 1 (sortableHeader "Scale" .scale) (textCellWithLink .scale)
            , ProductColumnDescription 1 (sortableHeader "Price" .price) (priceColumnContent |> textCell)
            , ProductColumnDescription 4 (sortableHeader "Category" .category) (textCellWithLink .category)
            , ProductColumnDescription 4 (columnHeading [] (text "Image") |> imageHelp) (imageCell productTableDescription.setDisplayImage .image_url)
            ]
                |> List.map asProductColumn
        }


sortableTextColumnHeading : ProductTableSorting c msg -> String.String -> c -> Element msg
sortableTextColumnHeading productTableSorting headingText accessor =
    columnHeading
        [ onClick (productTableSorting.toggleSort headingText accessor) ]
        (row [ spacing 5 ]
            [ text headingText
            , sortIndicator headingText productTableSorting.sortDescription
            , text "toggle"
            ]
        )


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
asProductColumn : ProductColumnDescription msg -> IndexedColumn Product msg
asProductColumn columnDefinition =
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
