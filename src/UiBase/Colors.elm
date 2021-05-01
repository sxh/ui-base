module UiBase.Colors exposing (navBackground, navTextColour)

{-| Predefine some colors by role. Uses phollyer/elm-ui-colors, which I recommend for
named colors.


# Colours by role

@docs navBackground, navTextColour

-}

import Colors.Opaque exposing (deepskyblue, white)
import Element exposing (Color)


{-| Return navigation background colour
-}
navBackground : Color
navBackground =
    deepskyblue


{-| Return navigation text colour
-}
navTextColour : Color
navTextColour =
    white
