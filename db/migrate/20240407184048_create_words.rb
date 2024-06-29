# frozen_string_literal: true

class CreateWords < ActiveRecord::Migration[7.1]
  def change
    create_table :words do |t|
      t.string :content
      t.string :translation
      t.references :dictionary, null: false, foreign_key: true

      t.timestamps
    end
  end
end
