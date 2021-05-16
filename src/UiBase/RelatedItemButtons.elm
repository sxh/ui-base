module UiBase.RelatedItemButtons exposing (searchResultButton, relatedItemButton)

{-| Provide consistent clickable buttons for search and related items


# Buttons

@docs searchResultButton, relatedItemButton

-}

import Colors.Opaque exposing (royalblue)
import Element exposing (Element, el, mouseOver, padding, paddingXY, text)
import Element.Background as Background
import Element.Border exposing (rounded)
import Element.Events exposing (onClick)
import Element.Font as Font
import UiBase.AircraftTypes exposing (TypedAircraftData)
import UiBase.Buttons exposing (highlightingButton)
import UiBase.Colors exposing (navBackground, navTextColour)


{-| Search result button
-}
searchResultButton : (TypedAircraftData -> msg) -> TypedAircraftData -> Element msg
searchResultButton event typedAircraft =
    -- need to wrap this in a column that has the XY padding
    el [ paddingXY 20 2 ] (highlightingButton (event typedAircraft) typedAircraft.aircraftData.name)


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
