# frozen_string_literal: true

class Example < ApplicationRecord
  include Orderable

  belongs_to :word
end
