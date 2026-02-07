# Run Format (C#)

Format C# code in the project. When the project has SDK-style .csproj and `dotnet format` is available, run it and apply fixes. Otherwise, report that formatting is not configured or use project-specific format commands (e.g. EditorConfig-based formatting in IDE).

If the user specified files or paths, format only those; otherwise format the solution or project root.
