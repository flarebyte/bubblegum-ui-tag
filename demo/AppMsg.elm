module AppMsg exposing (AppMsg(..))


type AppMsg
    = OnSearchInputContent String
    | OnSelectSetting Bool String String
    | OnSelectState String String
    | OnActivateSetting Bool String
    | OnActivateState String
    | OnToggleDropbox
    | OnAddTag String
    | OnDeleteTag String
