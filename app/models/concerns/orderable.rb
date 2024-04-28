module Orderable
  extend ActiveSupport::Concern

  included do
    scope :latest_ordered, -> { order(created_at: :desc) }
  end
end
