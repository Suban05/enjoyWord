# frozen_string_literal: true

class CreateExamples < ActiveRecord::Migration[7.1]
  def change
    create_table :examples do |t|
      t.string :content
      t.string :translation
      t.references :word, null: false, foreign_key: true

      t.timestamps
    end
  end
end
