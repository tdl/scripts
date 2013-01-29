#!/usr/bin/env ruby

# this is easier to just do with a Unix one-liner,
# but I wanted to run this on a Windows machine and
# didn't want to install Cygwin.
def delete_0_bytes_files(dir)
  count = 0
  Dir.glob("#{dir}/**/*") do |f|
    next if File.directory?(f)
    begin
      if File.size(f) == 0
        count += File.delete(f)
        puts "File #{f} deleted." 
      end
    rescue Exception => e
      puts "Exception deleting #{f}: ", e    
    end
  end
  count  
end

def check_usage
  unless ARGV.length == 1
    puts "Usage: #{File.basename($0)} <dir>"
    puts "Delete all 0-bytes files in the given dir and subdirs."
    puts "Prints the total number of deleted files, if any."
    exit
  end 
end

if $0 == __FILE__
  check_usage
  count = delete_0_bytes_files(ARGV[0])
  puts "#{count} files were deleted."
end

