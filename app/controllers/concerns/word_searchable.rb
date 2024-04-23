module WordSearchable
  extend ActiveSupport::Concern

  private
  
  def set_search_params
    @q = @dictionary.words.ransack(params[:q])
  end
end
