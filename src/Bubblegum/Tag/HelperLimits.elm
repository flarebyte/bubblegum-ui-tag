module Bubblegum.Tag.HelperLimits exposing (..)

{-| Various limits used accross the widget
-}


limitSmallRange : ( Int, Int )
limitSmallRange =
    ( 0, 32 )


limitMediumRange : ( Int, Int )
limitMediumRange =
    ( 0, 128 )


limitVeryLargeRange : ( Int, Int )
limitVeryLargeRange =
    ( 0, 60000 )


limitSmallRangeNotEmpty : ( Int, Int )
limitSmallRangeNotEmpty =
    ( 1, 32 )


limitMediumRangeNotEmpty : ( Int, Int )
limitMediumRangeNotEmpty =
    ( 1, 128 )


limitVeryLargeRangeNotEmpty : ( Int, Int )
limitVeryLargeRangeNotEmpty =
    ( 1, 60000 )


limitList : Int
limitList =
    8


compactUriLimitList : Int
compactUriLimitList =
    512
