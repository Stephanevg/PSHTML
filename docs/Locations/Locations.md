## Locations

PSHTML locations is a simple concept which applies for `Assets` and `Includes`.

There are currently two possible location to host your `Assets'/ `Includes`:

- Module
- Project


## Module

The module location referes to the `PSHTML` module folder. By default, it is located at `$ModuleRoot\Assets` for assets and `$ModuleRoot\Includes` for include files.

> PSHTML shipts with the following assets out of the box.
> - BootStrap
> - JQuery
> - ChartJS
> These assets are located in the PSHTML module folder (`$ModuleRoot\Assets`)

> PSHTML doesn't ship with any includes out of the box.

## Project

The `project` location referes to the folder containing the script with the `PSHTML` code is located.
In other words, the `Project` location is the `root` folder of your script.
The assets and Includes folders are accessible respectivly via `$PsScriptRoot\Assets` and `$PsScriptRoot\Includes`

> by default, neither the `Assets` nor the `Includes` folder are present in the Project folder. To start using assets or includes on the `Project` location, simply create a folder (`Assets` / `Includes` depending on your need) at the root of your script. Add the Assets / includes in the corresponding folders and  Re-import the PSHTML module (`Import-module PSHTML -Force`). The newly added `Assets` / `Includes` will be available via intelisense.

## Priority order

PSHTML will search for `Assets` and `Includes` in the `Project` location first followed by the `Module` location.
If there is a conflict (Two assets or two includes with the same name on different locations) then the `Project` location will win.



