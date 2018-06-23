module App exposing (..)

{-| App


# Basics

@docs

-}

import AppModel exposing (..)
import AppMsg exposing (AppMsg(..))
import Bubblegum.Entity.Attribute exposing (deleteAttributeByKey, replaceAttributeByKey)
import Bubblegum.Entity.SettingsEntity as SettingsEntity
import Bubblegum.Entity.StateEntity as StateEntity
import Bubblegum.Tag.Vocabulary exposing (..)
import Debug as Debug
import Html exposing (..)
import Html.Attributes exposing (..)
import WidgetBuilder exposing (viewWidget)
import WidgetDocView exposing (..)


main : Program Never AppModel AppMsg
main =
    Html.beginnerProgram
        { model = AppModel.reset
        , view = view
        , update = update
        }



-- UPDATE


update : AppMsg -> AppModel -> AppModel
update msg model =
    case msg of
        OnSearchInputContent value ->
            replaceAttributeByKey ui_search [ value ] model.state.attributes
                |> StateEntity.asAttributesIn model.state
                |> asStateIn model

        OnSelectSetting isUser key value ->
            replaceAttributeByKey key [ value ] (getSettingsAttributes isUser model)
                |> SettingsEntity.asAttributesIn (getSettings isUser model)
                |> asSettingsIn isUser model

        OnSelectState key value ->
            replaceAttributeByKey key [ value ] (getStateAttributes model)
                |> StateEntity.asAttributesIn (getState model)
                |> asStateIn model

        OnActivateSetting isUser key ->
            deleteAttributeByKey key (getSettingsAttributes isUser model)
                |> SettingsEntity.asAttributesIn (getSettings isUser model)
                |> asSettingsIn isUser model

        OnActivateState key ->
            deleteAttributeByKey key (getStateAttributes model)
                |> StateEntity.asAttributesIn (getState model)
                |> asStateIn model

        OnToggleDropbox ->
            replaceAttributeByKey ui_suggesting [ notSuggesting model.state ] model.state.attributes
                |> StateEntity.asAttributesIn model.state
                |> asStateIn model

        OnAddTag tagId ->
            replaceAttributeByKey ui_selected (addTagIdToSelected tagId model.state) model.state.attributes
                |> StateEntity.asAttributesIn model.state
                |> asStateIn model

        OnDeleteTag tagId ->
            replaceAttributeByKey ui_selected (deleteTagIdToSelected tagId model.state) model.state.attributes
                |> StateEntity.asAttributesIn model.state
                |> asStateIn model



-- VIEW


view : AppModel -> Html AppMsg
view model =
    section [ class "section" ]
        [ viewHeader
        , div [ class "container" ] [ p [] [ text " ... " ] ]
        , div [ class "columns" ]
            [ div [ class "column is-three-fifths" ]
                [ viewWidget model ]
            , div [ class "column" ]
                [ viewSettings model ]
            ]
        , div [ class "container" ] [ p [] [ text " ... " ] ]
        ]
