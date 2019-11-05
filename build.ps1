# build.ps1

Clear-Host

# Cleaning up
if (Test-Path .\bin\main.exe) {
    Remove-Item -Path .\bin\main.exe
}

if (Test-Path .\bin\main.tmp.c) {
    Remove-Item -Path .\bin\main.tmp.c
}

# Compile
"Compiling ..."
v -o bin\main.exe .\src\main.v

# We could not compile due to some reason.
if ($LastExitCode -eq 1) {
    "Compilation failed!"
    Exit
}

"done compiling.`n"

# Run
if (Test-Path .\bin\main.exe) {
    .\bin\main.exe
} else {
    "No executable to run!"
}