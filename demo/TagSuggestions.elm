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


suggestion : Int -> List String -> List String -> List String -> List Attribute.Model
suggestion uid infoTags warningTags dangerTags =
    let
        id =
            "id:suggestion:" ++ toString uid

        label =
            String.left uid ipsum

        description =
            String.right (2 * uid) ipsum |> String.reverse
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
        ++ suggestion 1 [ "info a", "info a 2" ] [ "warn1" ] [ "danger1", "danger2" ]
        ++ suggestion 2 [ "info b" ] [ "warn1" ] [ "danger1", "danger2" ]
        ++ suggestion 3 [ "info c", "info2" ] [ "warn1" ] [ "danger1", "danger2" ]
        ++ suggestion 4 [ "info d" ] [ "warn1" ] [ "danger1", "danger2" ]
        ++ suggestion 5 [ "info e" ] [ "warn1" ] [ "danger1" ]
        ++ suggestion 6 [ "info f" ] [ "warn1" ] [ "danger1" ]
        ++ suggestion 7 [ "info g" ] [ "warn1" ] [ "danger1" ]
        ++ suggestion 8 [ "info h" ] [ "warn1" ] [ "danger1" ]
        ++ suggestion 9 [ "info i" ] [ "warn1" ] [ "danger1" ]
        ++ suggestion 10 [ "info j" ] [ "warn1" ] [ "danger1" ]
        ++ suggestion 11 [ "info k" ] [ "warn1" ] [ "danger1" ]
        ++ suggestion 12 [ "info l" ] [ "warn1" ] [ "danger1" ]
        ++ suggestion 13 [ "info m" ] [ "warn1" ] [ "danger1" ]
        ++ suggestion 14 [ "info n" ] [ "warn1" ] [ "danger1" ]
        ++ suggestion 15 [ "info o" ] [ "warn1" ] [ "danger1" ]
        ++ suggestion 16 [ "info p" ] [ "warn1" ] [ "danger1" ]
        ++ suggestion 17 [ "info q" ] [ "warn1" ] [ "danger1" ]
        ++ suggestion 18 [ "info r" ] [ "warn1" ] [ "danger1" ]
        ++ suggestion 19 [ "info s" ] [ "warn1" ] [ "danger1" ]
        ++ suggestion 20 [ "info t" ] [ "warn1" ] [ "danger1" ]
        ++ suggestion 21 [ "info u" ] [ "warn1" ] [ "danger1" ]
        ++ suggestion 22 [ "info v" ] [ "warn1" ] [ "danger1" ]
        ++ suggestion 23 [ "info w" ] [ "warn1" ] [ "danger1" ]
        ++ suggestion 24 [ "info x" ] [ "warn1" ] [ "danger1" ]
        ++ suggestion 25 [ "info y" ] [ "warn1" ] [ "danger1" ]
        ++ suggestion 26 [ "info z" ] [ "warn1" ] [ "danger1" ]
        ++ suggestion 27 [ "info ab" ] [ "warn1" ] [ "danger1" ]
        ++ suggestion 28 [ "info ac" ] [ "warn1" ] [ "danger1" ]
