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
    ]
 }          

defaultState: StateEntity.Model
defaultState = {
    attributes = [
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


-- Language of the content
withUserSettingsContentLanguage: Int -> SettingsEntity.Model
withUserSettingsContentLanguage value = {
    attributes = [
        attr ui_contentLanguage (createLanguageOrRandom value)
    ]
 }

fuzzyContentLanguage : Fuzzer Int
fuzzyContentLanguage=intRange 1 1

fuzzyNotContentLanguage : Fuzzer Int
fuzzyNotContentLanguage= intRange 100 400 

selectorsContentLanguage : List Selector
selectorsContentLanguage = [ Selector.class "bubblegum-tag__input", Selector.attribute (Attributes.lang "es") ]

selectorsNotContentLanguage : List Selector
selectorsNotContentLanguage = [ Selector.class "bubblegum-tag__input", 
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
selectorsContentRightToLeft = [ Selector.class "bubblegum-tag__input", Selector.attribute (Attributes.dir "rtl") ]

selectorsNotContentRightToLeft : List Selector
selectorsNotContentRightToLeft = [ Selector.class "bubblegum-tag__input", 
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

-- private

attr: String -> String -> Attribute.Model
attr key value =
     { id = Nothing
    , key = key
    , facets = []
    , values = [value]
    }  

ipsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer mauris dolor, suscipit at nulla a, molestie scelerisque lectus. Nullam quis leo a felis auctor mollis ac vel turpis. Praesent eleifend ut sem et hendrerit. Vivamus sagittis tortor ipsum, eu suscipit lectus accumsan a. Vivamus elit ante, ornare vitae sem at, ornare eleifend nibh. Mauris venenatis nunc sit amet leo aliquam, in ornare quam vehicula. Morbi consequat ante sed felis semper egestas. Donec efficitur suscipit ipsum vitae ultrices. Quisque eget vehicula odio. Aliquam vitae posuere mauris. Nulla ac pulvinar felis. Integer odio libero, vulputate in erat in, tristique cursus erat."

createString: Int -> String
createString size  =
    if size > 500 then
        String.repeat size "A"
    else
        String.left size ipsum