#!/usr/local/bin/ruby

require 'cgi'

cgi = CGI.new
puts cgi.header('charset' => 'UTF-8')

File.write('./plots.csv', cgi['plots'])

