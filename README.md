# Tag Widget

> Tag widget for the Bubblegum UI toolkit

[![Build Status](https://semaphoreci.com/api/v1/olih/bubblegum-ui-tag/branches/master/badge.svg)](https://semaphoreci.com/olih/bubblegum-ui-tag)

Please check the [demo](https://flarebyte.github.io/bubblegum-ui-tag/)

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
    = OnInputContent String

attr: String -> String -> Attribute.Model
attr key value =
     { id = Nothing
    , key = key
    , facets = []
    , values = [value]
    }  

adapter : Adapter.Model TestMsg
adapter = { onInput = OnInputContent }

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
    ]
 }

state: StateEntity.Model
state = {
    attributes = [
        attr "ui:content" "Some text"
    ]
 }

  Widget.view adapter userSettings settings state     

```

## Widget configuration

### User Settings

 * **ui:content-language** : Language of the content (String)
 * **ui:content-right-to-left** : Whether the content requires right to left (Bool)
 * **ui:user-language** : Language used by the user (String)
 * **ui:user-right-to-left** : Whether the user is using right to left (Bool)

### Settings

 * **ui:help** : Some help tip related to the field (String)
 * **ui:label** : Label related to the field (String)
 * **ui:tag** : Tag used to describe the field (List String)

### State

 * **ui:content-id** : The unique id of the content (String)
 * **ui:content** : The content of the field (String)
 * **ui:danger-help** : Help message to highlight an issue with the content (String)
 * **ui:danger-tag** : Tag representing a dangerous aspect of the content (List String)
 * **ui:success-tag** : Tag representing a successful facet of the content (List String)
 * **ui:warning-tag** : Tag representing a warning aspect of the content (List String)

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
