#!/usr/bin/env ruby

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __FILE__)
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
Bundler.require(:default)

require_all 'lib'
require 'csv'

FlightClassifier.new(ARGV).start
