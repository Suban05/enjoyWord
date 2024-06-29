# frozen_string_literal: true

class RemoveTranslationTypeFromDictionaries < ActiveRecord::Migration[7.1]
  def change
    remove_column :dictionaries, :translation_type, :integer
  end
end
