class Flickr
  class Configuration
    attr_accessor :api_key
    attr_accessor :shared_secret

    attr_accessor :access_token_key
    attr_accessor :access_token_secret

    attr_accessor :open_timeout
    attr_accessor :timeout

    def fetch(*attributes)
      attributes.map { |attribute| send(attribute) }
    end

    def access_token
      [access_token_key, access_token_secret]
    end
  end
end
