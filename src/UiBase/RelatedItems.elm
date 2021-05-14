module UiBase.RelatedItems exposing (relatedAircraftSections, relatedItemsListAsRow, sectionHeadingRow)

{-| Provide consistent view of related items

# View methods

@docs relatedAircraftSections, relatedItemsListAsRow, sectionHeadingRow

-}

import Element exposing (Element, fill, padding, paddingXY, row, spacing, text, width, wrappedRow)
import Element.Font as Font
import List exposing (concatMap)
import UiBase.AircraftTypes exposing (RelatedToAircraft, TypedAircraftData, TypedAircraftList, aircraftTypeString, isEmpty, toTypedList)
import UiBase.RelatedItemButtons exposing (relatedItemButton)
import Vector3 exposing (toList)

{-| All the related items of a single type as a single row
-}
relatedItemsListAsRow : (TypedAircraftData -> msg) -> TypedAircraftList -> Element msg
relatedItemsListAsRow getRelatedAircraftMsg names =
    names
        |> toTypedList
        |> List.map (relatedItemButton getRelatedAircraftMsg)
        |> wrappedRow [ width fill, padding 5, Font.size 16, spacing 5 ]

{-| Row that contains either all the related items, or text if none
-}
relatedItemsListRow : (TypedAircraftData -> msg) -> TypedAircraftList -> Element msg
relatedItemsListRow getRelatedAircraftMsg typedAircraftList =
    if isEmpty typedAircraftList then
        row [] [ text "None" ]

    else
        relatedItemsListAsRow getRelatedAircraftMsg typedAircraftList

{-| All of the sections of related items by type, including headings and lists
-}
relatedAircraftSections : (TypedAircraftData -> msg) -> RelatedToAircraft -> List (Element msg)
relatedAircraftSections getRelatedAircraftMsg relatedAircraft =
    let
        relatedResultsSection : TypedAircraftList -> List (Element msg)
        relatedResultsSection typedAircraftList =
            sectionHeadingRow [ text (aircraftTypeString typedAircraftList.aircraftType) ] :: [ relatedItemsListRow getRelatedAircraftMsg typedAircraftList ]
    in
    relatedAircraft.lists
        |> toList
        |> concatMap relatedResultsSection

{-| Heading row for a section
-}
sectionHeadingRow : List (Element msg) -> Element msg
sectionHeadingRow elements =
    row
        [ Font.size 20, paddingXY 0 10, spacing 5 ]
        elements


