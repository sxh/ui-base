module UiBase.Buttons exposing (actionButton, defaultRounding, mediumActionButton, smallActionButton)

import Element exposing (Element, padding, text)
import Element.Background as Background
import Element.Border exposing (rounded)
import Element.Font as Font
import Element.Input
import UiBase.Colors exposing (navBackground, navTextColour)


defaultRounding =
    5


actionButton : msg -> String -> Element msg
actionButton event buttonLabel =
    sizedActionButton event
        buttonLabel
        20
        10


mediumActionButton : msg -> String -> Element msg
mediumActionButton event buttonLabel =
    sizedActionButton event
        buttonLabel
        18
        7


smallActionButton : msg -> String -> Element msg
smallActionButton event buttonLabel =
    sizedActionButton event
        buttonLabel
        15
        5


sizedActionButton : msg -> String -> Int -> Int -> Element msg
sizedActionButton event buttonLabel fontSize paddingSize =
    --el
    --    [ Font.size fontSize
    --    , Font.color navTextColour
    --    , padding paddingSize
    --    , onClick event
    --    , rounded defaultRounding
    --    , Background.color navBackground
    --    ]
    --    (text buttonLabel)
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



--Element.Input.button
--    [ Font.size fontSize
--    , Font.color navTextColour
--    , padding paddingSize
--    , rounded defaultRounding
--    , Background.color navBackground
--    ]
--    { onPress = event
--    , label = text buttonLabel
--    }
