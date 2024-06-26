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
      begin
        response = pronunciation.http_module.get_response(uri)
        audio_data = response.body.match(/#{pronunciation.language}\/#{pronunciation.region}[^"]+/)
        transcription_data = response.body.match(/<span[^>]*onclick="pron_key\(1\)"[^>]*class="pron"[^>]*>\s*\(?([^)]+)\)?\s*<\/span>/)
      rescue Socket::ResolutionError
        audio_data = nil
        transcription_data = nil
      end
      if audio_data.nil?
        source = ''
      else
        source = "https://img2.tfd.com/pron/mp3/#{audio_data[0]}.mp3"
      end

      if transcription_data.nil?
        transcription = nil
      else
        transcription = decode_html_entities(transcription_data[1].force_encoding("UTF-8"))
      end
      { source:, transcription: }
    end

    private

    def self.decode_html_entities(string)
      string.gsub(/&#(\d+);/) { |match| $1.to_i.chr(Encoding::UTF_8) }
    end
  end
end
