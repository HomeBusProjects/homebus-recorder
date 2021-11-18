#!/usr/bin/env ruby

require './options'
require './app'

recorder_app_options = RecorderHomebusAppOptions.new

recorder = RecorderHomebusApp.new recorder_app_options.options
recorder.run!
