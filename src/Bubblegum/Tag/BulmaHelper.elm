module Bubblegum.Tag.BulmaHelper exposing (..)

{-| The Bulma css framework is used for styling the widget.

See <https://bulma.io/documentation/>

This helper facilitates the creation of Bulma styled html elements.

-}

import Bubblegum.Entity.Outcome as Outcome exposing (..)
import Bubblegum.Entity.SettingsEntity as SettingsEntity
import Bubblegum.Entity.StateEntity as StateEntity
import Bubblegum.Tag.Internationalization exposing (..)
import Bubblegum.Tag.IsoLanguage exposing (IsoLanguage(..), toIsoLanguage)
import Bubblegum.Tag.VocabularyHelper exposing (..)
import Debug as Debug
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import List
import String exposing (join, lines, words)
import Tuple exposing (first, second)


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


asClass3 : String -> String -> String -> Attribute msg
asClass3 a b c =
    [ c, b, a ] |> asClass


progressBar : ( String, String ) -> Html msg
progressBar tuple =
    progress [ second tuple |> asClass3 "progress" "is-small", Attributes.max "100", first tuple |> value ]
        [ text (first tuple ++ "%") ]


styledIcon : String -> String -> Html msg
styledIcon iconName iconTextStyle =
    span [ asClass2 "icon" iconTextStyle ]
        [ i [ asClass2 "fas" iconName ]
            []
        ]


tag : StyledText -> Html msg
tag tagInfo =
    span [ asClass2 "tag" tagInfo.style, Attributes.title tagInfo.title ]
        [ text tagInfo.text ]


tagsAddons : List (Html msg) -> Html msg
tagsAddons list =
    div [ class "tags has-addons" ] list


tags : List (Html msg) -> Html msg
tags list =
    div [ class "tags" ] list


infoText : IsoLanguage -> String -> StyledText
infoText userIsoLanguage text =
    { text = text
    , style = "is-dark"
    , title = translateInfoTag userIsoLanguage
    }


infoText2 : IsoLanguage -> String -> StyledText
infoText2 userIsoLanguage text =
    { text = text
    , style = "is-primary"
    , title = translateInfoTag userIsoLanguage
    }


successTagText : IsoLanguage -> String -> StyledText
successTagText userIsoLanguage text =
    { text = text
    , style = "is-success"
    , title = translateSuccessTag userIsoLanguage
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


tagsSuccess : IsoLanguage -> List String -> List (Html msg)
tagsSuccess userIsoLanguage list =
    list |> List.map (successTagText userIsoLanguage) |> List.map tag


tagsWarning : IsoLanguage -> List String -> List (Html msg)
tagsWarning userIsoLanguage list =
    list |> List.map (warningTagText userIsoLanguage) |> List.map tag


tagsDanger : IsoLanguage -> List String -> List (Html msg)
tagsDanger userIsoLanguage list =
    list |> List.map (dangerTagText userIsoLanguage) |> List.map tag


groupFields : List (Html msg) -> Html msg
groupFields list =
    div [ class "field is-grouped is-grouped-multiline" ] list


rtlOrLtr : Bool -> String
rtlOrLtr value =
    if value then
        "rtl"
    else
        "ltr"


mainBox : Outcome String -> Outcome Bool -> List (Html msg) -> Html msg
mainBox language rtl list =
    div
        ([ class "bubblegum-tag__widget box is-marginless is-paddingless is-shadowless has-addons" ]
            |> appendAttributeIfSuccess lang language
            |> appendAttributeIfSuccess dir (rtl |> Outcome.map rtlOrLtr)
        )
        [ div [ class "field" ] list
        ]


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


searchDropdown =
    div [ class "dropdown-trigger" ]
        [ button [ attribute "aria-controls" "dropdown-menu2", attribute "aria-haspopup" "true", class "button" ]
            [ span []
                [ text "Content" ]
            , span [ class "icon is-small" ]
                [ i [ attribute "aria-hidden" "true", class "fas fa-angle-down" ]
                    []
                ]
            ]
        ]


dropdownMenu : List (Html msg) -> Html msg
dropdownMenu list =
    div [ class "dropdown-menu", attribute "role" "menu" ]
        [ div [ class "dropdown-content scrollable" ] list
        ]


suggestionDropbox : IsoLanguage -> SettingsEntity.Model -> List String -> Html msg
suggestionDropbox userIsoLanguage settings suggestionsIds =
    suggestionsIds |> List.map (\id -> suggestionTag userIsoLanguage settings id) |> dropdownMenu


suggestionDropboxMain : IsoLanguage -> SettingsEntity.Model -> List String -> Html msg
suggestionDropboxMain userIsoLanguage settings suggestionsIds =
    div [ asClass2 "dropdown" "is-active" ]
        [ searchDropdown
        , suggestionDropbox userIsoLanguage settings suggestionsIds
        ]


suggestionTag : IsoLanguage -> SettingsEntity.Model -> String -> Html msg
suggestionTag userIsoLanguage settings id =
    let
        addLabel =
            appendHtmlIfSuccess text (getConstituentLabel settings id |> Debug.log "label")

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
        [ div []
            [ div [] [ span [ class "is-size-6" ] ([] |> addLabel) ]
            , div [] [ span [ class "is-size-7 has-text-info" ] ([] |> addDescription) ]
            , tags ([] |> addTagsDanger |> addTagsWarning |> addTagsInfo)
            ]
        ]
