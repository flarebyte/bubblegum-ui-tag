module Bubblegum.Tag.Vocabulary exposing (..)

{-| List of keys used for the settings

    **Generated** by generate-vocabulary.py

-}


{-| Language of the content. (String)
-}
ui_contentLanguage : String
ui_contentLanguage =
    "ui:content-language"


{-| Whether the content requires right to left. (Bool)
-}
ui_contentRightToLeft : String
ui_contentRightToLeft =
    "ui:content-right-to-left"


{-| The selected tags for the field. (List String)
-}
ui_selected : String
ui_selected =
    "ui:selected"


{-| The selectable tags for the field. (List String)
-}
ui_selectable : String
ui_selectable =
    "ui:selectable"


{-| Suggesting is currently happening. (Bool)
-}
ui_suggesting : String
ui_suggesting =
    "ui:suggesting"


{-| The list of suggested tags for the field. (List String)
-}
ui_suggestion : String
ui_suggestion =
    "ui:suggestion"


{-| Search term for filtering the available options. (String)
-}
ui_search : String
ui_search =
    "ui:search"


{-| Help message to highlight an issue with the content. (String)
-}
ui_dangerHelp : String
ui_dangerHelp =
    "ui:danger-help"


{-| Some help tip related to the field. (String)
-}
ui_help : String
ui_help =
    "ui:help"


{-| Label related to the field. (String)
-}
ui_label : String
ui_label =
    "ui:label"


{-| Label related to the search field. (String)
-}
ui_searchLabel : String
ui_searchLabel =
    "ui:search-label"


{-| Language used by the user. (String)
-}
ui_userLanguage : String
ui_userLanguage =
    "ui:user-language"


{-| Whether the user is using right to left. (Bool)
-}
ui_userRightToLeft : String
ui_userRightToLeft =
    "ui:user-right-to-left"


{-| The minimum number of tags needed for successful content. (Int)
-}
ui_successMinimumTags : String
ui_successMinimumTags =
    "ui:success-minimum-tags"


{-| The maximum number of tags needed for successful content. (Int)
-}
ui_successMaximumTags : String
ui_successMaximumTags =
    "ui:success-maximum-tags"


{-| Warning when under the minimum number of tags. (Int)
-}
ui_dangerMinimumTags : String
ui_dangerMinimumTags =
    "ui:danger-minimum-tags"


{-| Warning when over the maximum number of tags. (Int)
-}
ui_dangerMaximumTags : String
ui_dangerMaximumTags =
    "ui:danger-maximum-tags"


{-| Label of the constituent. (String)
-}
ui_constituentLabel : String
ui_constituentLabel =
    "ui:constituent-label"


{-| Description of the constituent. (String)
-}
ui_constituentDescription : String
ui_constituentDescription =
    "ui:constituent-description"


{-| Tag used to describe the constituent. (List String)
-}
ui_constituentTag : String
ui_constituentTag =
    "ui:constituent-tag"


{-| Tag representing a warning aspect of the constituent. (List String)
-}
ui_constituentWarningTag : String
ui_constituentWarningTag =
    "ui:constituent-warning-tag"


{-| Tag representing a dangerous aspect of the constituent. (List String)
-}
ui_constituentDangerTag : String
ui_constituentDangerTag =
    "ui:constituent-danger-tag"
