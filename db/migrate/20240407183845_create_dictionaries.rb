class CreateDictionaries < ActiveRecord::Migration[7.1]
  def change
    create_table :dictionaries do |t|
      t.string :name
      t.integer :translation_type

      t.timestamps
    end
  end
end
