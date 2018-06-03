#!/usr/bin/python


## Language

headerLanguage = """
module Bubblegum.Tag.IsoLanguage exposing (IsoLanguage(..), toIsoLanguage)

{-| Utility to identify ISO languages

    See https://en.wikipedia.org/wiki/Languages_used_on_the_Internet
    And https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes

    **Generated** by generate-translation.py
-}

import String exposing (left)

getLanguageCode : String -> String
getLanguageCode language =
    left 2 language

toIsoLanguage: String -> IsoLanguage
toIsoLanguage language =
    case (getLanguageCode language) of
"""
templateLanguage = """
        "$isoCode" ->
            $name
"""

footerLanguage = """
        _ ->
            English

"""

## I18n

headerI18n = """
module Bubblegum.Tag.Internationalization exposing (..)

{-| Utility to translate some of the text used by the widget
 
    **Generated** by generate-translation.py

-}

import Tuple exposing (first, second)
import Bubblegum.Tag.IsoLanguage exposing (IsoLanguage(..))

pickSingularOrPlural: Int -> (String, String) -> String
pickSingularOrPlural howMany singularOrPlural =
    if howMany < 2 then
        first singularOrPlural
    else
        second singularOrPlural
"""
templateI18nWithPluralMethod = """
translate$nameCamelUpper : IsoLanguage -> Int -> String
translate$nameCamelUpper language howMany =
     case language of
"""
templateI18nWithPluralLanguage= """
       $language ->
            pickSingularOrPlural howMany ( "$translation", "$translation2" )
"""

templateI18nMethod = """
translate$nameCamelUpper : IsoLanguage -> String
translate$nameCamelUpper language =
     case language of
"""
templateI18nLanguage= """
       $language ->
             "$translation"
"""
