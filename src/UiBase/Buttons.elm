module UiBase.Buttons exposing (actionButton, mediumActionButton, smallActionButton, pageSelectButton)

{-| Provide clickable buttons


# Buttons

@docs actionButton, mediumActionButton, smallActionButton, pageSelectButton

-}

import Element exposing (Element, alignRight, el, mouseOver, padding, text)
import Element.Background as Background
import Element.Border exposing (rounded)
import Element.Events exposing (onClick)
import Element.Font as Font
import Element.Input
import UiBase.Colors exposing (navBackground, navTextColour)
import UiBase.Constants exposing (defaultRounding)


{-| Largest button that indicates you can do something
-}
actionButton : msg -> String -> Element msg
actionButton event buttonLabel =
    sizedActionButton event
        buttonLabel
        20
        10


{-| Medium button that indicates you can do something
-}
mediumActionButton : msg -> String -> Element msg
mediumActionButton event buttonLabel =
    sizedActionButton event
        buttonLabel
        18
        7


{-| Smallest button that indicates you can do something
-}
smallActionButton : msg -> String -> Element msg
smallActionButton event buttonLabel =
    sizedActionButton event
        buttonLabel
        15
        5


{-| Button with custom font and padding size
-}
sizedActionButton : msg -> String -> Int -> Int -> Element msg
sizedActionButton event buttonLabel fontSize paddingSize =
    Element.Input.button
        [ Font.size fontSize
        , Font.color navTextColour
        , padding paddingSize
        , rounded defaultRounding
        , Background.color navBackground
        ]
        { onPress = Just event
        , label = text buttonLabel
        }

{-| Button for right hand top menu that selects a page
-}
pageSelectButton : msg -> String -> Element msg
pageSelectButton event buttonLabel =
    el [ Font.size 16, alignRight, padding 8, onClick event, rounded 10, mouseOver [ Background.color navBackground ] ] (text buttonLabel)

