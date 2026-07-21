require 'xcodeproj'

begin
  project_path = 'Runner.xcodeproj'
  puts "Looking for project at: #{project_path}"

  unless File.exist?(project_path)
    puts "Error: #{project_path} not found in #{Dir.pwd}"
    exit 1
  end

  project = Xcodeproj::Project.open(project_path)
  target_name = 'QuranWidget'

  target = project.targets.find { |t| t.name == target_name }

  if target
    puts "Target #{target_name} already exists. Skipping."
  else
    puts "Creating target #{target_name}..."

    # Create the target
    # Signature: new_target(product_type, name, platform = nil)
    target = project.new_target(:app_extension, target_name, :ios)

    # Set the product type (this is often set by the new_target call but good to be explicit)
    target.product_type = 'com.apple.product-type.app-extension'

    # Set build settings for both configurations
    ['Debug', 'Release'].each do |config|
      target.build_settings(config)['PRODUCT_BUNDLE_IDENTIFIER'] = 'com.abuhashim.khalaf_quran.QuranWidget'
    end

    # Add source files
    widget_files = Dir.glob('Runner/Widgets/*.swift')
    puts "Found widget files: #{widget_files.join(', ')}"

    widget_files.each do |file|
      ref = project.objects.find { |o| o.respond_to?(:path) && o.path == file } || project.add_file(file)
      target.add_build_file(ref)
    end

    # Set Info.plist
    target.info_plist_file = 'Runner/Widgets/Info.plist'
    puts "Set Info.plist to: #{target.info_plist_file}"

    # Set Entitlements
    target.entitlements_file = 'Runner/Widgets/QuranWidget.entitlements'
    puts "Set Entitlements to: #{target.entitlements_file}"

    # Add target dependency to the main Runner target
    runner_target = project.targets.find { |t| t.name == 'Runner' }
    if runner_target
      runner_target.add_target_dependency(target)
      puts "Added #{target_name} as dependency to Runner target."
    else
      puts "Warning: Runner target not found, could not add dependency."
    end

    project.save
    puts "Successfully created and saved target #{target_name}."
  end
rescue Exception => e
  puts "An error occurred during target creation:"
  puts e.message
  puts e.backtrace
  exit 1
end
