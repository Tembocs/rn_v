/// Extract login images from Windows 10 and rename them.
import os
import term

fn main() {
	// Get the home directory path, construct the hidden image directory path.
	user_home_dir := os.home_dir()
	original_img_dir := user_home_dir + '\\AppData\\Local\\Packages\\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\\LocalState\\Assets'
	desktop_img_dir := user_home_dir + '\\' + 'Desktop\\processed_images'

	divider := '-'
	os.system('clear')
	println(term.header('Copying image files', divider))
	
	// Remove the previous image directory if it exists.
	os.rmdir_all(desktop_img_dir) or {
		println(err)
	}
	

	// (Re)create the desktop image directory
	os.mkdir(desktop_img_dir) or {
		println(err)
	}

	copied_files_count := copy_image_files(original_img_dir, desktop_img_dir)
	println('Total files copied: $copied_files_count')

	println(term.header('done!', divider))
}

/// Copy image files.
/// Return the number of files successfully copied.
fn copy_image_files(original_path string, desktop_image_dir string) int {	
	// Get files to be copied
	files := os.ls(original_path) or {
		println(err)

		// Nothing has been copied.
		return 0
	}

	// This will be appended to new file name.
	mut suffix := 1
	mut successful_copied := 0

	for item in files {
		old_file_path := original_path + '\\' + item

		new_name := 'image_' + suffix.str() + '.jpg'
		new_file_path := desktop_image_dir + '\\' + new_name
		
		os.cp(old_file_path, new_file_path) or {
			println(err)
			println('Could not copy image: $new_name')
			// exit(1)
		}

		successful_copied++
		suffix++
	}

	// Return the number of files successful copied.
	return successful_copied
}
