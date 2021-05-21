module UiBase.InfoPopups exposing (..)

import Accessibility.Styled exposing (toUnstyled)
import Colors.Opaque
import Css
import Element exposing (html)
import Nri.Ui.Tooltip.V2 as Tooltip
import UiBase.Colors exposing (navBackground, toCssColor)


toolTip : String -> (Bool -> msg) -> Bool -> Element.Element msg
toolTip content toggleMsg open =
    Tooltip.toggleTip { label = "Some label" }
        [ Tooltip.onTop
        , Tooltip.plaintext content
        , Tooltip.onHover toggleMsg
        , Tooltip.open open
        , Tooltip.smallPadding
        , Tooltip.fitToContent
        , Tooltip.css
            [ -- there is something seriously weird going on here with certain values
              Css.backgroundColor (Colors.Opaque.white |> toCssColor)
            , Css.color (Colors.Opaque.darkslategrey |> toCssColor)
            , Css.borderColor (navBackground |> toCssColor)
            ]
        ]
        |> toUnstyled
        |> html
