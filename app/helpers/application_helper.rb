# frozen_string_literal: true

module ApplicationHelper
  def query_for_ransack
    Drug.ransack({})
  end
end
