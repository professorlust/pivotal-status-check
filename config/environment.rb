# frozen_string_literal: true

ENV['SINATRA_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

require 'dotenv/load'

GITHUB_ACCESS_TOKEN = ENV['GITHUB_ACCESS_TOKEN']
GITHUB_REPO = ENV['GITHUB_REPO']
PIVOTAL_TRACKER_TOKEN = ENV['PIVOTAL_TRACKER_TOKEN']
PIVOTAL_PROJECT_ID = ENV['PIVOTAL_PROJECT_ID']
GITHUB_ENTERPRISE_API = ENV['GITHUB_ENTERPRISE_API']
require_all 'app'
