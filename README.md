# Tag Widget

> Tag widget for the Bubblegum UI toolkit

[![Build Status](https://semaphoreci.com/api/v1/olih/bubblegum-ui-tag/branches/master/badge.svg)](https://semaphoreci.com/olih/bubblegum-ui-tag)

Please check the [demo](https://flarebyte.github.io/bubblegum-ui-tag/)

![listbox tag widget](tag-widget.jpg)

### Installing Elm packages

There is no dependency.

```
elm-package install flarebyte/bubblegum-ui-tag
```

## Configuring the widget

```
import Bubblegum.Tag.Adapter as Adapter
import Bubblegum.Tag.Widget as Widget
import Bubblegum.Entity.SettingsEntity as SettingsEntity
import Bubblegum.Entity.StateEntity as StateEntity
import Bubblegum.Entity.Attribute as Attribute


type TestMsg
    = OnSearchInput String
    | OnToggleDropbox
    | OnAddTag String
    | OnDeleteTag String

attr: String -> String -> Attribute.Model
attr key value =
     { id = Nothing
    , key = key
    , facets = []
    , values = [value]
    }  

adapter : Adapter.Model TestMsg
adapter =  =
        { onSearchInput = OnSearchInput
        , onToggleDropbox = OnToggleDropbox
        , onAddTag = OnAddTag
        , onDeleteTag = OnDeleteTag
        }

userSettings: SettingsEntity.Model
userSettings = {
    attributes = [
        attr "ui:user-language" "en-GB"
    ]
 }

settings: SettingsEntity.Model
settings = {
    attributes = [
        attr "ui:label" "Label for field"
    ] ++ getExampleAttributes -- see tests/WidgetTestData
 }

state: StateEntity.Model
state = {
    attributes = [
        attr ui_suggesting "true"
        , attrs ui_selected [ "id:suggestion:1", "id:suggestion:3" ]
        ]
 }

  Widget.view adapter userSettings settings state     

```

## Widget configuration

### User Settings

 * **ui:content-right-to-left** : Whether the content requires right to left (Bool)
 * **ui:user-language** : Language used by the user (String)
 * **ui:user-right-to-left** : Whether the user is using right to left (Bool)

### Settings

 * **ui:suggestion** : The list of suggested tags for the field (List String)
 * **ui:help** : Some help tip related to the field (String)
 * **ui:label** : Label related to the field (String)
 * **ui:search-label** : Label related to the search field (String)
 * **ui:success-minimum-tags** : The minimum number of tags needed for successful content (Int)
 * **ui:success-maximum-tags** : The maximum number of tags needed for successful content (Int)
 * **ui:danger-minimum-tags** : Warning when under the minimum number of tags (Int)
 * **ui:danger-maximum-tags** : Warning when over the maximum number of tags (Int)

And for each suggestion, you need to describe further:

 * **ui:constituent-label** : Label of the constituent (String)
 * **ui:constituent-description** : Description of the constituent (String)
 * **ui:constituent-tag** : Tag used to describe the constituent (List String)
 * **ui:constituent-warning-tag** : Tag representing a warning aspect of the constituent (List String)
 * **ui:constituent-danger-tag** : Tag representing a dangerous aspect of the constituent (List String)

### State

 * **ui:selected** : The selected tags for the field (List String)
 * **ui:suggesting** : Suggesting is currently happening (Bool)
 * **ui:search** : Search term for filtering the available options (String)
 * **ui:danger-help** : Help message to highlight an issue with the content (String)
 
## Technical design

See [Technical design](TECHNICAL_DESIGN.md)

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

Managed automatically by [Elm version rules](https://github.com/elm-lang/elm-package#version-rules).

## Authors

* **Olivier Huin** - *Initial work* - [olih](https://github.com/olih)

See also the list of [contributors](https://github.com/flarebyte/bubblegum-ui-tag/graphs/contributors) who participated in this project.

## License

This project is licensed under the BSD 3-Clause License - see the [LICENSE.md](LICENSE) file for details
