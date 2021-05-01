module UiBase.Colors exposing
    ( deepSkyBlue, skyBlue, white, black, royalBlue, cornflowerBlue, red
    , navBackground, navTextColour
    )

{-| Predefine colours by name, and assign some by role


# Colours by name

@docs deepSkyBlue, skyBlue, white, black, royalBlue, cornflowerBlue, red


# Colours by role

@docs navBackground, navTextColour

-}

import Element exposing (Element, rgb255)


{-| Return navigation background colour
-}
navBackground : Element.Color
navBackground =
    deepSkyBlue


{-| Return navigation text colour
-}
navTextColour : Element.Color
navTextColour =
    white


{-| Return deepSkyBlue
-}
deepSkyBlue : Element.Color
deepSkyBlue =
    rgb255 0 191 255


{-| Return skyBlue
-}
skyBlue : Element.Color
skyBlue =
    rgb255 136 206 255


{-| Return white
-}
white : Element.Color
white =
    rgb255 255 255 255


{-| Return black
-}
black : Element.Color
black =
    rgb255 0 0 0


{-| Return royalBlue
-}
royalBlue : Element.Color
royalBlue =
    rgb255 65 105 225


{-| Return cornflowerBlue
-}
cornflowerBlue : Element.Color
cornflowerBlue =
    rgb255 100 149 237


{-| Return red
-}
red : Element.Color
red =
    rgb255 255 0 0
