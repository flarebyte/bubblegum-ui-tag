
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

translateInfoTag : IsoLanguage -> String
translateInfoTag language =
     case language of

       Chinese ->
             "信息標籤"

       English ->
             "information tag"

       French ->
             "étiquette d'information"

       German ->
             "Informationstag"

       Italian ->
             "tag di informazione"

       Japanese ->
             "情報タグ"

       Russian ->
             "информационный тег"

       Spanish ->
             "etiqueta de información"

       Swedish ->
             "information tag"

       Vietnamese ->
             "information tag"

       Romanian ->
             "information tag"

       Dutch ->
             "information tag"

       Korean ->
             "information tag"

       Danish ->
             "information tag"

       Bulgarian ->
             "information tag"

       Hungarian ->
             "information tag"

       Ukrainian ->
             "information tag"

       Turkish ->
             "information tag"

       Norwegian ->
             "information tag"

       Thai ->
             "information tag"

       Finnish ->
             "information tag"

       Indonesian ->
             "information tag"

       Greek ->
             "information tag"

       Portuguese ->
             "information tag"

       Czech ->
             "information tag"

       Persian ->
             "information tag"

       Slovak ->
             "information tag"

       Hebrew ->
             "information tag"

       Polish ->
             "information tag"

       Arabic ->
             "information tag"



translateSuccessTag : IsoLanguage -> String
translateSuccessTag language =
     case language of

       Chinese ->
             "成功標籤"

       English ->
             "tag indicating success"

       French ->
             "étiquette indiquant le succès"

       German ->
             "Tag der den Erfolg anzeigt"

       Italian ->
             "tag che indica il successo"

       Japanese ->
             "成功を示すタグ"

       Russian ->
             "тег указывающий успех"

       Spanish ->
             "etiqueta que indica el éxito"

       Swedish ->
             "tag indicating success"

       Vietnamese ->
             "tag indicating success"

       Romanian ->
             "tag indicating success"

       Dutch ->
             "tag indicating success"

       Korean ->
             "tag indicating success"

       Danish ->
             "tag indicating success"

       Bulgarian ->
             "tag indicating success"

       Hungarian ->
             "tag indicating success"

       Ukrainian ->
             "tag indicating success"

       Turkish ->
             "tag indicating success"

       Norwegian ->
             "tag indicating success"

       Thai ->
             "tag indicating success"

       Finnish ->
             "tag indicating success"

       Indonesian ->
             "tag indicating success"

       Greek ->
             "tag indicating success"

       Portuguese ->
             "tag indicating success"

       Czech ->
             "tag indicating success"

       Persian ->
             "tag indicating success"

       Slovak ->
             "tag indicating success"

       Hebrew ->
             "tag indicating success"

       Polish ->
             "tag indicating success"

       Arabic ->
             "tag indicating success"



translateWarningTag : IsoLanguage -> String
translateWarningTag language =
     case language of

       Chinese ->
             "警告標籤"

       English ->
             "tag indicating warning"

       French ->
             "étiquette indiquant l'avertissement"

       German ->
             "Tag der die Warnung anzeigt"

       Italian ->
             "tag che indica avvertimento"

       Japanese ->
             "警告を示すタグ"

       Russian ->
             "тег указывающий предупреждение"

       Spanish ->
             "etiqueta que indica advertencia"

       Swedish ->
             "tag indicating warning"

       Vietnamese ->
             "tag indicating warning"

       Romanian ->
             "tag indicating warning"

       Dutch ->
             "tag indicating warning"

       Korean ->
             "tag indicating warning"

       Danish ->
             "tag indicating warning"

       Bulgarian ->
             "tag indicating warning"

       Hungarian ->
             "tag indicating warning"

       Ukrainian ->
             "tag indicating warning"

       Turkish ->
             "tag indicating warning"

       Norwegian ->
             "tag indicating warning"

       Thai ->
             "tag indicating warning"

       Finnish ->
             "tag indicating warning"

       Indonesian ->
             "tag indicating warning"

       Greek ->
             "tag indicating warning"

       Portuguese ->
             "tag indicating warning"

       Czech ->
             "tag indicating warning"

       Persian ->
             "tag indicating warning"

       Slovak ->
             "tag indicating warning"

       Hebrew ->
             "tag indicating warning"

       Polish ->
             "tag indicating warning"

       Arabic ->
             "tag indicating warning"



translateDangerTag : IsoLanguage -> String
translateDangerTag language =
     case language of

       Chinese ->
             "危險標籤"

       English ->
             "tag indicating danger"

       French ->
             "étiquette indiquant le danger"

       German ->
             "Tag der die Gefahr anzeigt"

       Italian ->
             "tag che indica pericolo"

       Japanese ->
             "危険を示すタグ"

       Russian ->
             "тег указывающий опасность"

       Spanish ->
             "etiqueta que indica peligro"

       Swedish ->
             "tag indicating danger"

       Vietnamese ->
             "tag indicating danger"

       Romanian ->
             "tag indicating danger"

       Dutch ->
             "tag indicating danger"

       Korean ->
             "tag indicating danger"

       Danish ->
             "tag indicating danger"

       Bulgarian ->
             "tag indicating danger"

       Hungarian ->
             "tag indicating danger"

       Ukrainian ->
             "tag indicating danger"

       Turkish ->
             "tag indicating danger"

       Norwegian ->
             "tag indicating danger"

       Thai ->
             "tag indicating danger"

       Finnish ->
             "tag indicating danger"

       Indonesian ->
             "tag indicating danger"

       Greek ->
             "tag indicating danger"

       Portuguese ->
             "tag indicating danger"

       Czech ->
             "tag indicating danger"

       Persian ->
             "tag indicating danger"

       Slovak ->
             "tag indicating danger"

       Hebrew ->
             "tag indicating danger"

       Polish ->
             "tag indicating danger"

       Arabic ->
             "tag indicating danger"
