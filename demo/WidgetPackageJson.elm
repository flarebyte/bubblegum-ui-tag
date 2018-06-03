module WidgetPackageJson exposing (meta)

import PackageJson


meta : PackageJson.Model
meta =
    { version = "1.0.0"
    , summary = "Tag widget for the Bubblegum UI toolkit."
    , repository = "https://github.com/flarebyte/bubblegum-ui-tag.git"
    , license = "BSD3"
    , exposedModules = [ "Bubblegum.Tag.Widget" ]
    }
