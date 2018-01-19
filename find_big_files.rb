custom_suffix = ""
ARGV.each { |a|
  custom_suffix = a
  break
}

allfiles = nil
if custom_suffix.empty?
  allfiles = Dir["**/*.*"]
else
  allfiles = Dir["**/*.{#{custom_suffix}}"]
end
allfiles = allfiles.sort_by {|filename| File.size(filename) }
allfiles.reverse!

file_target_name = "find_big_files.txt"
File.open(file_target_name,  "w+") { |file_target|
  allfiles.each { |file|
    filename = File.basename(file)
    file_size = '%.3f' % (File.size(file).to_f / 2**20)
    file_target.puts "#{file_size}MB  #{filename}  #{file}"
  }
}

puts "********************** Files Statistics: #{file_target_name}"
puts "********************** Files count: #{allfiles.count}"
puts "********************** Completed!"