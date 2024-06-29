# frozen_string_literal: true

module TheFreeDictionary
  class RussianAudio
    def pronunciation(statement)
      TheFreeDictionary::Pronunciation.get do |config|
        config.statement = statement
        config.language = "ru"
        config.region = "RU"
      end
    end
  end
end
