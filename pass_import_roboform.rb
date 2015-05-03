#!/usr/bin/env ruby
require 'nokogiri'

class Login
  def initialize
    self.fields = {}
    self.raw = []
  end

  attr_accessor :key
  attr_accessor :password
  attr_accessor :url
  attr_accessor :fields
  attr_accessor :raw

  def ask_required_info
    self.key = ask('Key is empty. Please type pass key:') if blank?(key)
    find_password!
    self.password = ask('Password is empty. Please type password:') if blank?(password)
  end

  def save
    raise if blank?(key) || blank?(password)
  end

  private

  def find_password
  end

  def blank?(str)
    str.strip.empty?
  end
end

print_list_dir = ARGV.pop
unless print_list_dir
  raise "No dir/to/roboform/print_lists"
end
print_list_dir = File.expand_path(print_list_dir)

# parse logins
logins_path = Dir.glob("#{print_list_dir}/RoboForm Logins*.html").first
unless logins_path
  raise 'Login HTML (RoboForm Logins*.html) not found'
end

html_logins = Nokogiri::HTML(File.open(logins_path))

html_logins.css('table tr').each do |tr|
  login = Login.new
  caption = tr.at_css('.caption')
  subcaption = tr.at_css('.subcaption')
  key = tr.at_css('.field')

  if caption
    login.key = caption.text()
  elsif subcaption
    login.url = subcaption.text()
  elsif key
    login.fields[key.text()] = tr.at_css('.wordbreakfield').text()
  else
    login.raw << tr.at_css('.wordbreakfield').text()
  end

  login.ask_required_info
  login.save
end


