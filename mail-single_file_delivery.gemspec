# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mail-single_file_delivery/version"

Gem::Specification.new do |s|
  s.name        = "mail-single_file_delivery"
  s.version     = Mail::SingleFileDelivery::VERSION
  s.authors     = ["Larry Siden, Westside Consulting LLC"]
  s.email       = ["lsiden@westside-consulting.com"]
  s.homepage    = "https://github.com/lsiden/mail-single_file_delivery"
  s.summary     = %q{
    Delivery all mail to a single file for testing.
  }
  s.description = %q{
# Single File Delivery Method for Mail gem

## Summary
This gem is a delivery-method plug-in for [mail](https://github.com/mikel/mail)
that delivers all mail to a single file for testing.

The Mail gem already provides a file delivery-method that appends a copy of each message
to a file named after each message recipient,
but I want them to all go to a single file 
so that I can monitor them from another window with `tail -f my-file`,
or `cat my-named-pipe` while I hand-test the web interface from a browser.

Of course this is _in addition to_ running automated tests with Rspec and Cucumber.
At some point in development, I want to actually see the pages and enter my own inputs
and perhaps display the mail messages in an HTML reader.

## Synopsis

    Mail.defaults do
      delivery_method SingleFileDelivery => '/tmp/my-file.txt'
    end
  }

  s.rubyforge_project = "mail-single_file_delivery"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_runtime_dependency "mail"
end
