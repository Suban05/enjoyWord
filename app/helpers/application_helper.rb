# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def prepend_flash
    turbo_stream.prepend "flash", partial: "shared/flash"
  end

  def time_ago(date)
    return t("empty_for_now") if date.nil?
    "#{time_ago_in_words(date)} ago"
  end
end
