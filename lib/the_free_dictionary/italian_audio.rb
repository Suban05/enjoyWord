# frozen_string_literal: true

module TheFreeDictionary
  class ItalianAudio
    def pronunciation(statement)
      TheFreeDictionary::Pronunciation.get do |config|
        config.statement = statement
        config.language = "it"
        config.region = "IT"
      end
    end
  end
end
