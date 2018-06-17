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


toIsoLanguage : String -> IsoLanguage
toIsoLanguage language =
    case getLanguageCode language of
        "ar" ->
            Arabic

        "bg" ->
            Bulgarian

        "zh" ->
            Chinese

        "cs" ->
            Czech

        "da" ->
            Danish

        "nl" ->
            Dutch

        "en" ->
            English

        "fi" ->
            Finnish

        "fr" ->
            French

        "de" ->
            German

        "el" ->
            Greek

        "iw" ->
            Hebrew

        "hu" ->
            Hungarian

        "in" ->
            Indonesian

        "it" ->
            Italian

        "ja" ->
            Japanese

        "ko" ->
            Korean

        "no" ->
            Norwegian

        "fa" ->
            Persian

        "pl" ->
            Polish

        "pt" ->
            Portuguese

        "ro" ->
            Romanian

        "ru" ->
            Russian

        "sk" ->
            Slovak

        "es" ->
            Spanish

        "sv" ->
            Swedish

        "th" ->
            Thai

        "tr" ->
            Turkish

        "uk" ->
            Ukrainian

        "vi" ->
            Vietnamese

        _ ->
            English


type IsoLanguage
    = Arabic
    | Bulgarian
    | Chinese
    | Czech
    | Danish
    | Dutch
    | English
    | Finnish
    | French
    | German
    | Greek
    | Hebrew
    | Hungarian
    | Indonesian
    | Italian
    | Japanese
    | Korean
    | Norwegian
    | Persian
    | Polish
    | Portuguese
    | Romanian
    | Russian
    | Slovak
    | Spanish
    | Swedish
    | Thai
    | Turkish
    | Ukrainian
    | Vietnamese
