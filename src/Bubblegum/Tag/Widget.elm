module Bubblegum.Tag.Widget exposing (view)

{-| A flexible listbox widget to select multiple tags with the following features:

  - Supports multiple languages as well as right to left writing.
  - You can define targets in term of number of tags and display the progress against them.
  - You can add various tags to each choice (ex: warning tag)

Please have a look at the main [documentation](https://github.com/flarebyte/bubblegum-ui-tag) for more details about the possible settings.

@docs view

-}

import Bubblegum.Entity.Outcome as Outcome exposing (Outcome(..))
import Bubblegum.Entity.SettingsEntity as SettingsEntity
import Bubblegum.Entity.StateEntity as StateEntity
import Bubblegum.Tag.Adapter as TagAdapter
import Bubblegum.Tag.BulmaHelper
    exposing
        ( appendHtmlIfSuccess
        , dangerHelp
        , dropdownActiveStatus
        , infoHelp
        , mainBox
        , searchDropdown
        , selectedTags
        , suggestionDropdown
        , widgetLabel
        )
import Bubblegum.Tag.Helper exposing (getRemainingSuggestions)
import Bubblegum.Tag.VocabularyHelper exposing (..)
import Html exposing (..)


{-| View for the widget

    attr key value = { id = Nothing , key = key, facets = [], values = [value]}

    adapter =  =
        { onSearchInput = OnSearchInput
        , onToggleDropbox = OnToggleDropbox
        , onAddTag = OnAddTag
        , onDeleteTag = OnDeleteTag
        }

    userSettings = { attributes = [attr ui_userLanguage "en-US"] }
    settings = { attributes = [attr ui_label "My Story"] ++ getExampleAttributes }
    state = { attributes = [ attr ui_suggesting "true" , attrs ui_selected [ "id:suggestion:1", "id:suggestion:3" ]] }

    view adapter userSettings settings state

-}
view : TagAdapter.Model msg -> SettingsEntity.Model -> SettingsEntity.Model -> StateEntity.Model -> Html msg
view adapter userSettings settings state =
    let
        addLabel =
            appendHtmlIfSuccess widgetLabel (getLabel settings)

        addHelp =
            appendHtmlIfSuccess infoHelp (getHelp settings)

        addDangerHelp =
            appendHtmlIfSuccess dangerHelp (getDangerHelp state)

        addSearchLabel =
            getSearchLabel settings

        suggestions =
            getRemainingSuggestions settings state

        isDropdownActive =
            isSuggesting state |> Outcome.toMaybe |> Maybe.withDefault False |> dropdownActiveStatus
    in
    mainBox (getUserLanguage userSettings)
        (isUserRightToLeft userSettings)
        ([ selectedTags adapter userSettings settings state ]
            ++ addLabel []
            ++ [ div [ isDropdownActive ]
                    [ searchDropdown addSearchLabel adapter
                    , suggestionDropdown adapter userSettings settings suggestions
                    ]
               ]
            |> addDangerHelp
            |> addHelp
        )
