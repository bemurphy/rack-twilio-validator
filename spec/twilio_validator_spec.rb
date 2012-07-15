require 'spec_helper'

describe Rack::TwilioValidator do
  let(:auth_token) { "5cc8534fb3f86ff7e52d884562bcca18" }
  let(:params) { { "foo" => "fizz", "bar" => "buzz" } }
  let(:valid_signature) { "4C3R3E2C2TwiOkEwqznWMH1k3O8=" }
  let(:uri) { "/twilio/endpoint"}

  let(:app) {
    Rack::Builder.new do
      use Rack::TwilioValidator, :auth_token => "5cc8534fb3f86ff7e52d884562bcca18"
      run lambda { |env| [200, {'Content-Type' => "text/plain"}, ["OK"]] }
    end
  }

  context "given a valid signature" do
    it "is ok" do
      post(uri, params, "HTTP_X_TWILIO_SIGNATURE" => valid_signature)
      last_response.should be_ok
    end
  end

  context "given an invalid signature" do
    before do
      post(uri, params, "HTTP_X_TWILIO_SIGNATURE" => "bad_signature")
    end

    it "is unauthorized" do
      last_response.status.should == 401
    end

    it "receives a TwiML error in the response body" do
      last_response.body.should include("<Response><Say>Middleware unable to authenticate request signature</Say></Response>")
    end
  end

  context "given no signature" do
    it "is unauthorized" do
      post(uri, params, "HTTP_X_TWILIO_SIGNATURE" => nil)
      last_response.status.should == 401
    end
  end

  context "for a request with credentials in the url" do
    it "drops the credentials in the url when validating the signature" do
      post("http://username:password@example.org#{uri}", params, "HTTP_X_TWILIO_SIGNATURE" => valid_signature)
      last_response.should be_ok
    end
  end

  context "for an https request" do
    it "drops the port when validating" do
      post "https://example.org:7654#{uri}", params, "HTTP_X_TWILIO_SIGNATURE" => "U2ixEfmunlgHywjscRAc90fuucQ="
      last_response.should be_ok
    end
  end

  context "with an optional supplied protected path" do
    let(:app) {
      Rack::Builder.new do
        use Rack::TwilioValidator, :auth_token => "5cc8534fb3f86ff7e52d884562bcca18", :protected_path => "/twilio"
        run lambda { |env| [200, {'Content-Type' => "text/plain"}, ["OK"]] }
      end
    }

    it "checks actions under the protected path" do
      post("/twilio/endpoint", params, "HTTP_X_TWILIO_SIGNATURE" => "bad_signature")
      last_response.status.should == 401
    end

    it "skips actions outside the protected path" do
      post("/other/endpoint", params, "HTTP_X_TWILIO_SIGNATURE" => "bad_signature")
      last_response.should be_ok
    end
  end
end
