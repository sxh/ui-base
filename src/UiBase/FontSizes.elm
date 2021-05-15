module UiBase.FontSizes exposing (smallFontSize, normalFontSize, largeFontSize, superLargeFontSize, extraLargeFontSize)

{-| Support consistent fontSizes


# Sizes (in increasing size order)

@docs smallFontSize, normalFontSize, largeFontSize, superLargeFontSize, extraLargeFontSize

-}

import Element exposing (Attr)
import Element.Font as Font


{-| Small
-}
smallFontSize : Attr decorative msg
smallFontSize =
    Font.size small


{-| Normal
-}
normalFontSize : Attr decorative msg
normalFontSize =
    Font.size normal


{-| Large
-}
largeFontSize : Attr decorative msg
largeFontSize =
    Font.size large


{-| Extra large
-}
extraLargeFontSize : Attr decorative msg
extraLargeFontSize =
    Font.size extraLarge


{-| Super large
-}
superLargeFontSize : Attr decorative msg
superLargeFontSize =
    Font.size superLarge


superLarge =
    24


extraLarge =
    20


large =
    18


normal =
    16


small =
    14
