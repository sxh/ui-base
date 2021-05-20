module UiBase.InfoPopups exposing (..)

import Accessibility.Styled exposing (toUnstyled)
import Colors.Opaque
import Css
import Element exposing (html)
import Nri.Ui.Tooltip.V2 as Tooltip
import UiBase.Colors exposing (navBackground, toCssColor)


example2 : (Bool -> msg) -> Bool -> Element.Element msg
example2 toggleMsg open =
    Tooltip.toggleTip { label = "Some label" }
        [ Tooltip.onRight
        , Tooltip.plaintext "Bob and more"
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
