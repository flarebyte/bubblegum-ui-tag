module WidgetDocView exposing (..)

import AppModel exposing (AppModel, getSettings, getState)
import AppMsg exposing (AppMsg(..))
import AttributeDoc exposing (AttributeDoc, Cardinality(..), createKey)
import Bubblegum.Entity.Attribute exposing (findAttributeFirstValueByKey)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import WidgetDocData exposing (tagWidgetDoc)


type Change
    = SettingsChange
    | UserSettingChange
    | StateChange


viewHeader : Html msg
viewHeader =
    div []
        [ h1 [ class "title" ]
            [ text (tagWidgetDoc.meta.exposedModules |> List.head |> Maybe.withDefault "?") ]
        , h2 [ class "subtitle" ]
            [ text tagWidgetDoc.meta.summary
            ]
        , div
            [ class "field is-grouped is-grouped-multiline" ]
            [ div [ class "control" ]
                [ div [ class "tags has-addons" ]
                    [ span [ class "tag is-dark" ]
                        [ text "version" ]
                    , span [ class "tag is-info" ]
                        [ text tagWidgetDoc.meta.version ]
                    ]
                ]
            , div [ class "control" ]
                [ div [ class "tags has-addons" ]
                    [ span [ class "tag is-dark" ]
                        [ text "license" ]
                    , span [ class "tag is-success" ]
                        [ text tagWidgetDoc.meta.license ]
                    ]
                ]
            , div [ class "control" ]
                [ a [ class "button is-small", href tagWidgetDoc.meta.repository ]
                    [ span [ class "icon is-small" ]
                        [ i [ class "fab fa-github" ]
                            []
                        ]
                    , span []
                        [ text "GitHub" ]
                    ]
                ]
            ]
        ]


viewRadioItem : Bool -> String -> Maybe String -> String -> Html AppMsg
viewRadioItem isUserSettings key actual value =
    let
        labelStyle =
            actual
                |> Maybe.map
                    (\v ->
                        if v == value then
                            "has-text-success has-text-weight-bold"
                        else
                            ""
                    )
                |> Maybe.withDefault ""
    in
    label [ class "radio" ]
        [ input [ name key, type_ "radio", onClick (OnSelectSetting isUserSettings key value) ]
            []
        , span [ class labelStyle ] [ text value ]
        ]


viewRadioItemForState : String -> Maybe String -> String -> Html AppMsg
viewRadioItemForState key actual value =
    let
        labelStyle =
            actual
                |> Maybe.map
                    (\v ->
                        if v == value then
                            "has-text-success has-text-weight-bold"
                        else
                            ""
                    )
                |> Maybe.withDefault ""
    in
    label [ class "radio" ]
        [ input [ name key, type_ "radio", onClick (OnSelectState key value) ]
            []
        , span [ class labelStyle ] [ text value ]
        ]


viewSelectedBox : Bool -> String -> Html AppMsg
viewSelectedBox isUserSettings key =
    button [ class "button", onClick (OnActivateSetting isUserSettings key) ]
        [ span [ class "icon is-small" ]
            [ i [ class "fas fa-trash" ]
                []
            ]
        ]


viewSelectedBoxForState : String -> Html AppMsg
viewSelectedBoxForState key =
    button [ class "button", onClick (OnActivateState key) ]
        [ span [ class "icon is-small" ]
            [ i [ class "fas fa-trash" ]
                []
            ]
        ]


viewRadioSettings : AppModel -> Bool -> AttributeDoc -> Html AppMsg
viewRadioSettings model isUserSettings attrDoc =
    let
        actualSettings =
            getSettings isUserSettings model

        actualValue =
            findAttributeFirstValueByKey attrDoc.key actualSettings.attributes
    in
    attrDoc.suggestions |> List.map (viewRadioItem isUserSettings attrDoc.key actualValue) |> div [ class "control" ]


viewRadioSettingsForState : AppModel -> AttributeDoc -> Html AppMsg
viewRadioSettingsForState model attrDoc =
    let
        actualState =
            getState model

        actualValue =
            findAttributeFirstValueByKey attrDoc.key actualState.attributes
    in
    attrDoc.suggestions |> List.map (viewRadioItemForState attrDoc.key actualValue) |> div [ class "control" ]


viewRadioSettingsWithLabel : AppModel -> Bool -> AttributeDoc -> Html AppMsg
viewRadioSettingsWithLabel model isUserSettings attrDoc =
    div [ class "field" ]
        [ label [ class "label" ]
            [ text attrDoc.key ]
        , viewRadioSettings model isUserSettings attrDoc
        , viewSelectedBox isUserSettings attrDoc.key
        , p [ class "help is-info" ]
            [ text attrDoc.description ]
        ]


viewRadioSettingsWithLabelForState : AppModel -> AttributeDoc -> Html AppMsg
viewRadioSettingsWithLabelForState model attrDoc =
    div [ class "field" ]
        [ label [ class "label" ]
            [ text attrDoc.key ]
        , viewRadioSettingsForState model attrDoc
        , viewSelectedBoxForState attrDoc.key
        , p [ class "help is-info" ]
            [ text attrDoc.description ]
        ]


viewSettings : AppModel -> Html AppMsg
viewSettings model =
    div [ class "box scrollable" ]
        [ h3 [ class "title is-3" ] [ text "State" ]
        , h4 [ class "subtitle is-4" ] [ text "Attributes that can be changed at runtime" ]
        , div [ class "box" ] (tagWidgetDoc.stateAttributes |> List.map (viewRadioSettingsWithLabelForState model))
        , h3 [ class "title is-3" ] [ text "User Settings" ]
        , h4 [ class "subtitle is-4" ] [ text "Attributes attached to the current profile" ]
        , div [ class "box" ] (tagWidgetDoc.userSettings |> List.map (viewRadioSettingsWithLabel model True))
        , h3 [ class "title is-3" ] [ text "Settings" ]
        , h4 [ class "subtitle is-4" ] [ text "Attributes of the widget" ]
        , div [ class "box" ] (tagWidgetDoc.settings |> List.map (viewRadioSettingsWithLabel model False))
        ]
