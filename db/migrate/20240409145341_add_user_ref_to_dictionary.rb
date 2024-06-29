# frozen_string_literal: true

class AddUserRefToDictionary < ActiveRecord::Migration[7.1]
  def change
    add_reference :dictionaries, :user, null: false, foreign_key: true
  end
end
