require "twilio-ruby"

module Rack
  class TwilioValidator
    def initialize(app, options = {})
      @app = app
      @options = options
      @auth_token = options.fetch(:auth_token)
      @app
    end

    def call(env)
      self.dup._call(env)
    end

    def _call(env)
      @request = Rack::Request.new(env)

      if unprotected_path? || request_validator.validate(@request.url, @request.params, env['HTTP_X_TWILIO_SIGNATURE'])
        @app.call(env)
      else
        response = ::Twilio::TwiML::Response.new do |r|
          r.Say("Middleware unable to authenticate request signature")
        end
        [401, { "Content-Type" => "application/xml" }, [response.text]]
      end
    end

    private

    def protected_path?
      protected_path = @options.fetch(:protected_path, "/")
      @request.path =~ %r/^#{protected_path}/
    end

    def unprotected_path?
      ! protected_path?
    end

    def request_validator
      @validator ||= ::Twilio::Util::RequestValidator.new(@auth_token)
    end
  end
end
