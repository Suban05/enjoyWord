class Example < ApplicationRecord
  include Orderable
  
  belongs_to :word
end
