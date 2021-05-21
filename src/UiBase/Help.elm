module UiBase.Help exposing
    ( HelpControl
    , withHelp
    )

{-| Provide control structues and a method for adding onHover help text


# Control the visibility of the help

@docs HelpControl


# Formatting

@docs withHelp

-}

import Accessibility.Styled exposing (br, text, toUnstyled)
import Colors.Opaque
import Css
import Element exposing (Element, html, row)
import List exposing (map)
import Maybe exposing (withDefault)
import Nri.Ui.Tooltip.V2 as Tooltip
import UiBase.Colors exposing (navBackground, toCssColor)


{-| Toggle is sent each time hovering starts or ends, with the current open/closed state
-}
type alias HelpControl msg =
    { toggle : Bool -> msg
    , state : Bool
    }


{-| Add an info icon to the right of the element passed in
-}
withHelp : List String -> Maybe (HelpControl msg) -> Element msg -> Element msg
withHelp content helpControl element =
    let
        columnHelp : List String -> Maybe (HelpControl msg) -> Element msg
        columnHelp contentList maybeInfo =
            maybeInfo
                |> Maybe.map (\info -> popUp contentList info.toggle info.state)
                |> withDefault Element.none
    in
    row [] [ element, columnHelp content helpControl ]


popUp : List String -> (Bool -> msg) -> Bool -> Element.Element msg
popUp content toggleMsg open =
    Tooltip.toggleTip { label = "Help" }
        [ Tooltip.onTop
        , Tooltip.html (content |> map text |> List.intersperse (br []))
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
