module UiBase.SvgExtensions exposing (downArrow, spinner, upArrow, angleUp, angleDown)

{-| Provide icons as elm-ui Elements

# Icons

@docs upArrow, downArrow, spinner, angleUp, angleDown

-}

import Element exposing (Element, el, html)
import FontAwesome.Attributes exposing (spin)
import FontAwesome.Icon exposing (viewStyled)
import FontAwesome.Solid
import Svg


{-| Up arrow
-}
upArrow : Element msg
upArrow =
    iconElement [] FontAwesome.Solid.angleUp


{-| Down arrow
-}
downArrow : Element msg
downArrow =
    iconElement [] FontAwesome.Solid.angleDown


{-| Spinner
-}
spinner : Element msg
spinner =
    iconElement [ spin ] FontAwesome.Solid.spinner

{-| Angle Up
-}
angleUp : Element msg
angleUp =
    iconElement [] FontAwesome.Solid.angleUp

{-| Angle Down
-}
angleDown : Element msg
angleDown =
    iconElement [] FontAwesome.Solid.angleDown

{-| Turn an icon into an Element
-}
iconElement : List (Svg.Attribute msg) -> FontAwesome.Icon.Icon -> Element msg
iconElement attributes icon =
    el [] (html (viewStyled attributes icon))

