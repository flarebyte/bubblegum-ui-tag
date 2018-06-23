module WidgetCreateTests exposing (..)

{-| Unit tests for testing the view of the Widget

    **Generated** by generate-vocabulary.py
    
-}
import Test exposing (..)
import WidgetTestData exposing (..)


suite : Test
suite =
    describe "The Widget module"
        [ describe "Widget.view"
            [

                fuzz fuzzyContentRightToLeft "Correct settings for Whether the content requires right to left" <|
                \value -> viewWidgetWithUserSettings (withUserSettingsContentRightToLeft value)
                    |> findComponent selectorsContentRightToLeft

             , fuzz fuzzyNotContentRightToLeft "Wrong settings for Whether the content requires right to left" <|
                \value -> viewWidgetWithUserSettings (withUserSettingsContentRightToLeft value) 
                    |> findComponent selectorsNotContentRightToLeft

                , fuzz fuzzySelected "Correct settings for The selected tags for the field" <|
                \value -> viewWidgetWithState (withStateSelected value)
                    |> findComponent selectorsSelected

                , fuzz fuzzySuggesting "Correct settings for Suggesting is currently happening" <|
                \value -> viewWidgetWithState (withStateSuggesting value)
                    |> findComponent selectorsSuggesting

                , fuzz fuzzySuggestion "Correct settings for The list of suggested tags for the field" <|
                \value -> viewWidgetWithSettings (withSettingsSuggestion value)
                    |> findComponent selectorsSuggestion

              , fuzz fuzzyNotSuggestion "Wrong settings for The list of suggested tags for the field" <|
                \value -> viewWidgetWithSettings (withSettingsSuggestion value)
                    |> findWarningDiv           

                , fuzz fuzzySearch "Correct settings for Search term for filtering the available options" <|
                \value -> viewWidgetWithState (withStateSearch value)
                    |> findComponent selectorsSearch

                , fuzz fuzzyDangerHelp "Correct settings for Help message to highlight an issue with the content" <|
                \value -> viewWidgetWithState (withStateDangerHelp value)
                    |> findComponent selectorsDangerHelp

                , fuzz fuzzyHelp "Correct settings for Some help tip related to the field" <|
                \value -> viewWidgetWithSettings (withSettingsHelp value)
                    |> findComponent selectorsHelp

              , fuzz fuzzyNotHelp "Wrong settings for Some help tip related to the field" <|
                \value -> viewWidgetWithSettings (withSettingsHelp value)
                    |> findWarningDiv           

                , fuzz fuzzyLabel "Correct settings for Label related to the field" <|
                \value -> viewWidgetWithSettings (withSettingsLabel value)
                    |> findComponent selectorsLabel

              , fuzz fuzzyNotLabel "Wrong settings for Label related to the field" <|
                \value -> viewWidgetWithSettings (withSettingsLabel value)
                    |> findWarningDiv           

                , fuzz fuzzySearchLabel "Correct settings for Label related to the search field" <|
                \value -> viewWidgetWithSettings (withSettingsSearchLabel value)
                    |> findComponent selectorsSearchLabel

              , fuzz fuzzyNotSearchLabel "Wrong settings for Label related to the search field" <|
                \value -> viewWidgetWithSettings (withSettingsSearchLabel value)
                    |> findWarningDiv           

                , fuzz fuzzyUserLanguage "Correct settings for Language used by the user" <|
                \value -> viewWidgetWithUserSettings (withUserSettingsUserLanguage value)
                    |> findComponent selectorsUserLanguage

             , fuzz fuzzyNotUserLanguage "Wrong settings for Language used by the user" <|
                \value -> viewWidgetWithUserSettings (withUserSettingsUserLanguage value) 
                    |> findComponent selectorsNotUserLanguage

                , fuzz fuzzyUserRightToLeft "Correct settings for Whether the user is using right to left" <|
                \value -> viewWidgetWithUserSettings (withUserSettingsUserRightToLeft value)
                    |> findComponent selectorsUserRightToLeft

             , fuzz fuzzyNotUserRightToLeft "Wrong settings for Whether the user is using right to left" <|
                \value -> viewWidgetWithUserSettings (withUserSettingsUserRightToLeft value) 
                    |> findComponent selectorsNotUserRightToLeft

                , fuzz fuzzySuccessMinimumTags "Correct settings for The minimum number of tags needed for successful content" <|
                \value -> viewWidgetWithSettings (withSettingsSuccessMinimumTags value)
                    |> findComponent selectorsSuccessMinimumTags

              , fuzz fuzzyNotSuccessMinimumTags "Wrong settings for The minimum number of tags needed for successful content" <|
                \value -> viewWidgetWithSettings (withSettingsSuccessMinimumTags value)
                    |> findWarningDiv           

                , fuzz fuzzySuccessMaximumTags "Correct settings for The maximum number of tags needed for successful content" <|
                \value -> viewWidgetWithSettings (withSettingsSuccessMaximumTags value)
                    |> findComponent selectorsSuccessMaximumTags

              , fuzz fuzzyNotSuccessMaximumTags "Wrong settings for The maximum number of tags needed for successful content" <|
                \value -> viewWidgetWithSettings (withSettingsSuccessMaximumTags value)
                    |> findWarningDiv           

                , fuzz fuzzyDangerMinimumTags "Correct settings for Warning when under the minimum number of tags" <|
                \value -> viewWidgetWithSettings (withSettingsDangerMinimumTags value)
                    |> findComponent selectorsDangerMinimumTags

              , fuzz fuzzyNotDangerMinimumTags "Wrong settings for Warning when under the minimum number of tags" <|
                \value -> viewWidgetWithSettings (withSettingsDangerMinimumTags value)
                    |> findWarningDiv           

                , fuzz fuzzyDangerMaximumTags "Correct settings for Warning when over the maximum number of tags" <|
                \value -> viewWidgetWithSettings (withSettingsDangerMaximumTags value)
                    |> findComponent selectorsDangerMaximumTags

              , fuzz fuzzyNotDangerMaximumTags "Wrong settings for Warning when over the maximum number of tags" <|
                \value -> viewWidgetWithSettings (withSettingsDangerMaximumTags value)
                    |> findWarningDiv           

            ]
        ]
