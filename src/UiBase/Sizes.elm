module UiBase.Sizes exposing (extraLargeFontSize, largeFontSize, normalFontSize, smallFontSize, superLargeFontSize)

import Element exposing (Attr)
import Element.Font as Font


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


smallFontSize : Attr decorative msg
smallFontSize =
    Font.size small


normalFontSize : Attr decorative msg
normalFontSize =
    Font.size normal


largeFontSize : Attr decorative msg
largeFontSize =
    Font.size large


extraLargeFontSize : Attr decorative msg
extraLargeFontSize =
    Font.size extraLarge


superLargeFontSize : Attr decorative msg
superLargeFontSize =
    Font.size superLarge
