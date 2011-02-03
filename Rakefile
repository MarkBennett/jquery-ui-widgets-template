require 'webrick'
include WEBrick

desc "launch the web server"
task :serve do
  s = HTTPServer.new(Port: 2000,DocumentRoot: File.join(Dir.pwd, "/."))
  trap("INT") { s.shutdown }
  s.start
end

desc "run tests from the command-line"
task :test do
  exec "phantomjs spec/run_jasmine.js http://localhost:2000/spec/SpecRunner.html 2> /dev/null"
end
