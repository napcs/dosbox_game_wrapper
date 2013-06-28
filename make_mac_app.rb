# Bundles game inside of DosBox
#
require 'fileutils'
dirname = File.basename(Dir.getwd)
command = "#{dirname}.command"

output = File.join "output", "osx"

FileUtils.rm_rf output
FileUtils.mkdir_p output

base_path = File.join(output, "#{dirname}.app")

FileUtils.cp_r "osx/DOSBox.app", base_path

# Icons
FileUtils.rm File.join(base_path, "Contents", "Resources", "dosbox.icns")
FileUtils.cp_r "game.icns", File.join(base_path, "Contents", "Resources", "#{dirname}.icns")

content_path = File.join(base_path, "Contents", "MacOS")

FileUtils.mkdir_p content_path

FileUtils.cp_r "game", File.join(content_path, "game")
FileUtils.cp_r "dosbox.conf.osx", File.join(content_path, "#{dirname}.conf")


# Create launcher
path_to_command = File.join(content_path, command)
File.open path_to_command , "w" do |f|
   f << %Q{#!/bin/sh
cd "`dirname "$0"`"
./DOSBox -conf #{dirname}.conf 
   }
end
`chmod +x #{path_to_command}`



# Modify PLIST
#
plist = File.join(base_path, "contents", "Info.plist")
File.open plist, "w" do |f|
  string = %Q{<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleDevelopmentRegion</key>
  <string>English</string>
  <key>CFBundleDisplayName</key>
  <string>#{dirname}</string>
  <key>CFBundleExecutable</key>
  <string>#{command}</string>
  <key>CFBundleGetInfoString</key>
  <string>0.74-1, Copyright 2002-2012 The DOSBox Team</string>
  <key>CFBundleIconFile</key>
  <string>#{dirname}.icns</string>
  <key>CFBundleInfoDictionaryVersion</key>
  <string>6.0</string>
  <key>CFBundleName</key>
  <string>#{dirname}</string>
  <key>CFBundlePackageType</key>
  <string>APPL</string>
  <key>CFBundleShortVersionString</key>
  <string>0.74-1</string>
  <key>CFBundleVersion</key>
  <string>0.74-1</string>
  <key>NSHumanReadableCopyright</key>
  <string>Copyright 2002-2012 The DOSBox Team</string>
  <key>NSPrincipalClass</key>
  <string>NSApplication</string>
        <key>CGDisableCoalescedUpdates</key>
        <true/>
</dict>
</plist>}
  f << string
end


# Compress
Dir.chdir output do
  `zip -r9 #{dirname}.zip #{dirname}.app`
end