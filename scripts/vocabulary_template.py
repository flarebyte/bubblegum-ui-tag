#!/usr/bin/python


## Vocabulary

headerVocabulary = """
module Bubblegum.Tag.Vocabulary exposing (..)

{-| List of keys used for the settings

    **Generated** by generate-vocabulary.py

-}

"""
templateVocabulary = """
{-|  $description. ($signature) -}
ui_$namecamel: String
ui_$namecamel =
    "ui:$name"
"""

## Key Description

headerKeyDescription = """
module KeyDescription exposing (..)

{-| List of descriptions for the keys used for the settings

    **Generated** by generate-vocabulary.py

-}

"""
templateKeyDescription = """
desc$nameCamel: String
desc$nameCamel =
    "$description"    
"""

## Vocabulary Helper

headerVocabularyHelper = """
module Bubblegum.Tag.VocabularyHelper exposing (..)

{-| Helpers for accessing settings
 
    **Generated** by generate-vocabulary.py

-}

import Bubblegum.Entity.Validation as Validation
import Bubblegum.Entity.SettingsEntity as SettingsEntity
import Bubblegum.Entity.StateEntity as StateEntity
import Bubblegum.Entity.Outcome as Outcome exposing (..)
import Bubblegum.Tag.EntityHelper exposing (..)
import Bubblegum.Tag.HelperLimits exposing (..)
import Bubblegum.Tag.Vocabulary exposing (..)

"""
templateVocabularyHelperString = """
{-|  $description -}
get$nameCamel : $entity.Model -> Outcome String
get$nameCamel settings =
    findString ui_$namecamel settings.attributes
        $rangeRestriction
"""

templateVocabularyHelperStringForId = """
{-|  $description -}
get$nameCamel : $entity.Model -> String -> Outcome String
get$nameCamel settings id =
    findStringForId ui_$namecamel settings.attributes id
        $rangeRestriction
"""

templateVocabularyHelperListString = """
{-|  $description -}
get$nameCamel : $entity.Model -> Outcome (List String)
get$nameCamel settings =
    findListString ui_$namecamel settings.attributes
        $rangeRestriction
"""

templateVocabularyHelperListCurie = """
{-|  $description -}
get$nameCamel : $entity.Model -> Outcome (List String)
get$nameCamel settings =
    findListCompactUri ui_$namecamel settings.attributes
"""

templateVocabularyHelperListStringForId = """
{-|  $description -}
get$nameCamel : $entity.Model -> String ->  Outcome (List String)
get$nameCamel settings id =
    findListStringForId ui_$namecamel settings.attributes id
        $rangeRestriction
"""

templateVocabularyHelperBool = """
{-|  $description -}
is$nameCamel : $entity.Model -> Outcome Bool
is$nameCamel settings =
    findBool ui_$namecamel settings.attributes
"""

templateVocabularyHelperBoolForId = """
{-|  $description -}
is$nameCamel : $entity.Model -> String -> Outcome Bool
is$nameCamel settings id =
    findBoolForId ui_$namecamel settings.attributes id
"""

templateVocabularyHelperIntRange = """
{-|  $description -}

$methodName: $entity.Model -> Outcome ( Int, Int )
$methodName settings =
    findIntRange ( $minKey, $maxKey ) settings.attributes
        |> Validation.withinIntRange limitVeryLargeRangeNotEmpty
"""

# Widget Doc Data

headerWidgetDocData = """
module WidgetDocData exposing (tagWidgetDoc)

import AttributeDoc exposing (AttributeDoc, Cardinality(..), createKey)
import Bubblegum.Tag.Vocabulary exposing (..)
import KeyDescription exposing (..)
import WidgetDoc exposing (..)
import WidgetPackageJson

{-| Some examples of settings for the demo.
 
    **Generated** by generate-vocabulary.py

-}

tagWidgetDoc : WidgetDoc
tagWidgetDoc =
    { meta = WidgetPackageJson.meta
    , userSettings = [
"""


templateWidgetDocDataString = """  createKey ui_$namecamel ZeroOrOne [ $examples ] desc$nameCamel
"""

# WidgetCreateTests

headerWidgetCreateTests = """module WidgetCreateTests exposing (..)

{-| Unit tests for testing the view of the Widget

    **Generated** by generate-vocabulary.py
    
-}
import Test exposing (..)
import WidgetTestData exposing (..)


suite : Test
suite =
    describe "The Widget module"
        [ describe "Widget.view"
            [
"""

templateWidgetCreateTestsSettingsCorrect = """
                fuzz fuzzy$nameCamel "Correct settings for $description" <|
                \\value -> viewWidgetWithSettings (withSettings$nameCamel value)
                    |> findComponent selectors$nameCamel
"""
templateWidgetCreateTestsSettingsWrong = """
              , fuzz fuzzyNot$nameCamel "Wrong settings for $description" <|
                \\value -> viewWidgetWithSettings (withSettings$nameCamel value)
                    |> findWarningDiv           
"""

templateWidgetCreateTestsSettingsWrongAttr = """
             , fuzz fuzzyNot$nameCamel "Wrong settings for $description" <|
                \\value -> viewWidgetWithSettings (withSettings$nameCamel value)
                    |> findComponent selectorsNot$nameCamel
"""

templateWidgetCreateTestsUserSettingsCorrect = """
                fuzz fuzzy$nameCamel "Correct settings for $description" <|
                \\value -> viewWidgetWithUserSettings (withUserSettings$nameCamel value)
                    |> findComponent selectors$nameCamel
"""
templateWidgetCreateTestsUserSettingsWrong = """
              , fuzz fuzzyNot$nameCamel "Wrong settings for $description" <|
                \\value -> viewWidgetWithUserSettings (withUserSettings$nameCamel value)
                    |> findWarningDiv           
"""

templateWidgetCreateTestsUserSettingsWrongAttr = """
             , fuzz fuzzyNot$nameCamel "Wrong settings for $description" <|
                \\value -> viewWidgetWithUserSettings (withUserSettings$nameCamel value) 
                    |> findComponent selectorsNot$nameCamel
"""

templateWidgetCreateTestsStateCorrect = """
                fuzz fuzzy$nameCamel "Correct settings for $description" <|
                \\value -> viewWidgetWithState (withState$nameCamel value)
                    |> findComponent selectors$nameCamel
"""
templateWidgetCreateTestsStateWrong = """
              , fuzz fuzzyNot$nameCamel "Wrong settings for $description" <|
                \\value -> viewWidgetWithState (withState$nameCamel value)
                    |> findWarningDiv           
"""

templateWidgetCreateTestsStateWrongAttr = """
             , fuzz fuzzyNot$nameCamel "Wrong settings for $description" <|
                \\value -> viewWidgetWithState (withState$nameCamel value) 
                    |> findComponent selectorsNot$nameCamel
"""

templateTemp = ""

checkTemplateTestData = "fuzzy$nameCamel"

templateTestData = """
-- $description
withSettings$nameCamel: Int -> SettingsEntity.Model
withSettings$nameCamel value = {
    attributes = [
        attr ui_$namecamel (createString value)
    ]
 }

fuzzy$nameCamel : Fuzzer Int
fuzzy$nameCamel = intRange 1 1

fuzzyNot$nameCamel : Fuzzer Int
fuzzyNot$nameCamel = intRange 100 400 

selectors$nameCamel : List Selector
selectors$nameCamel = [ Selector.class "bubblegum-tag__input", Selector.attribute (Attributes.lang "es") ]

selectorsNot$nameCamel : List Selector
selectorsNot$nameCamel = [ Selector.class "bubblegum-tag__input", 
    Selector.attribute (attribute "data-bubblegum-warn" "unsatisfied-constraint:") ]

"""

templateReadme = """ * **ui:$name** : $description ($signature)"""

footerWidgetCreateTests = """
            ]
        ]
"""
