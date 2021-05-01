module UiBase.Buttons exposing (actionButton, mediumActionButton, smallActionButton)

{-| Provide clickable buttons


# Buttons

@docs actionButton, mediumActionButton, smallActionButton

-}

import Element exposing (Element, padding, text)
import Element.Background as Background
import Element.Border exposing (rounded)
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
