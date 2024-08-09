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

  def data_of_delete
    { turbo_method: :delete, turbo_confirm: t("are_you_sure") }
  end

  def languages_display
    Dictionary::Languages::Language.available.keys.map do |type|
      [ Dictionary::Language.find_by_id(type.to_sym).new.name.capitalize, type ]
    end
  end
end
