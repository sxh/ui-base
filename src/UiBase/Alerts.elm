module UiBase.Alerts exposing (alert)

import Element exposing (Element, centerX, el, fill, padding, text, width)
import Element.Background as Background
import Element.Border as Border exposing (rounded)
import Element.Font as Font
import UiBase.Buttons exposing (defaultRounding)
import UiBase.Colors exposing (red, white)


alert : String -> Element msg
alert message =
    el
        [ Font.size 20
        , Font.color white
        , padding 20
        , Border.solid
        , Border.width 4
        , Background.color red
        , width fill
        , centerX
        , rounded (defaultRounding * 2)
        ]
        (text message)
