module ApplicationHelper
  def prepend_flash
    turbo_stream.prepend 'flash', partial: 'shared/flash'
  end

  def button_dropdown_id(object)
    "dropdownMenuIconHorizontalButton_#{dom_id(object)}"
  end

  def data_dropdown_id(object)
    "dropdownDots_#{dom_id(object)}"
  end

  def data_modal_id(object)
    "modal_#{dom_id(object)}"
  end
end
