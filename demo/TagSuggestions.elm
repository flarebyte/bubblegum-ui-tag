module TagSuggestions exposing (getExampleAttributes)

import Bubblegum.Entity.Attribute as Attribute
import Bubblegum.Tag.Vocabulary exposing (..)
import Ipsum exposing (ipsum)
import List as List


widgetId : String
widgetId =
    "id:tag:123"


attri : String -> String -> List String -> Attribute.Model
attri id key values =
    { id = Just id
    , key = key
    , facets = []
    , values = values
    }


attr : String -> List String -> Attribute.Model
attr key values =
    { id = Nothing
    , key = key
    , facets = []
    , values = values
    }


suggestion : Int -> List String -> List Attribute.Model
suggestion uid infoTags =
    let
        id =
            "id:suggestion:" ++ toString uid

        label =
            String.slice uid (2 * uid) ipsum

        description =
            ipsum |> String.reverse |> String.slice uid (3 * uid)

        warningTags =
            if uid % 3 == 0 then
                [ String.slice uid (uid + 5) ipsum ]
            else
                []

        dangerTags =
            if uid % 5 == 0 then
                [ String.slice uid (uid + 7) ipsum |> String.reverse ]
            else
                []
    in
    [ attri id ui_constituentLabel [ label ]
    , attri id ui_constituentDescription [ description ]
    , attri id ui_constituentTag infoTags
    , attri id ui_constituentWarningTag warningTags
    , attri id ui_constituentDangerTag dangerTags
    ]


defaultSuggestions : List String
defaultSuggestions =
    List.range 1 28 |> List.map (toString >> (++) "id:suggestion:")


getExampleAttributes : List Attribute.Model
getExampleAttributes =
    [ attr ui_suggestion defaultSuggestions ]
        ++ suggestion 1 [ "info a", "info a 2" ]
        ++ suggestion 2 [ "info b" ]
        ++ suggestion 3 [ "info c", "info2" ]
        ++ suggestion 4 [ "info d" ]
        ++ suggestion 5 [ "info e" ]
        ++ suggestion 6 [ "info f" ]
        ++ suggestion 7 [ "info g" ]
        ++ suggestion 8 [ "info h" ]
        ++ suggestion 9 [ "info i" ]
        ++ suggestion 10 [ "info j" ]
        ++ suggestion 11 [ "info k" ]
        ++ suggestion 12 [ "info l" ]
        ++ suggestion 13 [ "info m" ]
        ++ suggestion 14 [ "info n" ]
        ++ suggestion 15 [ "info o" ]
        ++ suggestion 16 [ "info p" ]
        ++ suggestion 17 [ "info q" ]
        ++ suggestion 18 [ "info r" ]
        ++ suggestion 19 [ "info s" ]
        ++ suggestion 20 [ "info t" ]
        ++ suggestion 21 [ "info u" ]
        ++ suggestion 22 [ "info v" ]
        ++ suggestion 23 [ "info w" ]
        ++ suggestion 24 [ "info x" ]
        ++ suggestion 25 [ "info y" ]
        ++ suggestion 26 [ "info z" ]
        ++ suggestion 27 [ "info ab" ]
        ++ suggestion 28 [ "info ac" ]
