# Todo List

There is a lot to accomplish before making this module available to the public.

I plan the following most important milestones:

 - [ ] Provide basic functionality (Generating an HTML document) using the DSL. The following sections are the highest priority:
    - [X] Root
    - [X] Sections
    - [X] Tables
    - [X] blocs
    - [ ] Forms
    - [ ] Textual semantic
    - [X] Metadata

In parallel to this, I want to add the support for the following attributes (as a first step):
- [X] Class
- [X] Id
- [X] Style


Eventually, the following components will also be added:
 - [X] Scripts
 - [X] Include Sections
 - [ ] Interactive Data

 ## The attribute I want to set is not available

The objective, is to have integrated every tag and every possible attribute in PSHTML. Since this needs to be done on an individual basis (per HTML tag), this task is pretty huge, and will take some time to complete HTML 5 Coverage Below.

In the mean time, two ways are available to you:

1. **Prefered Method:** Add the attribute your self, be forking the repository, and simply adding a parameter to the function. 
2. Use the `-Attributes` parameter.


Each function has an additional parameter called: ```Attributes``` of type HashTable.
It allow to add additional html tags without having to list ALL the existing attributes. It offers flexibility for custom and/or special htmls attributes, or the ones that are not immediatly available to you. (Open an issue, if you want to have an additional parameter for a specific html element. Or, you could add it your self, since this is an open sourced project ;) (Read 'contributing' part here under.

### Example:

```powershell
option -Attributes @{"CustomAttributeName"="MyValue"}

```

generates the following HTML:

```HTML
<option CustomAttributeName="MyValue"  >
</option>
```

## HTML 5 coverage

I would like to have all HTML 5 tags available in PSHTML ASAP. The list is currently ongoing, and this is work in progress. It can be followed [here](https://github.com/Stephanevg/PSHTML/issues/7)