module UiBase.Colors exposing
    ( navBackground, navTextColour
    , toCssColor
    )

{-| Predefine some colors by role. Uses phollyer/elm-ui-colors, which I recommend for
named colors.


# Colours by role

@docs navBackground, navTextColour

-}

import Colors.Opaque exposing (deepskyblue, white)
import Css
import Element exposing (Color, toRgb)


{-| Return navigation background colour
-}
navBackground : Element.Color
navBackground =
    deepskyblue


{-| Return navigation text colour
-}
navTextColour : Element.Color
navTextColour =
    white


toCssColor : Element.Color -> Css.Color
toCssColor color =
    color
        |> toRgb
        |> (\rgbFloats ->
                Css.rgb
                    (rgbFloats.red * 255 |> round)
                    (rgbFloats.green * 255 |> round)
                    (rgbFloats.blue * 255 |> round)
           )
