module AppMsg exposing (AppMsg(..))


type AppMsg
    = OnInputContent String
    | OnSelectSetting Bool String String
    | OnSelectState String String
    | OnActivateSetting Bool String
    | OnActivateState String
    | OnToggleDropbox
