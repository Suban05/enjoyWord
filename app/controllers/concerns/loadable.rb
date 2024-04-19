module Loadable
  extend ActiveSupport::Concern

  private

  # @param words [String]
  # @param dictionary_id [String]
  # @return [Hash] - response:
  #   - :status (:Symbol)
  #   - :errors (Array<String>)
  def load(words, dictionary_id)
    dictionary = Dictionary.find_by(id: dictionary_id)
    response = loader_response
    if dictionary.nil?
      response[:status] = status_error
      response[:errors] << "Dictionary with #{dictionary_id} is not found"
      return response
    end

    Dictionary.write_words(dictionary, words)
  end

  def loader_response
    { status:, errors: [] }
  end

  def status_ok
    :ok
  end

  def status_error
    :error
  end
end
