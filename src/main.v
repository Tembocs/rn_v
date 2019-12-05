// main.v
// Learning V language.
import os

fn main() {
	deco := decorator('-', 40)
	user_home_dir := os.home_dir()
	original_img_dir := user_home_dir + 'AppData\\Local\\Packages\\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\\LocalState\\Assets'
	desktop_img_dir := user_home_dir + '\\' + 'Desktop\\processed_images'
	
	println(deco)

	messenger('Starting ...')
	clean(desktop_img_dir)
	copied_files_count := copy_image_files(original_img_dir, desktop_img_dir)
	messenger('Total files copied: $copied_files_count')
	messenger('done!')

	println(deco)
}


/// Remove a previous directory if it exists and create a new one.
fn clean(dir_path string) {
	// The os.rmdir(path string) did not work.
	// Therefore this approach was taken.
	if (os.is_dir(dir_path)) {
		files := os.ls(dir_path) or {
			println(err)
			return
		}

		// First remove single file items
		for item in files {
			file_path := dir_path + '\\' + item
			os.rm(file_path)
		}

		// Then remove the directory
		os.rmdir(dir_path)
	}

	messenger('Creating a new image directory ...')
	success := os.mkdir(dir_path) or {
		print(err)
		return
	}

	if (success) {
		messenger('New image directory successful created.')
	} else {
		messenger('Could not create new image directory.')
	}
}

/// Copy image files.
fn copy_image_files(original_path string, desktop_image_dir string) int {	
	// Get files to be copied
	files := os.ls(original_path) or {
		println(err)

		// Nothing has been copied
		return 0
	}

	// This will be appended to new file name.
	mut suffix := 1
	mut successful_copied := 0

	for item in files {
		old_file_path := original_path + '\\' + item

		new_name := 'image_' + suffix.str() + '.jpg'
		new_file_path := desktop_image_dir + '\\' + new_name
		
		success := os.cp(old_file_path, new_file_path) or {
			println(err)

			// Nothing has been copied
			return 0
		}

		if (!success) {
			messenger('Could not copy image: $new_name')
		} else {
			successful_copied++
		}

		suffix++
	}

	// Return the number of files successful copied.
	return successful_copied
}

/// Create a decorator string.
fn decorator(symbol string, times int) string {
	mut deco := symbol

	for i := 0; i < times; i++ {
		deco += symbol
	}

	return deco
}

/// A uniform way to print message to the user on the terminal.
fn messenger(message string) {
	// TODO Prefix or suffix could be added.
	println(message)
}