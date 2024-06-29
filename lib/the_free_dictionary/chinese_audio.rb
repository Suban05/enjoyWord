# frozen_string_literal: true

module TheFreeDictionary
  class ChineseAudio
    def pronunciation(statement)
      TheFreeDictionary::Pronunciation.get do |config|
        config.statement = statement
        config.language = "zh"
        config.region = "CN"
      end
    end
  end
end
