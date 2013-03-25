#!/usr/bin/env ruby

# program to process the data linked by this blog post: http://datablend.be/?p=2161
# writes out the processed data.
# Tom, week of 11/2/2013. 

graph = Hash.new { |h,k| h[k] = [] }

cnt = 0
File.foreach(ARGV[0]) do |line|
  next if line[0] == "#" 
  key, value = line.split.map(&:to_i)
  graph[key] << value
  cnt += 1 
  puts "done #{cnt} lines" if cnt % 100000 == 0
end

# process the graph so lowest values are first on the line
print "Building modifications list..."
deletions = Hash.new { |h,k| h[k] = [] }
graph.each do |key, values|
  # caveat: don't use "<<" here! That would append the whole array as one element!
  deletions[key] += values.select { |value| value < key }
end
puts "done."

print "Performing modifications..."
deletions.each do |key, values|
  graph[key] -= values
  values.each { |value| graph[value] << key }
end
puts "done."

# note: the next would not be necessary if we were to have used sets
# for each value instead of arrays, but quick tests revealed
# this used up 3x the memory for the graph. This slowed my 4GB mac down to a crawl
# when run on 69 million data entries. 
graph.each_value do |values|
  values.sort!.uniq! unless values.nil?
end

print "Writing output..."
File.open("output_optim.txt", "w") do |f|
  graph.each do |key, value| 
    f.write "#{key} - #{value.join(' ')}\n"
  end
end
puts "all done."
