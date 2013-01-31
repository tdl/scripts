#!/usr/bin/env ruby

# General solution for finding the longest palindrome in a string, runs in O(n) time.
# Converted from the Python code here: http://www.akalin.cx/longest-palindrome-linear-time
# Wrote this for TheRubyGame challenge 4.

def find_longest_palindrome(string)
  l = [] ; i=0 ; pal_len=0
  while i<string.length
    if i > pal_len and string[i-pal_len-1] == string[i]
      pal_len += 2 ; i += 1
      next
    end
    l << pal_len
    s = l.length - 2
    e = s - pal_len
    
    pal_len = 1
    found = s.downto(e+1).each do |j|    
      d = j - e - 1
      if l[j] == d
        pal_len = d
        break true 
      end
      l << [d, l[j]].min
    end
    i += 1 unless found == true
  end
  l << pal_len
  s = l.length - 2
  e = s - (2 * string.length + 1 - l.length)
  s.downto(e+1).each do |i|    
    d = i - e - 1
    l << [d, l[i]].min
  end
  (mx, i) = l.each_with_index.max
  string[(i-mx)/2 .. (i+mx-1)/2]
end

def check_usage
  unless ARGV.length == 1
    puts <<-EOS 
      Prints out the longest palindrome in a string.
      Usage: #{File.basename($0)} <string>
    EOS
    exit 1  
  end
end

if $0 == __FILE__
  check_usage
  puts find_longest_palindrome(ARGV[0])
end