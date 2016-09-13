#!/usr/local/bin/ruby

require 'cgi'

cgi = CGI.new
puts cgi.header('charset' => 'UTF-8')

puts <<EOS
<h2>hoge</h2>
EOS

