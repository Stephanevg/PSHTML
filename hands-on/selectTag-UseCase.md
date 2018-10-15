# SelectTag - Example

> Demo to auto fill the drop down options!


```PowerShell
$Values = 1..5 # Consider this as your resource!
foreach($Value in $Values) {
    selecttag -Content {
        option -Content $Value
    }
}
```

## Output of the above snippet is illustrated below

```html
<select>
    <option>
        1
    </option>
</select>
<select>
    <option>
        2
    </option>
</select>
<select>
    <option>
        3
    </option>
</select>
<select>
    <option>
        4
    </option>
</select>
<select>
    <option>
        5
    </option>
</select>
```