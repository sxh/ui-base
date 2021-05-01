module UiBase.OnKey exposing (onEnter, onEscape, onKey)

-- sxh move this to a separate gem and share with scaleaircraftstuff

import Element exposing (Attribute)
import Html.Events
import Json.Decode as Decode


onEnter : msg -> Attribute msg
onEnter msg =
    onKey "Enter" msg


onEscape : msg -> Attribute msg
onEscape msg =
    onKey "Escape" msg


onKey : String -> msg -> Element.Attribute msg
onKey keyValue msg =
    Element.htmlAttribute
        (Html.Events.on "keyup"
            (Decode.field "key" Decode.string
                |> Decode.andThen
                    (\key ->
                        if key == keyValue then
                            Decode.succeed msg

                        else
                            Decode.fail ("Not the " ++ keyValue ++ " key")
                    )
            )
        )
