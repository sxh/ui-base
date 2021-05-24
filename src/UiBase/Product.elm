module UiBase.Product exposing
    ( Product
    , SortDirection(..), SortDescription, sortDirection, toggleSort
    , productSources
    )

{-| Provide Product type and functions for sorting lists of products


# Product

@docs Product


# Sorting

@docs SortDirection, SortDescription, sortDirection, toggleSort


# Utility

@docs productSources

-}

import Date exposing (Date)


{-| Product type
-}
type alias Product =
    { id : Int
    , source : String
    , manufacturer : String
    , product_code : String
    , description : String
    , scale : String
    , category : String
    , url : String
    , image_url : Maybe String
    , price : String
    , display_short_description : Bool
    , indexed : Bool
    , first_seen : Date
    , last_price_update : Date
    }


{-| Possible sort directions
-}
type SortDirection
    = Ascending
    | Descending
    | Unsorted


{-| Details of what column is currently sorted, and how to sort it
-}
type alias SortDescription =
    { columnName : String
    , accessor : Product -> String
    , direction : SortDirection
    }


{-| Given a column name and the current sort description, determine the appropriate sort direction
-}
sortDirection : String -> SortDescription -> SortDirection
sortDirection columnName sortDescription =
    if sortDescription.columnName == columnName then
        sortDescription.direction

    else
        Unsorted


{-| Given a column name to sort on and the current sort description, determine the new sort description
-}
toggleSort : String -> (Product -> String) -> SortDescription -> SortDescription
toggleSort newColumnName newAccessor productSort =
    if newColumnName == productSort.columnName then
        let
            newDirection =
                case productSort.direction of
                    Ascending ->
                        Descending

                    _ ->
                        Ascending
        in
        SortDescription productSort.columnName productSort.accessor newDirection

    else
        SortDescription newColumnName newAccessor Ascending


{-| List of product sources
-}
productSources : List String
productSources =
    [ "Ebay (UK)", "Eduard", "Hannants", "KingKit", "Models For Sale" ]
