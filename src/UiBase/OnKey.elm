module UiBase.OnKey exposing
    ( onEnter, onEscape
    , onKey
    )

{-| Send messages when particular keys are pressed


# Convenience methods

@docs onEnter, onEscape


# General method

@docs onKey

-}

import Element exposing (Attribute)
import Html.Events
import Json.Decode as Decode


{-| Send msg when Enter key is pressed
-}
onEnter : msg -> Attribute msg
onEnter msg =
    onKey "Enter" msg


{-| Send msg when Escape key is pressed
-}
onEscape : msg -> Attribute msg
onEscape msg =
    onKey "Escape" msg


{-| Send msg when keyValue key is pressed. Keyvalue must be a string that is the value of a particular key

        onKey "Enter" msg

        onKey "Q" msg

-}
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
