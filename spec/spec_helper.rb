require "rubygems"
require "bundler/setup"

require "minitest/autorun"
require "minitest/reporters"
require "rack/test"

require "./lib/last/routers"
require "./spec/support/fixtures"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
