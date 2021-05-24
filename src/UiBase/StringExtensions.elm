module UiBase.StringExtensions exposing (joinGrammatically)

{-| Extensions to String and Lists of String


# List String

@docs joinGrammatically

-}

import List.Extra exposing (init, last)
import Maybe exposing (withDefault)
import String exposing (join)


{-| Join a list of string, with Oxford comma
-}
joinGrammatically : List String -> String
joinGrammatically strings =
    case List.length strings of
        0 ->
            join "" strings

        1 ->
            join "" strings

        2 ->
            join " and " strings

        _ ->
            let
                earlyStrings : List String
                earlyStrings =
                    init strings |> withDefault []

                lastString : String
                lastString =
                    last strings |> withDefault ""
            in
            [ earlyStrings |> join ", ", lastString ]
                |> String.join ", and "
