module Colors exposing (actionButton, cornflowerBlue, defaultRounding, mediumActionButton, navBackground, navTextColour, red, royalBlue, skyBlue, smallActionButton, white)

-- sxh move this to a separate gem and share with scaleaircraftstuff

import Element exposing (Element, padding, rgb255, text)
import Element.Background as Background
import Element.Border exposing (rounded)
import Element.Font as Font
import Element.Input


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


navBackground =
    deepSkyBlue


navTextColour =
    white


deepSkyBlue =
    rgb255 0 191 255


skyBlue =
    rgb255 136 206 255


white =
    rgb255 255 255 255


black =
    rgb255 0 0 0


royalBlue =
    rgb255 65 105 225


cornflowerBlue =
    rgb255 100 149 237


red =
    rgb255 255 0 0
