# frozen_string_literal: true

class AddLearnedToWords < ActiveRecord::Migration[7.1]
  def change
    add_column :words, :learned, :boolean, default: false
  end
end
