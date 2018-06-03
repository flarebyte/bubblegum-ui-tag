module WidgetDoc exposing (..)

import AttributeDoc exposing (AttributeDoc, Cardinality(..), createKey)
import PackageJson


type alias WidgetDoc =
    { meta : PackageJson.Model
    , userSettings : List AttributeDoc
    , settings : List AttributeDoc
    , stateAttributes : List AttributeDoc
    }
