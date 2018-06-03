module Bubblegum.Tag.Adapter exposing (..)

{-| Adapter which converts event handlers for the tag widget
-}


{-| Hook into the onInput event
See <https://www.w3schools.com/jsref/event_oninput.asp>

    { onInput = OnInputContent }

-}
type alias Model msg =
    { onInput : String -> msg
    }
