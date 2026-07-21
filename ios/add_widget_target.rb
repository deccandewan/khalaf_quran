require 'xcodeproj'

project_path = 'Runner.xcodeproj'
project = Xcodeproj::Project.open(project_path)

target_name = 'QuranWidget'
target = project.targets.find { |t| t.name == target_name }

if target
  puts "Target #{target_name} already exists. Skipping."
else
  puts "Creating target #{target_name}..."

  # Create the target
  target = project.new_target(:app_extension, target_name, :ios)
  target.product_type = 'com.apple.product-type.app-extension'
  target.bundle_id = 'com.abuhashim.khalaf_quran.QuranWidget'

  # Add source files
  widget_files = Dir.glob('Runner/Widgets/*.swift')
  widget_files.each do |file|
    ref = project.objects.find { |o| o.respond_to?(:path) && o.path == file } || project.add_file(file)
    target.add_build_file(ref)
  end

  # Set Info.plist
  target.info_plist_file = 'Runner/Widgets/Info.plist'

  # Set Entitlements
  target.entitlements_file = 'Runner/Widgets/QuranWidget.entitlements'

  # Set the target's build settings
  target.build_settings['PRODUCT_BUNDLE_IDENTIFIER'] = 'com.abuhashim.khalaf_quran.QuranWidget'
  target.build_settings['SENTRY_DISABLE_AUTO_INSTRUMENTATION'] = '1'

  # Add target dependency to the main Runner target
  runner_target = project.targets.find { |t| t.name == 'Runner' }
  if runner_target
    runner_target.add_target_dependency(target)
    puts "Added #{target_name} as dependency to Runner target."
  end

  project.save
  puts "Successfully created target #{target_name}."
end
