// build.vsh
// To run this script do 'v run build.vsh`
/// The V script for building this project.

// clear host
// This call won't work as of V 0.1.23
// clear()
system("clear")

println("Cleaning ...")

if (is_dir('build')) {
    rm("build/*")
}

if (is_dir('bin')) {
    rm("bin/*")
}


println('Compiling ...')
built_successful := system("v -o bin\\main.exe src\\main.v")

if (built_successful == 0) {
    println("Successful built code!")

    // Now compiling
    println("Done compiling.")

    if (exists("bin\\main.exe")) {
        // clear() does not work so far
        // clear()
        system("clear")
        println("Now running ...")
        system("bin\\main.exe")
    } else {
        println("No executable to run!")
    }
} else {
    println("Build failed, aborting.")
}

