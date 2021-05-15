module UiBase.SearchResults exposing (searchAircraftList)

{-| Consistent search result rows


# Search Results Rows

@docs searchAircraftList

-}

import Element exposing (Element, column, fill, paddingXY, row, text, width)
import List exposing (concatMap, isEmpty)
import Maybe exposing (withDefault)
import UiBase.AircraftTypes exposing (GenericAircraftData, RelatedToSearch, TypedAircraftData, TypedAircraftList, aircraftTypeString)
import UiBase.FontSizes exposing (largeFontSize)
import UiBase.RelatedItemButtons exposing (searchResultButton)
import Vector4 exposing (toList)


{-| Formatted list, or nothing
-}
searchAircraftList : (TypedAircraftData -> msg) -> Maybe RelatedToSearch -> Element msg
searchAircraftList toMsg maybeSearchResults =
    let
        maybeSearchRows =
            maybeSearchResults |> Maybe.map (searchResultRows toMsg) |> withDefault []
    in
    column [ width fill ] maybeSearchRows


{-| List of search result rows
-}
searchResultRows : (TypedAircraftData -> msg) -> RelatedToSearch -> List (Element msg)
searchResultRows toMsg relatedToSearch =
    relatedToSearch.lists
        |> toList
        |> concatMap
            (\each ->
                typeToHeading each.aircraftType
                    :: typedListToRows toMsg each
            )


typeToHeading aircraftType =
    aircraftType
        |> aircraftTypeString
        |> searchResultHeading


typedListToRows : (TypedAircraftData -> msg) -> TypedAircraftList -> List (Element msg)
typedListToRows toMsg each =
    case isEmpty each.list of
        True ->
            [ Element.none ]

        False ->
            each.list
                |> List.sortBy .name
                |> List.map (\generic -> TypedAircraftData each.aircraftType generic)
                |> List.map (searchResultRow toMsg)


{-| Search result heading
-}
searchResultHeading : String -> Element msg
searchResultHeading groupName =
    row [ largeFontSize, paddingXY 0 20 ] [ text groupName ]


{-| Single search result row
-}
searchResultRow : (TypedAircraftData -> msg) -> TypedAircraftData -> Element msg
searchResultRow toMsg aircraft =
    searchResultButton toMsg aircraft
