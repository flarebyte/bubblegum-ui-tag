module Bubblegum.Tag.VocabularyHelper exposing (..)

{-| Helpers for accessing settings

    **Generated** by generate-vocabulary.py

-}

import Bubblegum.Entity.Outcome as Outcome exposing (..)
import Bubblegum.Entity.SettingsEntity as SettingsEntity
import Bubblegum.Entity.StateEntity as StateEntity
import Bubblegum.Entity.Validation as Validation
import Bubblegum.Tag.EntityHelper exposing (..)
import Bubblegum.Tag.HelperLimits exposing (..)
import Bubblegum.Tag.Vocabulary exposing (..)


{-| Whether the content requires right to left
-}
isContentRightToLeft : SettingsEntity.Model -> Outcome Bool
isContentRightToLeft settings =
    findBool ui_contentRightToLeft settings.attributes


{-| The selected tags for the field
-}
getSelected : StateEntity.Model -> Outcome (List String)
getSelected settings =
    findListCompactUri ui_selected settings.attributes


{-| Suggesting is currently happening
-}
isSuggesting : StateEntity.Model -> Outcome Bool
isSuggesting settings =
    findBool ui_suggesting settings.attributes


{-| The list of suggested tags for the field
-}
getSuggestion : SettingsEntity.Model -> Outcome (List String)
getSuggestion settings =
    findListCompactUri ui_suggestion settings.attributes


{-| Search term for filtering the available options
-}
getSearch : StateEntity.Model -> Outcome String
getSearch settings =
    findString ui_search settings.attributes


{-| Help message to highlight an issue with the content
-}
getDangerHelp : StateEntity.Model -> Outcome String
getDangerHelp settings =
    findString ui_dangerHelp settings.attributes
        |> Validation.withinStringCharsRange limitMediumRangeNotEmpty


{-| Some help tip related to the field
-}
getHelp : SettingsEntity.Model -> Outcome String
getHelp settings =
    findString ui_help settings.attributes
        |> Validation.withinStringCharsRange limitMediumRangeNotEmpty


{-| Label related to the field
-}
getLabel : SettingsEntity.Model -> Outcome String
getLabel settings =
    findString ui_label settings.attributes
        |> Validation.withinStringCharsRange limitMediumRangeNotEmpty


{-| Label related to the search field
-}
getSearchLabel : SettingsEntity.Model -> Outcome String
getSearchLabel settings =
    findString ui_searchLabel settings.attributes
        |> Validation.withinStringCharsRange limitSmallRangeNotEmpty


{-| Language used by the user
-}
getUserLanguage : SettingsEntity.Model -> Outcome String
getUserLanguage settings =
    findString ui_userLanguage settings.attributes
        |> Validation.withinStringCharsRange limitSmallRangeNotEmpty


{-| Whether the user is using right to left
-}
isUserRightToLeft : SettingsEntity.Model -> Outcome Bool
isUserRightToLeft settings =
    findBool ui_userRightToLeft settings.attributes


{-| The range of tags accepted for successful content
-}
getSuccessTagRange : SettingsEntity.Model -> Outcome ( Int, Int )
getSuccessTagRange settings =
    findIntRange ( ui_successMinimumTags, ui_successMaximumTags ) settings.attributes
        |> Validation.withinIntRange limitVeryLargeRangeNotEmpty


{-| The range of tags triggering a warning
-}
getDangerTagRange : SettingsEntity.Model -> Outcome ( Int, Int )
getDangerTagRange settings =
    findIntRange ( ui_dangerMinimumTags, ui_dangerMaximumTags ) settings.attributes
        |> Validation.withinIntRange limitVeryLargeRangeNotEmpty


{-| Label of the constituent
-}
getConstituentLabel : SettingsEntity.Model -> String -> Outcome String
getConstituentLabel settings id =
    findStringForId ui_constituentLabel settings.attributes id
        |> Validation.withinStringCharsRange limitMediumRangeNotEmpty


{-| Description of the constituent
-}
getConstituentDescription : SettingsEntity.Model -> String -> Outcome String
getConstituentDescription settings id =
    findStringForId ui_constituentDescription settings.attributes id
        |> Validation.withinStringCharsRange limitMediumRangeNotEmpty


{-| Tag used to describe the constituent
-}
getConstituentTag : SettingsEntity.Model -> String -> Outcome (List String)
getConstituentTag settings id =
    findListStringForId ui_constituentTag settings.attributes id


{-| Tag representing a warning aspect of the constituent
-}
getConstituentWarningTag : SettingsEntity.Model -> String -> Outcome (List String)
getConstituentWarningTag settings id =
    findListStringForId ui_constituentWarningTag settings.attributes id


{-| Tag representing a dangerous aspect of the constituent
-}
getConstituentDangerTag : SettingsEntity.Model -> String -> Outcome (List String)
getConstituentDangerTag settings id =
    findListStringForId ui_constituentDangerTag settings.attributes id
