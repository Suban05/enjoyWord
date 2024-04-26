module ApplicationHelper
  include Pagy::Frontend
  
  def prepend_flash
    turbo_stream.prepend 'flash', partial: 'shared/flash'
  end
end
