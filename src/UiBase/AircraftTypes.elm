module UiBase.AircraftTypes exposing (AircraftType(..), aircraftTypeString, GenericAircraftData, TypedAircraftData, TypedAircraftList, isEmpty, toTypedList, RelatedToAircraft, RelatedToSearch)

{-| Provide types to be shared across applications


# Generic Aircraft Data

@docs GenericAircraftData

# Aircraft Type

@docs AircraftType, aircraftTypeString

# Typed Aircraft, single and lists

@docs TypedAircraftData, TypedAircraftList, isEmpty, toTypedList

# Collections of related aircraft data

@docs RelatedToAircraft, RelatedToSearch

-}
import Vector3 exposing (Vector3)
import Vector4 exposing (Vector4)



{-| Enumerated types of aircraft
-}
type AircraftType
    = ManufacturerType
    | AircraftType
    | VariantType
    | CommonNameType
    | ToBeDeletedSearchType


{-| Convert an aircraft type to a string
-}
aircraftTypeString : AircraftType -> String
aircraftTypeString thisType =
    case thisType of
        ManufacturerType ->
            "Manufacturers"

        AircraftType ->
            "Aircraft"

        VariantType ->
            "Variants"

        CommonNameType ->
            "Common Names"

        ToBeDeletedSearchType ->
            "Search stuff (shouldn't happen)"


{-| Data that is common to all kinds of aircraft related entities
-}
type alias GenericAircraftData =
    { id : Int, name : String, notes_markdown : String, misnomers : List String }


{-| Generic aircraft data plus an aircraft type
-}
type alias TypedAircraftData =
    { aircraftType : AircraftType, aircraftData : GenericAircraftData }


{-| List of generic aircraft data of the same aircraft type
-}
type alias TypedAircraftList =
    { aircraftType : AircraftType, list : List GenericAircraftData }


{-| Check of a typed aircraft list is empty
-}
isEmpty : TypedAircraftList -> Bool
isEmpty typedAircraftList =
    typedAircraftList.list |> List.isEmpty


{-| Convert a list of a single type of entity to a generic list that holds items typed individually
-}
toTypedList : TypedAircraftList -> List TypedAircraftData
toTypedList typedAircraftList =
    typedAircraftList.list |> List.map (TypedAircraftData typedAircraftList.aircraftType)


{-| All the typed entities related to some particular typed aircraft data, grouped by type and including the base.
There will never be other items of the same type.
-}
type alias RelatedToAircraft =
    { base : TypedAircraftData, lists : Vector3 TypedAircraftList }


{-| All the typed entities related to a particular search, grouped by type
-}
type alias RelatedToSearch =
    { lists : Vector4 TypedAircraftList }
