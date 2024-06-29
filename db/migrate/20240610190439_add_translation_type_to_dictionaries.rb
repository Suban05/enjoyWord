# frozen_string_literal: true

class AddTranslationTypeToDictionaries < ActiveRecord::Migration[7.1]
  def change
    add_column :dictionaries, :translation_type, :string
  end
end
