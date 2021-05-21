module UiBase.InfoPopups exposing (HelpControl, withHelp)

import Accessibility.Styled exposing (toUnstyled)
import Colors.Opaque
import Css
import Element exposing (Element, html, row)
import Maybe exposing (withDefault)
import Nri.Ui.Tooltip.V2 as Tooltip
import UiBase.Colors exposing (navBackground, toCssColor)


type alias HelpControl msg =
    { toggle : Bool -> msg
    , state : Bool
    }


withHelp : String -> Maybe (HelpControl msg) -> Element msg -> Element msg
withHelp content helpControl element =
    let
        columnHelp : String -> Maybe (HelpControl msg) -> Element msg
        columnHelp contentString maybeInfo =
            maybeInfo |> Maybe.map (\info -> toolTip contentString info.toggle info.state) |> withDefault Element.none
    in
    row [] [ element, columnHelp content helpControl ]


toolTip : String -> (Bool -> msg) -> Bool -> Element.Element msg
toolTip content toggleMsg open =
    Tooltip.toggleTip { label = content }
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
