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
    = OnInputContent String

biggerThanSmall : Int
biggerThanSmall = 50

biggerThanMedium : Int
biggerThanMedium = 200

biggerThanVeryLarge : Int
biggerThanVeryLarge = 200000

defaultAdapter : Adapter.Model TestMsg
defaultAdapter =
    { onInput = OnInputContent
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
        attr ui_content ipsum
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

-- The minimum number of characters needed for successful content
withSettingsSuccessMinimumChars: Int -> SettingsEntity.Model
withSettingsSuccessMinimumChars value = {
    attributes = [
        attr ui_successMinimumChars (value |> toString)
        , attr ui_successMaximumChars (value + 100 |> toString)
    ]
 }

fuzzySuccessMinimumChars : Fuzzer Int
fuzzySuccessMinimumChars=intRange 1 10000  

fuzzyNotSuccessMinimumChars : Fuzzer Int
fuzzyNotSuccessMinimumChars= Fuzz.oneOf [
        intRange -70000 -1
        , intRange 70000 1000000
    ]

selectorsSuccessMinimumChars : List Selector
selectorsSuccessMinimumChars = [ Selector.tag "progress" ]

-- The maximum number of characters needed for successful content
withSettingsSuccessMaximumChars: Int -> SettingsEntity.Model
withSettingsSuccessMaximumChars value = {
    attributes = [
        attr ui_successMinimumChars (value |> toString)
        , attr ui_successMaximumChars (value + 100 |> toString)
    ]
 }

fuzzySuccessMaximumChars : Fuzzer Int
fuzzySuccessMaximumChars=intRange 1 10000  

fuzzyNotSuccessMaximumChars : Fuzzer Int
fuzzyNotSuccessMaximumChars= Fuzz.oneOf [
        intRange -70000 -1
        , intRange 70000 1000000
    ]

selectorsSuccessMaximumChars : List Selector
selectorsSuccessMaximumChars = [ Selector.tag "progress" ]

-- Warning when under the minimum number of characters
withSettingsDangerMinimumChars: Int -> SettingsEntity.Model
withSettingsDangerMinimumChars value = {
    attributes = [
        attr ui_dangerMinimumChars (value |> toString)
        , attr ui_dangerMaximumChars (value + 50 |> toString)
    ]
 }

fuzzyDangerMinimumChars : Fuzzer Int
fuzzyDangerMinimumChars=intRange 1 200  

fuzzyNotDangerMinimumChars : Fuzzer Int
fuzzyNotDangerMinimumChars= Fuzz.oneOf [
        intRange -70000 -1
        , intRange 70000 1000000
    ]

selectorsDangerMinimumChars : List Selector
selectorsDangerMinimumChars = [ Selector.classes ["tag", "is-danger"], 
    Selector.attribute (Attributes.title "número de caracteres") ]

-- Warning when over the maximum number of characters
withSettingsDangerMaximumChars: Int -> SettingsEntity.Model
withSettingsDangerMaximumChars value = {
    attributes = [
        attr ui_dangerMinimumChars (value |> toString)
        , attr ui_dangerMaximumChars (value + 100 |> toString)
    ]
 }

fuzzyDangerMaximumChars : Fuzzer Int
fuzzyDangerMaximumChars=intRange 1 200  

fuzzyNotDangerMaximumChars : Fuzzer Int
fuzzyNotDangerMaximumChars= Fuzz.oneOf [
        intRange -70000 -1
        , intRange 70000 1000000
    ]

selectorsDangerMaximumChars : List Selector
selectorsDangerMaximumChars = [ Selector.classes ["tag", "is-danger"],
 Selector.attribute (Attributes.title "número de caracteres") ]

-- The minimum number of words needed for successful content
withSettingsSuccessMinimumWords: Int -> SettingsEntity.Model
withSettingsSuccessMinimumWords value = {
    attributes = [
        attr ui_successMinimumWords (value |> toString)
        , attr ui_successMaximumWords (value + 100 |> toString)
    ]
 }

fuzzySuccessMinimumWords : Fuzzer Int
fuzzySuccessMinimumWords=intRange 1 10000  

fuzzyNotSuccessMinimumWords : Fuzzer Int
fuzzyNotSuccessMinimumWords= Fuzz.oneOf [
        intRange -70000 -1
        , intRange 70000 1000000
    ]

selectorsSuccessMinimumWords : List Selector
selectorsSuccessMinimumWords = [ Selector.tag "progress" ]

-- The maximum number of words needed for successful content
withSettingsSuccessMaximumWords: Int -> SettingsEntity.Model
withSettingsSuccessMaximumWords value = {
    attributes = [
        attr ui_successMinimumWords (value |> toString)
        , attr ui_successMaximumWords (value + 100 |> toString)
    ]
 }

fuzzySuccessMaximumWords : Fuzzer Int
fuzzySuccessMaximumWords=intRange 1 10000  

fuzzyNotSuccessMaximumWords : Fuzzer Int
fuzzyNotSuccessMaximumWords= Fuzz.oneOf [
        intRange -70000 -1
        , intRange 70000 1000000
    ]

selectorsSuccessMaximumWords : List Selector
selectorsSuccessMaximumWords = [ Selector.tag "progress" ]

-- Warning when under the minimum number of words
withSettingsDangerMinimumWords: Int -> SettingsEntity.Model
withSettingsDangerMinimumWords value = {
    attributes = [
        attr ui_dangerMinimumWords (value |> toString)
        , attr ui_dangerMaximumWords (value + 20 |> toString)
    ]
 }

fuzzyDangerMinimumWords : Fuzzer Int
fuzzyDangerMinimumWords=intRange 1 10  

fuzzyNotDangerMinimumWords : Fuzzer Int
fuzzyNotDangerMinimumWords= Fuzz.oneOf [
        intRange -70000 -1
        , intRange 70000 1000000
    ]

selectorsDangerMinimumWords : List Selector
selectorsDangerMinimumWords = [ Selector.classes ["tag", "is-danger"],
    Selector.attribute (Attributes.title "número de palabras") ]

-- Warning when over the maximum number of words
withSettingsDangerMaximumWords: Int -> SettingsEntity.Model
withSettingsDangerMaximumWords value = {
    attributes = [
        attr ui_dangerMinimumWords (value |> toString)
        , attr ui_dangerMaximumWords (value + 20 |> toString)
    ]
 }

fuzzyDangerMaximumWords : Fuzzer Int
fuzzyDangerMaximumWords=intRange 1 30  

fuzzyNotDangerMaximumWords : Fuzzer Int
fuzzyNotDangerMaximumWords= Fuzz.oneOf [
        intRange -70000 -1
        , intRange 70000 1000000
    ]

selectorsDangerMaximumWords : List Selector
selectorsDangerMaximumWords = [ Selector.classes ["tag", "is-danger"],
 Selector.attribute (Attributes.title "número de palabras") ]

-- Short hint describing the expected content
withSettingsPlaceholder: Int -> SettingsEntity.Model
withSettingsPlaceholder value = {
    attributes = [
        attr ui_placeholder (createString value)
    ]
 }

-- a bit of a hack. Would be nice if we would not have to specify the exact value for placeholder.
fuzzyPlaceholder : Fuzzer Int
fuzzyPlaceholder=intRange 50 50 

fuzzyNotPlaceholder : Fuzzer Int
fuzzyNotPlaceholder= intRange 300 500 

selectorsPlaceholder : List Selector
selectorsPlaceholder = [ Selector.class "bubblegum-tag__input", Selector.attribute (attribute "placeholder" (createString 50))]

selectorsNotPlaceholder : List Selector
selectorsNotPlaceholder = [ Selector.class "bubblegum-tag__input", Selector.attribute (attribute "data-bubblegum-warn" "unsatisfied-constraint:within-string-chars-range:(1,128)")]

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

-- Tag used to describe the field
withSettingsTag: Int -> SettingsEntity.Model
withSettingsTag value = {
    attributes = [
        attr ui_tag (createString value)
    ]
 }

fuzzyTag : Fuzzer Int
fuzzyTag=intRange 1 30

fuzzyNotTag : Fuzzer Int
fuzzyNotTag= intRange 300 400

selectorsTag : List Selector
selectorsTag = [ Selector.attribute (Attributes.title "etiqueta de información") ]

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

-- The content of the field
withStateContent: Int -> SettingsEntity.Model
withStateContent value = {
    attributes = [
        attr ui_content (createString value)
    ]
 }

fuzzyContent : Fuzzer Int
fuzzyContent= constant 1000

fuzzyNotContent : Fuzzer Int
fuzzyNotContent= intRange biggerThanVeryLarge (10*biggerThanVeryLarge)

selectorsContent : List Selector
selectorsContent = [ Selector.tag "tag" , Selector.attribute (Attributes.value (createString 1000))]

selectorsNotContent : List Selector
selectorsNotContent = [Selector.attribute (attribute "data-bubblegum-warn" "unsatisfied-constraint:within-string-chars-range:(0,60000)") ]

-- Tag representing a successful facet of the content
withStateSuccessTag: Int -> SettingsEntity.Model
withStateSuccessTag value = {
    attributes = [
        attr ui_successTag (createString value)
    ]
 }

fuzzySuccessTag : Fuzzer Int
fuzzySuccessTag=intRange 1 30

fuzzyNotSuccessTag : Fuzzer Int
fuzzyNotSuccessTag= intRange 300 400

selectorsSuccessTag : List Selector
selectorsSuccessTag = [ Selector.classes ["tag", "is-success"],
    Selector.attribute (Attributes.title "etiqueta que indica el éxito") ]

-- Tag representing a warning aspect of the content
withStateWarningTag: Int -> SettingsEntity.Model
withStateWarningTag value = {
    attributes = [
        attr ui_warningTag (createString value)
    ]
 }

fuzzyWarningTag : Fuzzer Int
fuzzyWarningTag=intRange 1 30

fuzzyNotWarningTag : Fuzzer Int
fuzzyNotWarningTag= intRange 300 400

selectorsWarningTag : List Selector
selectorsWarningTag = [ Selector.classes ["tag", "is-warning"],
    Selector.attribute (Attributes.title "etiqueta que indica advertencia") ]

-- Tag representing a dangerous aspect of the content
withStateDangerTag: Int -> SettingsEntity.Model
withStateDangerTag value = {
    attributes = [
        attr ui_dangerTag (createString value)
    ]
 }

fuzzyDangerTag : Fuzzer Int
fuzzyDangerTag=intRange 1 30

fuzzyNotDangerTag : Fuzzer Int
fuzzyNotDangerTag= intRange 300 400

selectorsDangerTag : List Selector
selectorsDangerTag = [ Selector.classes ["tag", "is-danger"],
    Selector.attribute (Attributes.title "etiqueta que indica peligro") ]

-- The unique id of the content
withStateContentId: Int -> SettingsEntity.Model
withStateContentId value = {
    attributes = [
        attr ui_contentId (createString value)
    ]
 }

fuzzyContentId : Fuzzer Int
fuzzyContentId=constant 100

fuzzyNotContentId : Fuzzer Int
fuzzyNotContentId= intRange biggerThanMedium (4*biggerThanMedium)

selectorsContentId : List Selector
selectorsContentId = [ Selector.tag "tag" , Selector.attribute (Attributes.id (createString 100))]

selectorsNotContentId : List Selector
selectorsNotContentId = [ Selector.tag "tag" ,
    Selector.attribute (attribute "data-bubblegum-warn" "unsatisfied-constraint:within-string-chars-range:(1,128)") ]

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