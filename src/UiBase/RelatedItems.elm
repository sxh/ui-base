module UiBase.RelatedItems exposing (relatedItemsListRow, relatedItemsListAsRow)

{-| Provide consistent view of related items

# View methods

@docs relatedItemsListAsRow, relatedItemsListRow

-}

import Element exposing (Element, fill, padding, row, spacing, text, width, wrappedRow)
import Element.Font as Font
import UiBase.AircraftTypes exposing (TypedAircraftData, TypedAircraftList, isEmpty, toTypedList)
import UiBase.RelatedItemButtons exposing (relatedItemButton)

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

