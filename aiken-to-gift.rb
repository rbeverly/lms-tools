#!/usr/bin/env ruby
# requires Ruby 2.7.0 or later
# Note that if you have question stems starting with A. B. C. etc, the script will
# assume they are answers. Eg: the question "A. A. Miln is a(n):" would not work.

filepath = ARGV[0]
puts 'Please specify filepath as an argument.' if not filepath

newfilepath = filepath[0..-5] + '.gift.txt'

choice = ""

if File::exists?(newfilepath)
	puts newfilepath + " exists already. Enter 'y' to overwrite the file, or any other character to abort."
	choice = $stdin.gets.chomp
	if not choice.downcase.eql?("y")
		abort "Please rename the existing file and run this script again."
	end
end

newfile = File.new(newfilepath, "w")

IO.foreach(filepath) do |line|
    if line.start_with?("ANSWER: A")
    	newfile.puts "}\n\n"
    elsif line.start_with?('A. ')
    	newfile.puts "=" + line[3..-1]
    elsif line[1] == ". "
    	newfile.puts "~" + line[3..-1]
    else
    	newfile.puts line.insert(-2, " {") if line.length > 1
    end
end

newfile.close