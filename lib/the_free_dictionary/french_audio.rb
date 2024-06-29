# frozen_string_literal: true

module TheFreeDictionary
  class FrenchAudio
    def pronunciation(statement)
      TheFreeDictionary::Pronunciation.get do |config|
        config.statement = statement
        config.language = "fr"
        config.region = "EU"
      end
    end
  end
end
