# Load the Rails application.
require_relative "application"
Time::DATE_FORMATS[:ru_datetime] = "%Y.%m.%d, %k:%M:%S"
# Initialize the Rails application.
Rails.application.initialize!
