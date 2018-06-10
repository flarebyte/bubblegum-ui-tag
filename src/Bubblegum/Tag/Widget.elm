module Bubblegum.Tag.Widget exposing (view)

{-| A flexible tag widget with the following features:

  - Supports multiple languages as well as right to left writing.
  - The widget and the content do not have to use the same language.
  - You can define targets in term of number of characters or words, and display the progress against them.
  - You can add various tags to describe the content or the status of the content (ex: warning tag)

Please have a look at the main [documentation](https://github.com/flarebyte/bubblegum-ui-tag) for more details about the possible settings.

@docs view

-}

import Bubblegum.Entity.Outcome as Outcome exposing (..)
import Bubblegum.Entity.SettingsEntity as SettingsEntity
import Bubblegum.Entity.StateEntity as StateEntity
import Bubblegum.Tag.Adapter as TagAdapter
import Bubblegum.Tag.BulmaHelper exposing (..)
import Bubblegum.Tag.Helper exposing (getUserIsoLanguage)
import Bubblegum.Tag.VocabularyHelper exposing (..)
import Bubblegum.Tag.WidgetAssistant exposing (deduceSelectable)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput, onMouseEnter, onMouseOut)


{-| View for the widget

    attr key value = { id = Nothing , key = key, facets = [], values = [value]}

    adapter = { onInput = OnInputContent }
    userSettings = { attributes = [attr ui_userLanguage "en-US"] }
    settings = { attributes = [attr ui_label "My Story"] }
    state = { attributes = [attr ui_content "Once upon a time ..."] }

    view adapter userSettings settings state

-}
view : TagAdapter.Model msg -> SettingsEntity.Model -> SettingsEntity.Model -> StateEntity.Model -> Html msg
view adapter userSettings settings state =
    let
        addContentId =
            appendAttributeIfSuccess id (getContentId state)

        addContentLanguage =
            appendAttributeIfSuccess lang (getContentLanguage userSettings)

        addContentRtl =
            appendAttributeIfSuccess dir <| (isContentRightToLeft userSettings |> Outcome.map rtlOrLtr)

        addLabel =
            appendHtmlIfSuccess widgetLabel (getLabel settings)

        addHelp =
            appendHtmlIfSuccess infoHelp (getHelp settings)

        addDangerHelp =
            appendHtmlIfSuccess dangerHelp (getDangerHelp state)

        suggestions =
            getSuggestion settings

        userIsoLanguage =
            getUserIsoLanguage userSettings

        isDropdownActive =
            isSuggesting state |> Outcome.toMaybe |> Maybe.withDefault False |> dropdownActiveStatus
    in
    mainBox (getUserLanguage userSettings)
        (isUserRightToLeft userSettings)
        ([ selectedTags adapter userSettings settings state ]
            ++ addLabel []
            ++ [ div [ isDropdownActive ]
                    [ searchDropdown adapter
                    , suggestionDropdown adapter userIsoLanguage settings suggestions
                    ]
               ]
            |> addDangerHelp
            |> addHelp
        )
