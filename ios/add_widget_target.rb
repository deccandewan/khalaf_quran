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
    puts "Target #{target_name} already exists. Updating settings..."
  else
    puts "Creating target #{target_name}..."
    target = project.new_target(:app_extension, target_name, :ios)
  end

  # Set build settings for both configurations
  ['Debug', 'Release'].each do |config_name|
    config = target.build_configuration_list[config_name]
    runner_target = project.targets.find { |t| t.name == 'Runner' }
    parent_bundle_id = runner_target.build_configurations.first.build_settings['PRODUCT_BUNDLE_IDENTIFIER'] || 'com.abuhashim.khalafquran'

    config.build_settings['PRODUCT_BUNDLE_IDENTIFIER'] = "#{parent_bundle_id}.QuranWidget"
    config.build_settings['PRODUCT_NAME'] = target_name
    config.build_settings['GENERATE_INFOPLIST_FILE'] = 'NO'
    config.build_settings['INFOPLIST_FILE'] = 'Runner/Widgets/Info.plist'
    config.build_settings['CODE_SIGN_ENTITLEMENTS'] = 'Runner/Widgets/QuranWidget.entitlements'
    config.build_settings['CODE_SIGN_STYLE'] = 'Automatic'
    config.build_settings['SWIFT_VERSION'] = '5.9'
    config.build_settings['TARGETED_DEVICE_FAMILY'] = '1,2'
    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
    config.build_settings['SKIP_INSTALL'] = 'YES'
  end

  # Find or create a group for the widget source files.
  widget_group = project.main_group.find_subpath('Runner/Widgets', true)
  widget_group.set_path('Widgets') if widget_group.path.nil?

  # Add source files
  widget_files = Dir.glob('Runner/Widgets/*.swift')
  widget_files.each do |file|
    file_name = File.basename(file)
    file_ref = widget_group.files.find { |f| f.path == file_name }
    file_ref ||= widget_group.new_file(file_name)
    target.add_file_references([file_ref])
  end

  # Add target dependency and embed
  runner_target = project.targets.find { |t| t.name == 'Runner' }
  if runner_target
    runner_target.add_dependency(target)

    # App extensions (including widgets) MUST be embedded into the app's
    # PlugIns/ folder, NOT Frameworks/. Look specifically for a PlugIns
    # copy-files phase, and never reuse the "Embed Frameworks" phase.
    embed_phase = runner_target.copy_files_build_phases.find do |p|
      p.symbol_dst_subfolder_spec == :plug_ins
    end
    embed_phase ||= runner_target.new_copy_files_build_phase('Embed Foundation Extensions')
    embed_phase.symbol_dst_subfolder_spec = :plug_ins
    embed_phase.name = 'Embed Foundation Extensions'

    product_ref = target.product_reference
    if product_ref
      unless embed_phase.files.any? { |f| f.file_ref == product_ref }
        build_file = embed_phase.add_file_reference(product_ref)
        build_file.settings = { 'ATTRIBUTES' => ['CodeSignOnCopy', 'RemoveHeadersOnCopy'] }
      end
    end

    # Flutter's iOS template ends the Runner target's build phases with a
    # "Thin Binary" run-script phase (xcode_backend.sh) that touches the
    # whole Runner.app bundle but declares no explicit outputs. If our embed
    # phase sits AFTER it (the default when appending a new phase), Xcode's
    # new build system can't prove a safe order between the two and reports
    # "Cycle inside Runner". Move the embed phase to run BEFORE Thin Binary.
    runner_target.build_phases.delete(embed_phase)
    thin_binary_index = runner_target.build_phases.find_index do |p|
      p.respond_to?(:name) && p.name == 'Thin Binary'
    end
    if thin_binary_index
      runner_target.build_phases.insert(thin_binary_index, embed_phase)
    else
      runner_target.build_phases << embed_phase
    end
  end

  project.save
  puts "Successfully processed target #{target_name}."
rescue Exception => e
  puts "An error occurred during target creation:"
  puts e.message
  puts e.backtrace
  exit 1
end
