module TurboReturnable
  extend ActiveSupport::Concern

  def prepare_returnable_query(data)
    query = data.order(created_at: :desc)
    current_item = params[:id]
    if current_item
      query = query.where(id: current_item)
    end
    query
  end
end
