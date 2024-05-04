module TheFreeDictionary
  class Pronunciation
    attr_accessor :statement, :http_module, :hostname, :language, :region

    def initialize
      @http_module = Net::HTTP
    end

    def self.get
      pronunciation = new
      yield pronunciation if block_given?
      
      uri = URI(URI::Parser.new.escape("https://#{pronunciation.language}.thefreedictionary.com/#{pronunciation.statement}"))
      response = pronunciation.http_module.get_response(uri)
      audio_data = response.body.match(/#{pronunciation.language}\/#{pronunciation.region}[^"]+/)
      if audio_data.nil?
        source = ''
      else
        source = "https://img2.tfd.com/pron/mp3/#{audio_data[0]}.mp3"
      end

      { source: }
    end
  end
end
