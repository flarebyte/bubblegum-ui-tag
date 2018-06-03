module AttributeDoc exposing (AttributeDoc, Cardinality(..), createKey)


type Cardinality
    = OnlyOne
    | ZeroOrOne
    | OneOrMany
    | ZeroOrMany


type alias AttributeDoc =
    { key : String
    , description : String
    , facets : List String
    , suggestions : List String
    , cardinality : Cardinality
    }


createKey : String -> Cardinality -> List String -> String -> AttributeDoc
createKey key cardinality suggestions description =
    { key = key
    , description = description
    , facets = []
    , suggestions = suggestions
    , cardinality = cardinality
    }
