# Locations

PSHTML locations is a simple concept which applies for `Assets` and `Includes`.

There are currently two possible location to host your Assets / Includes:

- Module
- Project

## Module

The module location referes to the `PSHTML` module folder. By default, it is located at `$ModuleRoot\Assets` for assets and `$ModuleRoot\Includes` for include files.

## Project

The `project` location referes to the place where the scrpit containing the `PSHTML` code is located. 
The assets and Includes folders are accessible respectivly via `$PsScriptRoot\Assets` and `$PsScriptRoot\Includes`

> by default, neither the `Assets` nor the `Includes` folder are present in the Project folder. If Assets or includes are something you need on a project level, simply create a the right corresponding folder at the same level as your script.

### Assets

It already contains assets which ship by default with the module (BootStrap,JQuery, ChartJS). 


### Includes

The module doesn't ship with any default include files.


