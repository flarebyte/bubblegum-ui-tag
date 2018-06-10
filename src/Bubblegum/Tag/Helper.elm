module Bubblegum.Tag.Helper exposing (..)

{-| Helper to keep the noise away from Widget
-}

import Bubblegum.Entity.Outcome as Outcome exposing (..)
import Bubblegum.Entity.SettingsEntity as SettingsEntity
import Bubblegum.Entity.StateEntity as StateEntity
import Bubblegum.Tag.IsoLanguage exposing (IsoLanguage(..), toIsoLanguage)
import Bubblegum.Tag.VocabularyHelper exposing (getContentLanguage, getSelected, getSuggestion, getUserLanguage)
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


themeProgress : Outcome Bool -> Outcome Bool -> Outcome String
themeProgress a b =
    Outcome.or
        (a |> Outcome.checkOrNone identity |> Outcome.trueMapToConstant "is-success")
        (b |> Outcome.checkOrNone identity |> Outcome.trueMapToConstant "is-danger")
        |> Outcome.withDefault "is-info"


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


deduceSelectable : List String -> List String -> List String
deduceSelectable suggestions selected =
    Set.diff (Set.fromList suggestions) (Set.fromList selected) |> Set.toList


getRemainingSuggestions : SettingsEntity.Model -> StateEntity.Model -> Outcome (List String)
getRemainingSuggestions settings state =
    getSuggestion settings |> Outcome.map (\suggestions -> deduceSelectable suggestions (getSelectedAsList state))
