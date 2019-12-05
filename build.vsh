// build.vsh
/// The V script for building this project.

// clear host
// clear() does not work so far
system("clear")

// Cleaning
println("Cleaning ...")

if (is_dir('build')) {
    rm("build/*")
}

if (is_dir('bin')) {
    rm("bin/*")
}

// Compile
println('Compiling ...')

// TODO capture return code from this. Does work with the current V version.
system("v -o bin\\main.exe src\\main.v")

println("Done compiling.")

if (exists("bin\\main.exe")) {
    // clear() does not work so far
    system("clear")
    println("Now running ...")
    system("bin\\main.exe")
} else {
    println("No executable to run!")
}

