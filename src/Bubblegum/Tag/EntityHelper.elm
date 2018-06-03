module Bubblegum.Tag.EntityHelper exposing (..)

{-| Basic functions for the VocabularyHelper to facilitate the retrieval of data from the configuration
-}

import Bubblegum.Entity.Attribute as Attribute
import Bubblegum.Entity.Outcome as Outcome exposing (..)
import Bubblegum.Entity.Validation as Validation
import Bubblegum.Tag.HelperLimits exposing (compactUriLimitList, limitList, limitMediumRangeNotEmpty, limitSmallRangeNotEmpty)
import Regex


findIntRange : ( String, String ) -> List Attribute.Model -> Outcome ( Int, Int )
findIntRange keyTuple attributes =
    Attribute.findOutcomeByKeyTuple keyTuple attributes
        |> Validation.asTuple
        |> Validation.asIntTuple
        |> Validation.asIntRange


findString : String -> List Attribute.Model -> Outcome String
findString key attributes =
    Attribute.findOutcomeByKey key attributes |> Validation.asSingle


findStringForId : String -> List Attribute.Model -> String -> Outcome String
findStringForId key attributes id =
    findOutcomeByKeyAndId key attributes id |> Validation.asSingle


findBool : String -> List Attribute.Model -> Outcome Bool
findBool key attributes =
    findString key attributes |> Validation.asBool


findBoolForId : String -> List Attribute.Model -> String -> Outcome Bool
findBoolForId key attributes id =
    findStringForId key attributes id |> Validation.asBool


findListString : String -> List Attribute.Model -> Outcome (List String)
findListString key attributes =
    Attribute.findOutcomeByKey key attributes |> Validation.listLessThan limitList |> Validation.withinListStringCharsRange limitSmallRangeNotEmpty


findListStringForId : String -> List Attribute.Model -> String -> Outcome (List String)
findListStringForId key attributes id =
    findOutcomeByKeyAndId key attributes id |> Validation.listLessThan limitList |> Validation.withinListStringCharsRange limitSmallRangeNotEmpty


findListCompactUri : String -> List Attribute.Model -> Outcome (List String)
findListCompactUri key attributes =
    Attribute.findOutcomeByKey key attributes
        |> Validation.listLessThan compactUriLimitList
        |> Validation.withinListStringCharsRange limitMediumRangeNotEmpty
        |> listMatchCompactUri



-- TODO export to Entity library


{-| Find an attribute by key but also id
findAttributeByKeyAndId "ui:label" models "id:topic/123" -- Just label
-}
findAttributeByKeyAndId : String -> List Attribute.Model -> String -> Maybe Attribute.Model
findAttributeByKeyAndId key attributes id =
    case attributes of
        [] ->
            Nothing

        first :: rest ->
            if first.key == key && first.id == Just id then
                Just first
            else
                findAttributeByKeyAndId key rest id


{-| Find an outcome searching by key
findOutcomeByKeyAndId "ui:label" models "id:topic/123" -- Valid ["some label"]
-}
findOutcomeByKeyAndId : String -> List Attribute.Model -> String -> Outcome (List String)
findOutcomeByKeyAndId key attributes id =
    findAttributeByKeyAndId key attributes id |> Maybe.map .values |> Outcome.fromMaybe


listMatchCompactUri : Outcome (List String) -> Outcome (List String)
listMatchCompactUri outcome =
    Outcome.check (\list -> List.all helperCompactUri list) "unsatisfied-constraint:list-compact-uri" outcome


helperCompactUri : String -> Bool
helperCompactUri value =
    Regex.contains (Regex.regex "^[a-z][a-z0-9_.-]{1,15}:\\w[^\\s]*$") value
