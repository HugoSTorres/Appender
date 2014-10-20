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

def scan
  Dir.foreach(".") do |entry|
    if /.rb$/ === entry
      return "#{entry}" if infected? entry
    end
  end
end

def remove_virus(filename)
  src = ""
  
  target = File.open(filename)
  target.lines do |line|
    if /## "#@! infected by virus !@#"/ === line
      break
    end

    src << line
  end
  target.close
  
  target = File.open(filename, 'w')
  target.write(src)
  target.close
end