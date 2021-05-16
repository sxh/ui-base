module UiBase.Buttons exposing
    ( actionButton, mediumActionButton, smallActionButton, pageSelectButton
    , highlightingButton, smallHighlightingButton
    )

{-| Provide clickable buttons


# Action buttons

@docs actionButton, mediumActionButton, smallActionButton, pageSelectButton


# Highlighting buttons

@docs highlightingButton, smallHighlightingButton

-}

import Colors.Opaque exposing (royalblue)
import Element exposing (Attribute, Element, alignRight, el, mouseOver, padding, text)
import Element.Background as Background
import Element.Border exposing (rounded)
import Element.Events exposing (onClick)
import Element.Font as Font
import Element.Input exposing (button)
import UiBase.Colors exposing (navBackground, navTextColour)
import UiBase.Constants exposing (defaultRounding)
import UiBase.FontSizes exposing (extraLargeFontSize, largeFontSize, normalFontSize, smallFontSize)


{-| Largest button that indicates you can do something
-}
actionButton : msg -> String -> Element msg
actionButton event buttonLabel =
    sizedActionButton event
        buttonLabel
        extraLargeFontSize
        10


{-| Medium button that indicates you can do something
-}
mediumActionButton : msg -> String -> Element msg
mediumActionButton event buttonLabel =
    sizedActionButton event
        buttonLabel
        largeFontSize
        7


{-| Smallest button that indicates you can do something
-}
smallActionButton : msg -> String -> Element msg
smallActionButton event buttonLabel =
    sizedActionButton event
        buttonLabel
        smallFontSize
        5


{-| Button with custom font and padding size
-}
sizedActionButton : msg -> String -> Attribute msg -> Int -> Element msg
sizedActionButton event buttonLabel fontSize paddingSize =
    Element.Input.button
        [ fontSize
        , Font.color navTextColour
        , padding paddingSize
        , rounded defaultRounding
        , Background.color navBackground
        ]
        { onPress = Just event
        , label = text buttonLabel
        }


{-| Normal sized button with white background, becomes royal blue on mouseover
-}
highlightingButton : msg -> String -> Element msg
highlightingButton msg label =
    sizedHighlightingButton msg label normalFontSize


{-| Small button with white background, becomes royal blue on mouseover
-}
smallHighlightingButton : msg -> String -> Element msg
smallHighlightingButton msg label =
    sizedHighlightingButton msg label smallFontSize


{-| Button with custom font, becomes royal blue on mouseover
-}
sizedHighlightingButton : msg -> String -> Attribute msg -> Element msg
sizedHighlightingButton msg label fontSize =
    el
        [ fontSize
        , Font.color navBackground
        , rounded defaultRounding
        , Font.color navBackground
        , mouseOver [ Background.color royalblue ]
        ]
        (button []
            { onPress = Just msg
            , label = text label
            }
        )


{-| Button for right hand top menu that selects a page
-}
pageSelectButton : msg -> String -> Element msg
pageSelectButton event buttonLabel =
    el
        [ normalFontSize
        , alignRight
        , padding 8
        , onClick event
        , rounded 10
        , mouseOver [ Background.color navBackground ]
        ]
        (text buttonLabel)
