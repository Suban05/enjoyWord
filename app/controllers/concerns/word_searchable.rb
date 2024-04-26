module WordSearchable
  extend ActiveSupport::Concern

  private

  def set_search_params
    search_params = params.permit(:format, q: [:content_or_translation_cont])
    @query = search_params[:q]
    @q = @dictionary.words.ransack(search_params[:q])
  end
end
