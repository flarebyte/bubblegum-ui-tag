module WidgetDocData exposing (tagWidgetDoc)

import AttributeDoc exposing (AttributeDoc, Cardinality(..), createKey)
import Bubblegum.Tag.Vocabulary exposing (..)
import KeyDescription exposing (..)
import WidgetDoc exposing (..)
import WidgetPackageJson


{-| Some examples of settings for the demo.

    **Generated** by generate-vocabulary.py

-}
tagWidgetDoc : WidgetDoc
tagWidgetDoc =
    { meta = WidgetPackageJson.meta
    , userSettings =
        [ createKey ui_contentRightToLeft ZeroOrOne [ "true", "false", "other" ] descContentRightToLeft
        , createKey ui_userLanguage ZeroOrOne [ "en-GB", "ja", "ar", "zh-CN-SC", "ru-RUS", "es", "it", "fr", "other" ] descUserLanguage
        , createKey ui_userRightToLeft ZeroOrOne [ "true", "false", "other" ] descUserRightToLeft
        ]
    , settings =
        [ createKey ui_suggestion ZeroOrOne [ "id:suggestion:1", "id:suggestion:2", "id:suggestion:3", "other" ] descSuggestion
        , createKey ui_help ZeroOrOne [ "Lorem ipsum dolor sit amet consectetur adipiscing elit.", "助けて", "other" ] descHelp
        , createKey ui_label ZeroOrOne [ "Some label", "ラベル", "ضع الكلمة المناسبة", "other" ] descLabel
        , createKey ui_searchLabel ZeroOrOne [ "Search", "搜索", "пошук", "other" ] descSearchLabel
        , createKey ui_successMinimumTags ZeroOrOne [ "0", "2", "4", "8", "16", "32", "-5" ] descSuccessMinimumTags
        , createKey ui_successMaximumTags ZeroOrOne [ "0", "2", "4", "8", "16", "32", "-5" ] descSuccessMaximumTags
        , createKey ui_dangerMinimumTags ZeroOrOne [ "0", "2", "4", "8", "16", "32", "-5" ] descDangerMinimumTags
        , createKey ui_dangerMaximumTags ZeroOrOne [ "0", "2", "4", "8", "16", "32", "-5" ] descDangerMaximumTags
        ]
    , stateAttributes =
        [ createKey ui_selected ZeroOrOne [ "id:suggestion:1", "other" ] descSelected
        , createKey ui_suggesting ZeroOrOne [ "true", "false", "other" ] descSuggesting
        , createKey ui_search ZeroOrOne [ "ipsum", "dolor", "other" ] descSearch
        , createKey ui_dangerHelp ZeroOrOne [ "do not do this", "other" ] descDangerHelp
        ]
    }
