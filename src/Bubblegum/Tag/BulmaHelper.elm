module Bubblegum.Tag.BulmaHelper
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

{-| The Bulma css framework is used for styling the widget.

See <https://bulma.io/documentation/>

This helper facilitates the creation of Bulma styled html elements.

-}

import Bubblegum.Entity.Outcome as Outcome exposing (Outcome(..))
import Bubblegum.Entity.SettingsEntity as SettingsEntity
import Bubblegum.Entity.StateEntity as StateEntity
import Bubblegum.Tag.Adapter as TagAdapter
import Bubblegum.Tag.Helper
    exposing
        ( ProgressStatus(..)
        , dangerRange
        , getSelectedAsList
        , getUserIsoLanguage
        , successRange
        , tagStyle
        , textStyle
        , themeProgress
        )
import Bubblegum.Tag.Internationalization exposing (translateDangerTag, translateInfoTag, translateWarningTag)
import Bubblegum.Tag.IsoLanguage exposing (IsoLanguage(..))
import Bubblegum.Tag.VocabularyHelper exposing (..)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import List
import String exposing (join)


{-| Append some html code when the outcome is successful otherwise hide a warning in the html
-}
appendHtmlIfSuccess : (a -> Html.Html msg) -> Outcome a -> List (Html.Html msg) -> List (Html.Html msg)
appendHtmlIfSuccess ifSuccess outcome htmlList =
    case outcome of
        None ->
            htmlList

        Warning warn ->
            htmlList ++ [ div [ Attributes.class "is-invisible warning" ] [ text warn ] ]

        Valid success ->
            htmlList ++ [ ifSuccess success ]


{-| Append a list of html code when the outcome is successful otherwise hide a warning in the html
-}
appendListHtmlIfSuccess : (a -> List (Html.Html msg)) -> Outcome a -> List (Html.Html msg) -> List (Html.Html msg)
appendListHtmlIfSuccess ifSuccess outcome htmlList =
    case outcome of
        None ->
            htmlList

        Warning warn ->
            htmlList ++ [ div [ Attributes.class "is-invisible warning" ] [ text warn ] ]

        Valid success ->
            htmlList ++ ifSuccess success


{-| Append a html attribute when the outcome is successful otherwise hide a warning in the html
-}
appendAttributeIfSuccess : (a -> Attribute msg) -> Outcome a -> List (Attribute msg) -> List (Attribute msg)
appendAttributeIfSuccess ifSuccess outcome attributes =
    case outcome of
        None ->
            attributes

        Warning warn ->
            attributes ++ [ attribute "data-bubblegum-warn" warn ]

        Valid success ->
            attributes ++ [ ifSuccess success ]



-- Various helpers


type alias StyledText =
    { text : String
    , style : String
    , title : String
    }


asClass : List String -> Attribute msg
asClass list =
    List.reverse list |> join " " |> class


asClass2 : String -> String -> Attribute msg
asClass2 a b =
    [ b, a ] |> asClass


tag : StyledText -> Html msg
tag tagInfo =
    span [ asClass2 "tag" tagInfo.style, Attributes.title tagInfo.title ]
        [ text tagInfo.text ]


tags : List (Html msg) -> Html msg
tags list =
    div [ class "tags" ] list


tagsGroup : SettingsEntity.Model -> SettingsEntity.Model -> StateEntity.Model -> List (Html msg) -> Html msg
tagsGroup userSettings settings state list =
    let
        userIsoLanguage =
            getUserIsoLanguage userSettings

        numberOfTags =
            getSelectedAsList state |> List.length

        themeBasedOnRange =
            themeProgress (Outcome.map2 successRange (Valid numberOfTags) <| getSuccessTagRange settings)
                (Outcome.map2 dangerRange (Valid numberOfTags) <| getDangerTagRange settings)
                |> Outcome.toMaybe
                |> Maybe.withDefault IsNeutral
    in
    div []
        [ div [ class "field is-grouped is-grouped-multiline" ] list
        , div []
            [ p [ class "is-size-6" ]
                [ coloredText userIsoLanguage (toString numberOfTags) (themeBasedOnRange |> tagStyle) |> tag
                , span [] [ text " " ]
                , span [ class (themeBasedOnRange |> textStyle) ] [ text (String.repeat numberOfTags "•") ]
                ]
            ]
        ]


infoText : IsoLanguage -> String -> StyledText
infoText userIsoLanguage text =
    { text = text
    , style = "is-dark"
    , title = translateInfoTag userIsoLanguage
    }


coloredText : IsoLanguage -> String -> String -> StyledText
coloredText userIsoLanguage text style =
    { text = text
    , style = style
    , title = translateInfoTag userIsoLanguage
    }


warningTagText : IsoLanguage -> String -> StyledText
warningTagText userIsoLanguage text =
    { text = text
    , style = "is-warning"
    , title = translateWarningTag userIsoLanguage
    }


dangerTagText : IsoLanguage -> String -> StyledText
dangerTagText userIsoLanguage text =
    { text = text
    , style = "is-danger"
    , title = translateDangerTag userIsoLanguage
    }


tagsInfo : IsoLanguage -> List String -> List (Html msg)
tagsInfo userIsoLanguage list =
    list |> List.map (infoText userIsoLanguage) |> List.map tag


tagsWarning : IsoLanguage -> List String -> List (Html msg)
tagsWarning userIsoLanguage list =
    list |> List.map (warningTagText userIsoLanguage) |> List.map tag


tagsDanger : IsoLanguage -> List String -> List (Html msg)
tagsDanger userIsoLanguage list =
    list |> List.map (dangerTagText userIsoLanguage) |> List.map tag


rtlOrLtr : Bool -> String
rtlOrLtr value =
    if value then
        "rtl"
    else
        "ltr"


mainBox : Outcome String -> Outcome Bool -> List (Html msg) -> Html msg
mainBox language rtl list =
    div
        ([ class "bubblegum-tag__widget box is-marginless is-paddingless is-shadowless" ]
            |> appendAttributeIfSuccess lang language
            |> appendAttributeIfSuccess dir (rtl |> Outcome.map rtlOrLtr)
        )
        list


widgetLabel : String -> Html msg
widgetLabel widgetText =
    label [ class "label" ] [ text widgetText ]


infoHelp : String -> Html msg
infoHelp helpText =
    p [ asClass2 "help" "is-info" ]
        [ text helpText ]


dangerHelp : String -> Html msg
dangerHelp helpText =
    p [ asClass2 "help" "is-danger" ]
        [ text helpText ]


searchDropdown : Outcome String -> TagAdapter.Model msg -> Html msg
searchDropdown searchLabel adapter =
    div [ class "dropdown-trigger" ]
        [ div [ class "level" ]
            [ div [ class "field has-addons" ]
                [ p [ class "control has-icons-left" ]
                    [ input [ class "input", onInput adapter.onSearchInput ]
                        []
                    , span [ class "icon is-small is-left" ]
                        [ i [ class "fas fa-search" ]
                            []
                        ]
                    ]
                , p [ class "control" ]
                    [ button
                        [ attribute "aria-haspopup" "true"
                        , class "button"
                        , onClick adapter.onToggleDropbox
                        ]
                        [ span []
                            ([] |> appendHtmlIfSuccess text searchLabel)
                        , span [ class "icon is-small" ]
                            [ i [ attribute "aria-hidden" "true", class "fas fa-angle-down" ]
                                []
                            ]
                        ]
                    ]
                ]
            ]
        ]


dropdownMenu : SettingsEntity.Model -> List (Html msg) -> Html msg
dropdownMenu userSettings list =
    let
        addContentRtl =
            appendAttributeIfSuccess dir <| (isContentRightToLeft userSettings |> Outcome.map rtlOrLtr)
    in
    div [ class "dropdown-menu", attribute "role" "menu" ]
        [ div ([ class "dropdown-content scrollable" ] |> addContentRtl) list
        ]


suggestionDropdown : TagAdapter.Model msg -> SettingsEntity.Model -> SettingsEntity.Model -> Outcome (List String) -> Html msg
suggestionDropdown adapter userSettings settings outcomeSuggestionIds =
    let
        userIsoLanguage =
            getUserIsoLanguage userSettings

        anySuggestionTag =
            suggestionTag adapter userIsoLanguage settings

        addSuggestions =
            appendListHtmlIfSuccess (\list -> List.map anySuggestionTag list) outcomeSuggestionIds
    in
    ([] |> addSuggestions) |> dropdownMenu userSettings


suggestionTag : TagAdapter.Model msg -> IsoLanguage -> SettingsEntity.Model -> String -> Html msg
suggestionTag adapter userIsoLanguage settings id =
    let
        addLabel =
            appendHtmlIfSuccess text (getConstituentLabel settings id)

        addDescription =
            appendHtmlIfSuccess text (getConstituentDescription settings id)

        addTagsInfo =
            appendListHtmlIfSuccess (tagsInfo userIsoLanguage) (getConstituentTag settings id)

        addTagsWarning =
            appendListHtmlIfSuccess (tagsWarning userIsoLanguage) (getConstituentWarningTag settings id)

        addTagsDanger =
            appendListHtmlIfSuccess (tagsDanger userIsoLanguage) (getConstituentDangerTag settings id)
    in
    a [ class "dropdown-item" ]
        [ div [ onClick (adapter.onAddTag id) ]
            [ div [] [ span [ class "is-size-6" ] ([] |> addLabel) ]
            , div [] [ span [ class "is-size-7 has-text-info" ] ([] |> addDescription) ]
            , tags ([] |> addTagsDanger |> addTagsWarning |> addTagsInfo)
            ]
        ]


dropdownActiveStatus : Bool -> Attribute msg
dropdownActiveStatus value =
    if value then
        asClass2 "dropdown" "is-active"
    else
        class "dropdown"



-- selected


selectedTag : TagAdapter.Model msg -> SettingsEntity.Model -> String -> Html msg
selectedTag adapter settings id =
    let
        addLabel =
            appendHtmlIfSuccess text (getConstituentLabel settings id)

        addDescription =
            appendAttributeIfSuccess title (getConstituentDescription settings id)
    in
    div [ class "control" ]
        [ div [ class "tags has-addons", onClick (adapter.onDeleteTag id) ]
            [ span ([ class "tag is-primary" ] |> addDescription)
                ([] |> addLabel)
            , span [ class "tag is-delete" ]
                []
            ]
        ]


selectedTags : TagAdapter.Model msg -> SettingsEntity.Model -> SettingsEntity.Model -> StateEntity.Model -> Html msg
selectedTags adapter userSettings settings state =
    let
        selectedIds =
            getSelected state |> Outcome.toMaybe |> Maybe.withDefault []
    in
    selectedIds |> List.map (\id -> selectedTag adapter settings id) |> tagsGroup userSettings settings state
