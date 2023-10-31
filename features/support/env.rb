#encoding: UTF-8
require 'cucumber'
require 'rspec'
require 'selenium-webdriver'
require 'capybara'
require 'capybara/dsl'
require 'rest-client'
require 'openai'
require 'uri'
require 'net/http'

browser = "chrome"
browser = ENV["BROWSER"] if ENV["BROWSER"]

Capybara.register_driver :selenium do |app|
  if browser == "firefox"
    profile = Selenium::WebDriver::Firefox::Profile.new
    options = Selenium::WebDriver::Firefox::Options.new(profile: profile)
    # noinspection RubyArgCount
    Capybara::Selenium::Driver.new(app, browser: :firefox, options: options)
  elsif browser == "firefox-headless"
    ENV['MOZ_HEADLESS'] = '1'
    profile = Selenium::WebDriver::Firefox::Profile.new
    options = Selenium::WebDriver::Firefox::Options.new(profile: profile)
    # noinspection RubyArgCount
    Capybara::Selenium::Driver.new(app, browser: :firefox, options: options)
  elsif browser == "chrome-headless"
    arguments = ["headless","disable-gpu", "no-sandbox", "window-size=1920,1080", "privileged"]
    preferences = {
        'download.default_directory': File.expand_path(File.join(File.dirname(__FILE__), "../../downloads/")),
        'download.prompt_for_download': false,
        'plugins.plugins_disabled': ["Chrome PDF Viewer"],
    }
    options = Selenium::WebDriver::Chrome::Options.new(args: arguments, prefs: preferences)
    # noinspection RubyArgCount
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  else
    arguments = ["start-maximized"]
    preferences = {
        'download.default_directory': File.expand_path(File.join(File.dirname(__FILE__), "../../downloads/")),
        'download.prompt_for_download': false,
        'plugins.plugins_disabled': ["Chrome PDF Viewer"]
    }
    options = Selenium::WebDriver::Chrome::Options.new(args: arguments, prefs: preferences)
    # noinspection RubyArgCount
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  end
end

Capybara.run_server = false
Capybara.default_driver = :selenium
Capybara.javascript_driver = :selenium
Capybara.default_selector = :css
Capybara.default_max_wait_time = 10

Capybara.app_host = 'https://en.wikipedia.org/wiki/Main_Page'

World(Capybara::DSL)
puts "running on browser: #{browser}"