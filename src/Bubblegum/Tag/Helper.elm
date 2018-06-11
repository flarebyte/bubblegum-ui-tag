module Bubblegum.Tag.Helper exposing (..)

{-| Helper to keep the noise away from Widget
-}

import Bubblegum.Entity.Outcome as Outcome exposing (..)
import Bubblegum.Entity.SettingsEntity as SettingsEntity
import Bubblegum.Entity.StateEntity as StateEntity
import Bubblegum.Tag.IsoLanguage exposing (IsoLanguage(..), toIsoLanguage)
import Bubblegum.Tag.VocabularyHelper
    exposing
        ( getConstituentLabel
        , getContentLanguage
        , getSearch
        , getSelected
        , getSuggestion
        , getUserLanguage
        )
import Maybe exposing (..)
import Set as Set
import Tuple exposing (first, second)


successRange : Int -> ( Int, Int ) -> Bool
successRange size range =
    (size >= first range) && (size < second range)


dangerRange : Int -> ( Int, Int ) -> Bool
dangerRange size range =
    not (successRange size range)


tupleify : a -> b -> ( a, b )
tupleify a b =
    ( a, b )


titleCharRange : ( Int, Int )
titleCharRange =
    ( 1, 70 )


type ProgressStatus
    = IsSuccess
    | IsDanger
    | IsNeutral


themeProgress : Outcome Bool -> Outcome Bool -> Outcome ProgressStatus
themeProgress a b =
    Outcome.or
        (a |> Outcome.checkOrNone identity |> Outcome.trueMapToConstant IsSuccess)
        (b |> Outcome.checkOrNone identity |> Outcome.trueMapToConstant IsDanger)
        |> Outcome.withDefault IsNeutral


tagStyle : ProgressStatus -> String
tagStyle status =
    case status of
        IsSuccess ->
            "is-success"

        IsDanger ->
            "is-danger"

        IsNeutral ->
            "is-dark"

textStyle : ProgressStatus -> String
textStyle status =
    case status of
        IsSuccess ->
            "has-text-success"

        IsDanger ->
            "has-text-danger"

        IsNeutral ->
            "has-text-grey-light"


getUserLanguageOrEnglish : SettingsEntity.Model -> String
getUserLanguageOrEnglish settings =
    getUserLanguage settings
        |> Outcome.toMaybe
        |> Maybe.withDefault "en-GB"


getContentLanguageOrEnglish : SettingsEntity.Model -> String
getContentLanguageOrEnglish settings =
    getContentLanguage settings
        |> Outcome.toMaybe
        |> Maybe.withDefault "en-GB"


getUserIsoLanguage : SettingsEntity.Model -> IsoLanguage
getUserIsoLanguage settings =
    getUserLanguageOrEnglish settings |> toIsoLanguage


getContentIsoLanguage : SettingsEntity.Model -> IsoLanguage
getContentIsoLanguage settings =
    getContentLanguageOrEnglish settings |> toIsoLanguage


getSelectedAsList : StateEntity.Model -> List String
getSelectedAsList state =
    getSelected state |> Outcome.toMaybe |> Maybe.withDefault []


getSearchAsString : StateEntity.Model -> String
getSearchAsString state =
    getSearch state |> Outcome.toMaybe |> Maybe.withDefault ""


deduceSelectable : List String -> List String -> List String
deduceSelectable suggestions selected =
    Set.diff (Set.fromList suggestions) (Set.fromList selected) |> Set.toList


isLabelMatchSearch : SettingsEntity.Model -> String -> String -> Bool
isLabelMatchSearch settings search id =
    getConstituentLabel settings id |> Outcome.map (\label -> String.contains search label) |> Outcome.toMaybe |> Maybe.withDefault False


filterSuggestionsBySearch : SettingsEntity.Model -> String -> List String -> List String
filterSuggestionsBySearch settings search suggestions =
    if String.isEmpty search then
        suggestions
    else
        List.filter (\id -> isLabelMatchSearch settings search id) suggestions


getRemainingSuggestions : SettingsEntity.Model -> StateEntity.Model -> Outcome (List String)
getRemainingSuggestions settings state =
    getSuggestion settings
        |> Outcome.map (\suggestions -> deduceSelectable suggestions (getSelectedAsList state))
        |> Outcome.map (\suggestions -> filterSuggestionsBySearch settings (getSearchAsString state) suggestions)
