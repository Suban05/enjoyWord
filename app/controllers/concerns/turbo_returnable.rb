module TurboReturnable
  extend ActiveSupport::Concern

  private

  def prepare_returnable_query(data)
    query = data.latest_ordered
    current_item = params[:id]
    if current_item
      query = query.where(id: current_item)
    end
    query
  end
end
