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
    target = project.new_target(:app_extension, target_name, :ios)

    # Set build settings for both configurations
    ['Debug', 'Release'].each do |config_name|
      config = target.build_configuration_list[config_name]
      config.build_settings['PRODUCT_BUNDLE_IDENTIFIER'] = 'com.abuhashim.khalaf_quran.quranwidget'
      config.build_settings['PRODUCT_NAME'] = target_name
      config.build_settings['INFOPLIST_FILE'] = 'Runner/Widgets/Info.plist'
      config.build_settings['CODE_SIGN_ENTITLEMENTS'] = 'Runner/Widgets/QuranWidget.entitlements'
      config.build_settings['SWIFT_VERSION'] = '5.9'
      config.build_settings['TARGETED_DEVICE_FAMILY'] = '1,2'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
      config.build_settings['SKIP_INSTALL'] = 'YES'
    end

    # Find or create a group for the widget source files.
    # Leave source_tree as the default '<group>' so the path resolves
    # relative to the parent (Runner) group's own path.
    widget_group = project.main_group.find_subpath('Runner/Widgets', true)
    widget_group.set_path('Widgets') if widget_group.path.nil?

    # Add source files (skip Info.plist/entitlements, those aren't build files)
    widget_files = Dir.glob('Runner/Widgets/*.swift')
    puts "Found widget files: #{widget_files.join(', ')}"

    widget_files.each do |file|
      file_name = File.basename(file)
      file_ref = widget_group.files.find { |f| f.path == file_name }
      file_ref ||= widget_group.new_file(file_name)
      target.add_file_references([file_ref])
    end

    # Add target dependency to the main Runner target
    runner_target = project.targets.find { |t| t.name == 'Runner' }
    if runner_target
      runner_target.add_dependency(target)
      puts "Added #{target_name} as dependency to Runner target."

      # Embed the widget extension in the main app bundle
      # In Xcode, Embedding is a Copy Files build phase targeting the :frameworks folder.
      embed_phase = runner_target.copy_files_build_phases.find do |p|
        p.symbol_dst_subfolder_spec == :frameworks && p.name =~ /Embed/
      end

      if embed_phase.nil?
        embed_phase = runner_target.new_copy_files_build_phase('Embed App Extensions')
        embed_phase.symbol_dst_subfolder_spec = :frameworks
      end

      product_ref = target.product_reference
      if product_ref
        # Ensure we don't add it multiple times
        unless embed_phase.files.any? { |f| f.file_ref == product_ref }
          build_file = embed_phase.add_file_reference(product_ref)
          # CodeSignOnCopy is MANDATORY for app extensions to run
          build_file.settings = { 'ATTRIBUTES' => ['CodeSignOnCopy'] }
          puts "Embedded #{target_name} product into Runner app bundle with CodeSignOnCopy."
        end
      else
        puts "Warning: Could not find product reference for #{target_name}, embedding failed."
      end
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
