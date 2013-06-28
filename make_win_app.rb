# Bundles game inside of DosBox
#
require 'fileutils'
dirname = File.basename(Dir.getwd)
command = "#{dirname}.bat"

output = File.join "output", "windows"

FileUtils.rm_rf output
FileUtils.mkdir_p output

base_path = File.join(output, "#{dirname}")

FileUtils.mkdir base_path

FileUtils.cp_r "game.ico", File.join(base_path, "#{dirname}.ico")


FileUtils.cp_r "windows", File.join(base_path, "dosbox")

FileUtils.cp_r "game", File.join(base_path, "game")
FileUtils.cp_r "dosbox.conf.win", File.join(base_path, "#{dirname}.conf")


# Create launcher
path_to_command = File.join(base_path, command)
File.open path_to_command , "w" do |f|
   f << %Q{
   cd /d %~dp0
   dosbox\\DOSBox.exe -conf #{dirname}.conf 
   }
end

# Compress
Dir.chdir output do
  `zip -r9 #{dirname}.zip #{dirname}`
end


