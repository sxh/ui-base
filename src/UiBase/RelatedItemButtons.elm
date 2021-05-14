module UiBase.RelatedItemButtons exposing (relatedItemButton, searchResultButton)
{-| Provide consistent clickable buttons for search and related items

# Buttons

@docs searchResultButton, relatedItemButton

-}

import Colors.Opaque exposing (royalblue)
import Element exposing (Element, el, mouseOver, padding, paddingXY, row, text)
import Element.Background as Background
import Element.Border exposing (rounded)
import Element.Events exposing (onClick)
import Element.Font as Font
import Element.Input exposing (button)
import UiBase.AircraftTypes exposing (TypedAircraftData)
import UiBase.Colors exposing (navBackground, navTextColour)
import UiBase.Constants exposing (defaultRounding)


{-| Search result button
-}
searchResultButton : (TypedAircraftData -> msg) -> TypedAircraftData -> Element msg
searchResultButton event data =
    -- need to wrap this in a column that has the XY padding
    row
        [ Font.size 16
        , Font.color navBackground
        , paddingXY 20 2
        , rounded defaultRounding
        , Font.color navBackground
        , mouseOver [ Background.color royalblue ]
        ]
        [ button [] { onPress = Just (event data), label = text data.aircraftData.name } ]


{-| Related item button
-}
relatedItemButton : (TypedAircraftData -> msg) -> TypedAircraftData -> Element msg
relatedItemButton event data =
        el
            [ padding 5
            , rounded 3
            , Background.color navBackground
            , Font.color navTextColour
            , onClick (event data)
            , mouseOver [ Background.color royalblue ]
            ]
            (text data.aircraftData.name)
