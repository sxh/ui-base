module UiBase.RelatedItems exposing (relatedItemsListAsRow)

{-| Provide consistent view of related items

# View methods

@docs relatedItemsListAsRow

-}

import Element exposing (Element, fill, padding, spacing, width, wrappedRow)
import Element.Font as Font
import UiBase.AircraftTypes exposing (TypedAircraftData, TypedAircraftList, toTypedList)
import UiBase.RelatedItemButtons exposing (relatedItemButton)

{-| All the related items of a single type as a single row
-}
relatedItemsListAsRow : (TypedAircraftData -> msg) -> TypedAircraftList -> Element msg
relatedItemsListAsRow getRelatedAircraftMsg names =
    names
        |> toTypedList
        |> List.map (relatedItemButton getRelatedAircraftMsg)
        |> wrappedRow [ width fill, padding 5, Font.size 16, spacing 5 ]


