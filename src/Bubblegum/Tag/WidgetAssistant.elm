module Bubblegum.Tag.WidgetAssistant exposing (deduceSelectable)

{-| Various limits used accross the widget
-}

import Set as Set


deduceSelectable : List String -> List String -> List String
deduceSelectable suggestions selected =
    Set.diff (Set.fromList suggestions) (Set.fromList selected) |> Set.toList
