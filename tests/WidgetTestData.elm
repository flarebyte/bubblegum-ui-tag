module WidgetTestData exposing (..)

{-| Tests data to be used by the unit tests which are themselves generated automatically.

-}

import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Expect exposing (Expectation)
import Test.Html.Selector as Selector
import Bubblegum.Tag.Adapter as Adapter
import Bubblegum.Tag.Widget as Widget
import Bubblegum.Entity.SettingsEntity as SettingsEntity
import Bubblegum.Entity.StateEntity as StateEntity
import Bubblegum.Entity.Attribute as Attribute
import Fuzz exposing (Fuzzer, int, list, string, intRange, constant)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing(Selector)
import Bubblegum.Tag.Vocabulary exposing (..)


type TestMsg
    = OnSearchInputContent String
    | OnToggleDropbox
    | OnAddTag String
    | OnDeleteTag String


biggerThanSmall : Int
biggerThanSmall = 50

biggerThanMedium : Int
biggerThanMedium = 200

biggerThanVeryLarge : Int
biggerThanVeryLarge = 200000

defaultAdapter : Adapter.Model TestMsg
defaultAdapter =
    { onSearchInput = OnSearchInputContent
    , onToggleDropbox =  OnToggleDropbox
    , onAddTag = OnAddTag
    , onDeleteTag = OnDeleteTag
    }
 

defaultUserSettings: SettingsEntity.Model
defaultUserSettings = {
    attributes = [
        attr ui_userLanguage "es-ES"
    ]
 }

defaultSettings: SettingsEntity.Model
defaultSettings = {
    attributes = [
    ] ++ getExampleAttributes
 }          

defaultState: StateEntity.Model
defaultState = {
    attributes = [
        attr ui_suggesting "true"
        , attrs ui_selected ["id:suggestion:1", "id:suggestion:3"]
        , attrs ui_selectable ["id:suggestion:2", "id:suggestion:4", "id:suggestion:5", "id:suggestion:6", "id:suggestion:7"]
    ]
 }          
      

viewWidgetWithSettings : SettingsEntity.Model -> Html.Html TestMsg
viewWidgetWithSettings settings = 
    Widget.view defaultAdapter defaultUserSettings settings defaultState

viewWidgetWithUserSettings : SettingsEntity.Model -> Html.Html TestMsg
viewWidgetWithUserSettings userSettings = 
    div [] [
        Widget.view defaultAdapter userSettings defaultSettings defaultState
    ]

viewWidgetWithState : StateEntity.Model -> Html.Html TestMsg
viewWidgetWithState state = 
    div [] [
        Widget.view defaultAdapter defaultUserSettings defaultSettings state
    ]    
    
findComponent:  List Selector-> Html.Html TestMsg -> Expectation 
findComponent selectors html= 
    html |> Query.fromHtml |> Query.findAll selectors |> Query.count (Expect.equal 1)

findWarningDiv: Html.Html TestMsg -> Expectation 
findWarningDiv html = 
    html |> Query.fromHtml |> Query.findAll [ Selector.class "warning" ] |> Query.count (Expect.atLeast 1)

-- Label related to the field
withSettingsLabel: Int -> SettingsEntity.Model
withSettingsLabel value = {
    attributes = [
        attr ui_label (createString value)
    ]
 }

fuzzyLabel : Fuzzer Int
fuzzyLabel=intRange 10 50  

fuzzyNotLabel : Fuzzer Int
fuzzyNotLabel= intRange 300 400 

selectorsLabel : List Selector
selectorsLabel = [ Selector.class "label" ]

-- Some help tip related to the field
withSettingsHelp: Int -> SettingsEntity.Model
withSettingsHelp value = {
    attributes = [
        attr ui_help (createString value)
    ]
 }

fuzzyHelp : Fuzzer Int
fuzzyHelp=intRange 10 50 

fuzzyNotHelp : Fuzzer Int
fuzzyNotHelp= intRange 300 400 

selectorsHelp : List Selector
selectorsHelp = [ Selector.classes ["help", "is-info"] ]

-- Language used by the user

createLanguageOrRandom: Int -> String
createLanguageOrRandom number =
    if number == 1 then
        "es"
    else
        createString number

withUserSettingsUserLanguage: Int -> SettingsEntity.Model
withUserSettingsUserLanguage value = {
    attributes = [
        attr ui_userLanguage (createLanguageOrRandom value)
    ]
 }

fuzzyUserLanguage : Fuzzer Int
fuzzyUserLanguage=intRange 1 1  

fuzzyNotUserLanguage : Fuzzer Int
fuzzyNotUserLanguage= intRange 50 1000 

selectorsUserLanguage : List Selector
selectorsUserLanguage = [ Selector.class "bubblegum-tag__widget", Selector.attribute (Attributes.lang "es") ]

selectorsNotUserLanguage : List Selector
selectorsNotUserLanguage = [ Selector.class "bubblegum-tag__widget", 
    Selector.attribute (attribute "data-bubblegum-warn" "unsatisfied-constraint:within-string-chars-range:(1,32)") ]

-- Whether the user is using right to left
createTrueOrRandom: Int -> String
createTrueOrRandom number =
    if number == 1 then
        "true"
    else
        createString number

withUserSettingsUserRightToLeft: Int -> SettingsEntity.Model
withUserSettingsUserRightToLeft value = {
    attributes = [
        attr ui_userRightToLeft (createTrueOrRandom value)
    ]
 }

fuzzyUserRightToLeft : Fuzzer Int
fuzzyUserRightToLeft=intRange 1 1

fuzzyNotUserRightToLeft : Fuzzer Int
fuzzyNotUserRightToLeft= intRange 3 1000 

selectorsUserRightToLeft : List Selector
selectorsUserRightToLeft = [ Selector.class "bubblegum-tag__widget", Selector.attribute (Attributes.dir "rtl") ]

selectorsNotUserRightToLeft : List Selector
selectorsNotUserRightToLeft = [ Selector.class "bubblegum-tag__widget", 
    Selector.attribute (attribute "data-bubblegum-warn" "unsatisfied-constraint:bool") ]


-- Whether the content requires right to left
withUserSettingsContentRightToLeft: Int -> SettingsEntity.Model
withUserSettingsContentRightToLeft value = {
    attributes = [
        attr ui_contentRightToLeft (createTrueOrRandom value)
    ]
 }

fuzzyContentRightToLeft : Fuzzer Int
fuzzyContentRightToLeft= intRange 1 1

fuzzyNotContentRightToLeft : Fuzzer Int
fuzzyNotContentRightToLeft= intRange 3 1000

selectorsContentRightToLeft : List Selector
selectorsContentRightToLeft = [ Selector.class "dropdown-content", Selector.attribute (Attributes.dir "rtl") ]

selectorsNotContentRightToLeft : List Selector
selectorsNotContentRightToLeft = [ Selector.class "dropdown-content", 
    Selector.attribute (attribute "data-bubblegum-warn" "unsatisfied-constraint:bool") ]

-- Help message to highlight an issue with the content
withStateDangerHelp: Int -> SettingsEntity.Model
withStateDangerHelp value = {
    attributes = [
        attr ui_dangerHelp (createString value)
    ]
 }

fuzzyDangerHelp : Fuzzer Int
fuzzyDangerHelp=intRange 1 30

fuzzyNotDangerHelp : Fuzzer Int
fuzzyNotDangerHelp= intRange 300 400

selectorsDangerHelp : List Selector
selectorsDangerHelp = [ Selector.classes ["help", "is-danger"] ]

-- The selected tags for the field
withStateSelected: Int -> StateEntity.Model
withStateSelected value = {
    attributes = [
        attr ui_selected ("id:suggestion:" ++ (toString value))
    ]
 }

fuzzySelected : Fuzzer Int
fuzzySelected = intRange 1 9

fuzzyNotSelected : Fuzzer Int
fuzzyNotSelected = intRange 100 400

selectorsSelected : List Selector
selectorsSelected = [ Selector.class "tag", Selector.class "is-dark", Selector.text "1" ]

selectorsNotSelected : List Selector
selectorsNotSelected = [ Selector.class "tag", Selector.class "is-dark", Selector.text "1" ]



-- The selectable tags for the field
withStateSelectable: Int -> StateEntity.Model
withStateSelectable value = {
    attributes = [
        attr ui_selectable ("id:suggestion:" ++ (toString value))
    ]
 }

fuzzySelectable : Fuzzer Int
fuzzySelectable = constant 7

fuzzyNotSelectable : Fuzzer Int
fuzzyNotSelectable = intRange 100 400

selectorsSelectable : List Selector
selectorsSelectable = [ Selector.class "is-size-6", Selector.text "label7" ]

selectorsNotSelectable : List Selector
selectorsNotSelectable = [ Selector.class "bubblegum-tag__input",
    Selector.attribute (attribute "data-bubblegum-warn" "unsatisfied-constraint:") ]



-- Suggesting is currently happening
withStateSuggesting: Int -> StateEntity.Model
withStateSuggesting value = {
    attributes = [
        attr ui_suggesting (createString value)
    ]
 }

fuzzySuggesting : Fuzzer Int
fuzzySuggesting = intRange 1 1

fuzzyNotSuggesting : Fuzzer Int
fuzzyNotSuggesting = intRange 100 400

selectorsSuggesting : List Selector
selectorsSuggesting = [ Selector.class "bubblegum-tag__input", Selector.attribute (Attributes.lang "es") ]

selectorsNotSuggesting : List Selector
selectorsNotSuggesting = [ Selector.class "bubblegum-tag__input",
    Selector.attribute (attribute "data-bubblegum-warn" "unsatisfied-constraint:") ]



-- The list of suggested tags for the field
withSettingsSuggestion: Int -> SettingsEntity.Model
withSettingsSuggestion value = {
    attributes = [
        attr ui_suggestion (createString value)
    ]
 }

fuzzySuggestion : Fuzzer Int
fuzzySuggestion = intRange 1 1

fuzzyNotSuggestion : Fuzzer Int
fuzzyNotSuggestion = intRange 100 400

selectorsSuggestion : List Selector
selectorsSuggestion = [ Selector.class "bubblegum-tag__input", Selector.attribute (Attributes.lang "es") ]

selectorsNotSuggestion : List Selector
selectorsNotSuggestion = [ Selector.class "bubblegum-tag__input",
    Selector.attribute (attribute "data-bubblegum-warn" "unsatisfied-constraint:") ]



-- Search term for filtering the available options
withStateSearch: Int -> StateEntity.Model
withStateSearch value = {
    attributes = [
        attr ui_search (createString value)
    ]
 }

fuzzySearch : Fuzzer Int
fuzzySearch = intRange 1 1

fuzzyNotSearch : Fuzzer Int
fuzzyNotSearch = intRange 100 400

selectorsSearch : List Selector
selectorsSearch = [ Selector.class "bubblegum-tag__input", Selector.attribute (Attributes.lang "es") ]

selectorsNotSearch : List Selector
selectorsNotSearch = [ Selector.class "bubblegum-tag__input",
    Selector.attribute (attribute "data-bubblegum-warn" "unsatisfied-constraint:") ]



-- Label related to the search field
withSettingsSearchLabel: Int -> SettingsEntity.Model
withSettingsSearchLabel value = {
    attributes = [
        attr ui_searchLabel (createString value)
    ]
 }

fuzzySearchLabel : Fuzzer Int
fuzzySearchLabel = intRange 1 1

fuzzyNotSearchLabel : Fuzzer Int
fuzzyNotSearchLabel = intRange 100 400

selectorsSearchLabel : List Selector
selectorsSearchLabel = [ Selector.class "bubblegum-tag__input", Selector.attribute (Attributes.lang "es") ]

selectorsNotSearchLabel : List Selector
selectorsNotSearchLabel = [ Selector.class "bubblegum-tag__input",
    Selector.attribute (attribute "data-bubblegum-warn" "unsatisfied-constraint:") ]



-- The minimum number of tags needed for successful content
withSettingsSuccessMinimumTags: Int -> SettingsEntity.Model
withSettingsSuccessMinimumTags value = {
    attributes = [
        attr ui_successMinimumTags (createString value)
    ]
 }

fuzzySuccessMinimumTags : Fuzzer Int
fuzzySuccessMinimumTags = intRange 1 1

fuzzyNotSuccessMinimumTags : Fuzzer Int
fuzzyNotSuccessMinimumTags = intRange 100 400

selectorsSuccessMinimumTags : List Selector
selectorsSuccessMinimumTags = [ Selector.class "bubblegum-tag__input", Selector.attribute (Attributes.lang "es") ]

selectorsNotSuccessMinimumTags : List Selector
selectorsNotSuccessMinimumTags = [ Selector.class "bubblegum-tag__input",
    Selector.attribute (attribute "data-bubblegum-warn" "unsatisfied-constraint:") ]



-- The maximum number of tags needed for successful content
withSettingsSuccessMaximumTags: Int -> SettingsEntity.Model
withSettingsSuccessMaximumTags value = {
    attributes = [
        attr ui_successMaximumTags (createString value)
    ]
 }

fuzzySuccessMaximumTags : Fuzzer Int
fuzzySuccessMaximumTags = intRange 1 1

fuzzyNotSuccessMaximumTags : Fuzzer Int
fuzzyNotSuccessMaximumTags = intRange 100 400

selectorsSuccessMaximumTags : List Selector
selectorsSuccessMaximumTags = [ Selector.class "bubblegum-tag__input", Selector.attribute (Attributes.lang "es") ]

selectorsNotSuccessMaximumTags : List Selector
selectorsNotSuccessMaximumTags = [ Selector.class "bubblegum-tag__input",
    Selector.attribute (attribute "data-bubblegum-warn" "unsatisfied-constraint:") ]



-- Warning when under the minimum number of tags
withSettingsDangerMinimumTags: Int -> SettingsEntity.Model
withSettingsDangerMinimumTags value = {
    attributes = [
        attr ui_dangerMinimumTags (createString value)
    ]
 }

fuzzyDangerMinimumTags : Fuzzer Int
fuzzyDangerMinimumTags = intRange 1 1

fuzzyNotDangerMinimumTags : Fuzzer Int
fuzzyNotDangerMinimumTags = intRange 100 400

selectorsDangerMinimumTags : List Selector
selectorsDangerMinimumTags = [ Selector.class "bubblegum-tag__input", Selector.attribute (Attributes.lang "es") ]

selectorsNotDangerMinimumTags : List Selector
selectorsNotDangerMinimumTags = [ Selector.class "bubblegum-tag__input",
    Selector.attribute (attribute "data-bubblegum-warn" "unsatisfied-constraint:") ]



-- Warning when over the maximum number of tags
withSettingsDangerMaximumTags: Int -> SettingsEntity.Model
withSettingsDangerMaximumTags value = {
    attributes = [
        attr ui_dangerMaximumTags (createString value)
    ]
 }

fuzzyDangerMaximumTags : Fuzzer Int
fuzzyDangerMaximumTags = intRange 1 1

fuzzyNotDangerMaximumTags : Fuzzer Int
fuzzyNotDangerMaximumTags = intRange 100 400

selectorsDangerMaximumTags : List Selector
selectorsDangerMaximumTags = [ Selector.class "bubblegum-tag__input", Selector.attribute (Attributes.lang "es") ]

selectorsNotDangerMaximumTags : List Selector
selectorsNotDangerMaximumTags = [ Selector.class "bubblegum-tag__input",
    Selector.attribute (attribute "data-bubblegum-warn" "unsatisfied-constraint:") ]

-- private

attr: String -> String -> Attribute.Model
attr key value =
     { id = Nothing
    , key = key
    , facets = []
    , values = [value]
    }  

attrs: String -> List String -> Attribute.Model
attrs key values =
     { id = Nothing
    , key = key
    , facets = []
    , values = values
    }  

ipsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer mauris dolor, suscipit at nulla a, molestie scelerisque lectus. Nullam quis leo a felis auctor mollis ac vel turpis. Praesent eleifend ut sem et hendrerit. Vivamus sagittis tortor ipsum, eu suscipit lectus accumsan a. Vivamus elit ante, ornare vitae sem at, ornare eleifend nibh. Mauris venenatis nunc sit amet leo aliquam, in ornare quam vehicula. Morbi consequat ante sed felis semper egestas. Donec efficitur suscipit ipsum vitae ultrices. Quisque eget vehicula odio. Aliquam vitae posuere mauris. Nulla ac pulvinar felis. Integer odio libero, vulputate in erat in, tristique cursus erat."

createString: Int -> String
createString size  =
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
    (defaultSuggestions |> List.map (attr ui_suggestion) )
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
