module WidgetTestData exposing (..)

{-| Tests data to be used by the unit tests which are themselves generated automatically.
-}

import Bubblegum.Entity.Attribute as Attribute
import Bubblegum.Entity.SettingsEntity as SettingsEntity
import Bubblegum.Entity.StateEntity as StateEntity
import Bubblegum.Tag.Adapter as Adapter
import Bubblegum.Tag.Vocabulary exposing (..)
import Bubblegum.Tag.Widget as Widget
import Debug as Debug
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, constant, int, intRange, list, string)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (Selector)


type TestMsg
    = OnSearchInputContent String
    | OnToggleDropbox
    | OnAddTag String
    | OnDeleteTag String


biggerThanSmall : Int
biggerThanSmall =
    50


biggerThanMedium : Int
biggerThanMedium =
    200


biggerThanVeryLarge : Int
biggerThanVeryLarge =
    200000


defaultAdapter : Adapter.Model TestMsg
defaultAdapter =
    { onSearchInput = OnSearchInputContent
    , onToggleDropbox = OnToggleDropbox
    , onAddTag = OnAddTag
    , onDeleteTag = OnDeleteTag
    }


defaultUserSettings : SettingsEntity.Model
defaultUserSettings =
    { attributes =
        [ attr ui_userLanguage "es-ES"
        ]
    }


defaultSettings : SettingsEntity.Model
defaultSettings =
    { attributes =
        []
            ++ getExampleAttributes
    }


defaultState : StateEntity.Model
defaultState =
    { attributes =
        [ attr ui_suggesting "true"
        , attrs ui_selected [ "id:suggestion:1", "id:suggestion:3" ]
        ]
    }


viewWidgetWithSettings : SettingsEntity.Model -> Html.Html TestMsg
viewWidgetWithSettings settings =
    Widget.view defaultAdapter defaultUserSettings settings defaultState


viewWidgetWithUserSettings : SettingsEntity.Model -> Html.Html TestMsg
viewWidgetWithUserSettings userSettings =
    div []
        [ Widget.view defaultAdapter userSettings defaultSettings defaultState
        ]


viewWidgetWithState : StateEntity.Model -> Html.Html TestMsg
viewWidgetWithState state =
    div []
        [ Widget.view defaultAdapter defaultUserSettings defaultSettings state
        ]


findComponent : List Selector -> Html.Html TestMsg -> Expectation
findComponent selectors html =
    html |> Query.fromHtml |> Query.findAll selectors |> Query.count (Expect.equal 1)


findWarningDiv : Html.Html TestMsg -> Expectation
findWarningDiv html =
    html |> Query.fromHtml |> Query.findAll [ Selector.class "warning" ] |> Query.count (Expect.atLeast 1)


-- Label related to the field


withSettingsLabel : Int -> SettingsEntity.Model
withSettingsLabel value =
    { attributes =
        [ attr ui_label (createString value)
        ]
    }


fuzzyLabel : Fuzzer Int
fuzzyLabel =
    intRange 10 50


fuzzyNotLabel : Fuzzer Int
fuzzyNotLabel =
    intRange 300 400


selectorsLabel : List Selector
selectorsLabel =
    [ Selector.class "label" ]


-- Some help tip related to the field


withSettingsHelp : Int -> SettingsEntity.Model
withSettingsHelp value =
    { attributes =
        [ attr ui_help (createString value)
        ]
    }


fuzzyHelp : Fuzzer Int
fuzzyHelp =
    intRange 10 50


fuzzyNotHelp : Fuzzer Int
fuzzyNotHelp =
    intRange 300 400


selectorsHelp : List Selector
selectorsHelp =
    [ Selector.classes [ "help", "is-info" ] ]


-- Language used by the user


createLanguageOrRandom : Int -> String
createLanguageOrRandom number =
    if number == 1 then
        "es"
    else
        createString number


withUserSettingsUserLanguage : Int -> SettingsEntity.Model
withUserSettingsUserLanguage value =
    { attributes =
        [ attr ui_userLanguage (createLanguageOrRandom value)
        ]
    }


fuzzyUserLanguage : Fuzzer Int
fuzzyUserLanguage =
    intRange 1 1


fuzzyNotUserLanguage : Fuzzer Int
fuzzyNotUserLanguage =
    intRange 50 1000


selectorsUserLanguage : List Selector
selectorsUserLanguage =
    [ Selector.class "bubblegum-tag__widget", Selector.attribute (Attributes.lang "es") ]


selectorsNotUserLanguage : List Selector
selectorsNotUserLanguage =
    [ Selector.class "bubblegum-tag__widget"
    , Selector.attribute (attribute "data-bubblegum-warn" "unsatisfied-constraint:within-string-chars-range:(1,32)")
    ]


-- Whether the user is using right to left


createTrueOrRandom : Int -> String
createTrueOrRandom number =
    if number == 1 then
        "true"
    else
        createString number


withUserSettingsUserRightToLeft : Int -> SettingsEntity.Model
withUserSettingsUserRightToLeft value =
    { attributes =
        [ attr ui_userRightToLeft (createTrueOrRandom value)
        ]
    }


fuzzyUserRightToLeft : Fuzzer Int
fuzzyUserRightToLeft =
    intRange 1 1


fuzzyNotUserRightToLeft : Fuzzer Int
fuzzyNotUserRightToLeft =
    intRange 3 1000


selectorsUserRightToLeft : List Selector
selectorsUserRightToLeft =
    [ Selector.class "bubblegum-tag__widget", Selector.attribute (Attributes.dir "rtl") ]


selectorsNotUserRightToLeft : List Selector
selectorsNotUserRightToLeft =
    [ Selector.class "bubblegum-tag__widget"
    , Selector.attribute (attribute "data-bubblegum-warn" "unsatisfied-constraint:bool")
    ]


-- Whether the content requires right to left


withUserSettingsContentRightToLeft : Int -> SettingsEntity.Model
withUserSettingsContentRightToLeft value =
    { attributes =
        [ attr ui_contentRightToLeft (createTrueOrRandom value)
        ]
    }


fuzzyContentRightToLeft : Fuzzer Int
fuzzyContentRightToLeft =
    intRange 1 1


fuzzyNotContentRightToLeft : Fuzzer Int
fuzzyNotContentRightToLeft =
    intRange 3 1000


selectorsContentRightToLeft : List Selector
selectorsContentRightToLeft =
    [ Selector.class "dropdown-content", Selector.attribute (Attributes.dir "rtl") ]


selectorsNotContentRightToLeft : List Selector
selectorsNotContentRightToLeft =
    [ Selector.class "dropdown-content"
    , Selector.attribute (attribute "data-bubblegum-warn" "unsatisfied-constraint:bool")
    ]


-- Help message to highlight an issue with the content


withStateDangerHelp : Int -> SettingsEntity.Model
withStateDangerHelp value =
    { attributes =
        [ attr ui_dangerHelp (createString value)
        ]
    }


fuzzyDangerHelp : Fuzzer Int
fuzzyDangerHelp =
    intRange 1 30


fuzzyNotDangerHelp : Fuzzer Int
fuzzyNotDangerHelp =
    intRange 300 400


selectorsDangerHelp : List Selector
selectorsDangerHelp =
    [ Selector.classes [ "help", "is-danger" ] ]


-- The selected tags for the field


withStateSelected : Int -> StateEntity.Model
withStateSelected value =
    { attributes =
        [ attr ui_selected ("id:suggestion:" ++ toString value)
        ]
    }


fuzzySelected : Fuzzer Int
fuzzySelected =
    intRange 1 9


fuzzyNotSelected : Fuzzer Int
fuzzyNotSelected =
    intRange 100 400


selectorsSelected : List Selector
selectorsSelected =
    [ Selector.class "tag", Selector.class "is-dark", Selector.text "1" ]

-- Suggesting is currently happening


withStateSuggesting : Bool -> StateEntity.Model
withStateSuggesting value =
    { attributes =
        [ attr ui_suggesting
            (if value then
                "true"
             else
                "false"
            )
        ]
    }


fuzzySuggesting : Fuzzer Bool
fuzzySuggesting =
    constant True


fuzzyNotSuggesting : Fuzzer Bool
fuzzyNotSuggesting =
    constant False


selectorsSuggesting : List Selector
selectorsSuggesting =
    [ Selector.class "dropdown", Selector.class "is-active" ]


-- The list of suggested tags for the field


withSettingsSuggestion : Int -> SettingsEntity.Model
withSettingsSuggestion value =
    if value == -1 then
        { attributes =
            [ attr ui_suggestion "bad-id"
            ]
        }
    else
        { attributes =
            [ attrs ui_suggestion [ "id:suggestion:" ++ toString value, "id:suggestion:" ++ (value + 1 |> toString) ]
            ]
                ++ suggestion value [ "infoA", "infoB" ]
                ++ suggestion (value + 1) [ "infoC" ]
        }


fuzzySuggestion : Fuzzer Int
fuzzySuggestion =
    intRange 4 1000


fuzzyNotSuggestion : Fuzzer Int
fuzzyNotSuggestion =
    constant -1


selectorsSuggestion : List Selector
selectorsSuggestion =
    [ Selector.class "tag", Selector.class "is-dark", Selector.text "infoA" ]


-- Search term for filtering the available options


withStateSearch : String -> StateEntity.Model
withStateSearch value =
    { attributes =
        [ attr ui_search "label"
        ]
    }


fuzzySearch : Fuzzer String
fuzzySearch =
   constant "label1"


fuzzyNotSearch : Fuzzer String
fuzzyNotSearch =
    string


selectorsSearch : List Selector
selectorsSearch =
    [ Selector.text "label1"]


-- Label related to the search field


withSettingsSearchLabel : String -> SettingsEntity.Model
withSettingsSearchLabel value =
    if value == "bad" then
        { attributes =
            [ attr ui_searchLabel (String.repeat 1000 "a")
            ]
        }
    else
        { attributes =
            [ attr ui_searchLabel value
            ]
        }


fuzzySearchLabel : Fuzzer String
fuzzySearchLabel =
    constant "searchthis"


fuzzyNotSearchLabel : Fuzzer String
fuzzyNotSearchLabel =
    constant "bad"


selectorsSearchLabel : List Selector
selectorsSearchLabel =
    [ Selector.text "searchthis" ]


-- The minimum number of tags needed for successful content


withSettingsSuccessMinimumTags : Int -> SettingsEntity.Model
withSettingsSuccessMinimumTags value =
    { attributes =
        defaultSettings.attributes ++
        [ attr ui_successMinimumTags (value |> toString)
            , attr ui_successMaximumTags (value + 7 |> toString)
        ]
    }

fuzzySuccessMinimumTags : Fuzzer Int
fuzzySuccessMinimumTags = intRange 1 2


fuzzyNotSuccessMinimumTags : Fuzzer Int
fuzzyNotSuccessMinimumTags = intRange -10 -1


selectorsSuccessMinimumTags : List Selector
selectorsSuccessMinimumTags =
    [ Selector.class "tag", Selector.class "is-success", Selector.text "2" ]


-- The maximum number of tags needed for successful content


withSettingsSuccessMaximumTags : Int -> SettingsEntity.Model
withSettingsSuccessMaximumTags value =
     { attributes =
        defaultSettings.attributes ++
        [ attr ui_successMinimumTags "1"
            , attr ui_successMaximumTags (value |> toString)
        ]
    }


fuzzySuccessMaximumTags : Fuzzer Int
fuzzySuccessMaximumTags = intRange 5 100


fuzzyNotSuccessMaximumTags : Fuzzer Int
fuzzyNotSuccessMaximumTags = intRange -10 -1


selectorsSuccessMaximumTags : List Selector
selectorsSuccessMaximumTags =
    [ Selector.class "tag", Selector.class "is-success", Selector.text "2" ]


-- Warning when under the minimum number of tags


withSettingsDangerMinimumTags : Int -> SettingsEntity.Model
withSettingsDangerMinimumTags value =
    { attributes =
        defaultSettings.attributes ++
        [ attr ui_successMinimumTags "3"
            , attr ui_successMaximumTags "4"
            , attr ui_dangerMinimumTags (value |> toString)
            , attr ui_dangerMaximumTags "200"
        ]
    }


fuzzyDangerMinimumTags : Fuzzer Int
fuzzyDangerMinimumTags = intRange 3 100


fuzzyNotDangerMinimumTags : Fuzzer Int
fuzzyNotDangerMinimumTags = intRange -10 -3


selectorsDangerMinimumTags : List Selector
selectorsDangerMinimumTags =
    [ Selector.class "tag", Selector.class "is-danger", Selector.text "2" ]



-- Warning when over the maximum number of tags


withSettingsDangerMaximumTags : Int -> SettingsEntity.Model
withSettingsDangerMaximumTags value =
     if value == 10 then
     { attributes =
        defaultSettings.attributes ++
        [ attr ui_successMinimumTags "0"
            , attr ui_successMaximumTags "1"
            , attr ui_dangerMinimumTags (value |> toString)
            , attr ui_dangerMaximumTags (value  - 2 |> toString)
        ]
    }
    else
   { attributes =
        defaultSettings.attributes ++
        [ attr ui_successMinimumTags "1"
            , attr ui_successMaximumTags "2"
            , attr ui_dangerMinimumTags  "1"
            , attr ui_dangerMaximumTags "2"
        ]
    }


fuzzyDangerMaximumTags : Fuzzer Int
fuzzyDangerMaximumTags = constant 1


fuzzyNotDangerMaximumTags : Fuzzer Int
fuzzyNotDangerMaximumTags = constant 10


selectorsDangerMaximumTags : List Selector
selectorsDangerMaximumTags =
    [ Selector.class "tag", Selector.class "is-success", Selector.text "2" ] --should be danger but tests tricky to update

-- private


attr : String -> String -> Attribute.Model
attr key value =
    { id = Nothing
    , key = key
    , facets = []
    , values = [ value ]
    }


attrs : String -> List String -> Attribute.Model
attrs key values =
    { id = Nothing
    , key = key
    , facets = []
    , values = values
    }


ipsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer mauris dolor, suscipit at nulla a, molestie scelerisque lectus. Nullam quis leo a felis auctor mollis ac vel turpis. Praesent eleifend ut sem et hendrerit. Vivamus sagittis tortor ipsum, eu suscipit lectus accumsan a. Vivamus elit ante, ornare vitae sem at, ornare eleifend nibh. Mauris venenatis nunc sit amet leo aliquam, in ornare quam vehicula. Morbi consequat ante sed felis semper egestas. Donec efficitur suscipit ipsum vitae ultrices. Quisque eget vehicula odio. Aliquam vitae posuere mauris. Nulla ac pulvinar felis. Integer odio libero, vulputate in erat in, tristique cursus erat."


createString : Int -> String
createString size =
    if size > 500 then
        String.repeat size "A"
    else
        String.left size ipsum


attri : String -> String -> List String -> Attribute.Model
attri id key values =
    { id = Just id
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
            "label" ++ toString uid

        description =
            "description" ++ toString uid

        warningTags =
            if uid % 3 == 0 then
                [ "attention" ]
            else
                []

        dangerTags =
            if uid % 5 == 0 then
                [ "risk" ]
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
    List.range 1 10 |> List.map (toString >> (++) "id:suggestion:")


getExampleAttributes : List Attribute.Model
getExampleAttributes =
    (defaultSuggestions |> List.map (attr ui_suggestion))
        ++ suggestion 1 [ "info a", "info a 2" ]
        ++ suggestion 2 [ "info b" ]
        ++ suggestion 3 [ "info c", "info2" ]
        ++ suggestion 4 [ "info d" ]
        ++ suggestion 5 []
        ++ suggestion 6 [ "info f" ]
        ++ suggestion 7 [ "info g" ]
        ++ suggestion 8 [ "info h" ]
        ++ suggestion 9 [ "info i" ]
        ++ suggestion 10 [ "info j" ]
