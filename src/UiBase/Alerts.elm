module UiBase.Alerts exposing (alert)

{-| Display an alert, inline on the page


# Alert

@docs alert

-}

import Colors.Opaque exposing (red, white)
import Element exposing (Element, centerX, el, fill, padding, text, width)
import Element.Background as Background
import Element.Border as Border exposing (rounded)
import Element.Font as Font
import UiBase.Constants exposing (defaultRounding)
import UiBase.Sizes exposing (extraLargeFontSize)


{-| Display an alert, inline on the page
-}
alert : String -> Element msg
alert message =
    el
        [ extraLargeFontSize
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
