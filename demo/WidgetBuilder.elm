module WidgetBuilder exposing (viewWidget)

import AppModel exposing (AppModel)
import AppMsg exposing (AppMsg(..))
import Bubblegum.Tag.Adapter as Adapter
import Bubblegum.Tag.Widget as Widget
import Html exposing (..)


adapter : Adapter.Model AppMsg
adapter =
    { onSearchInput = OnSearchInputContent
    , onToggleDropbox = OnToggleDropbox
    , onAddTag = OnAddTag
    , onDeleteTag = OnDeleteTag
    }


viewWidget : AppModel -> Html AppMsg
viewWidget model =
    Widget.view adapter model.userSettings model.settings model.state
