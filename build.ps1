# build.ps1

Clear-Host

# Cleaning up
if (Test-Path .\main.exe) {
    Remove-Item -Path .\main.exe
}

if (Test-Path .\main.tmp.c) {
    Remove-Item -Path .\main.tmp.c
}

# Compile
v .\main.v

# We could not compile due to some reason.
if ($LastExitCode -eq 1) {
    "Compilation failed!"
    Exit
}

# Run
if (Test-Path .\main.exe) {
    .\main.exe
} else {
    "No executable to run!"
}