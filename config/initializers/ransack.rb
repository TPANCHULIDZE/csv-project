# frozen_string_literal: true

Ransack.configure do |config|
  config.search_key = :query
  config.ignore_unknown_conditions = false
end
