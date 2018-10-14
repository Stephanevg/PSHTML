
# Current known issues

If your issue is not in this list, feel free to open an issue

## piping content into an tag fails when tag is piped and simultaniously set into a -content block

```powershell
 p {} | audio {"w"}
audio : The input object cannot be bound to any parameters for the command either because the command does not take pipeline input or the input and its properties do not match any of the parameters that take pipeline
input.
At line:1 char:8
+ p {} | audio {"w"}
+        ~~~~~~~~~~~
    + CategoryInfo          : InvalidArgument: (<p>:String) [audio], ParameterBindingException
    + FullyQualifiedErrorId : InputObjectNotBound,audio
```

This is actually powershell base behaviour, and is simply not allowed in the language.