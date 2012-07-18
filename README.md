Rack::TwilioValidator
=====================

Rack middleware for authorizing the signature on Twilio requests.
Read more about Twilio security at [Twilio Security](http://www.twilio.com/docs/security)

Important Note
--------------

Due to some legacy issues with how Twilio generates the signature, versions 0.0.3 and
prior may not properly validate requests where basic authentication credentials are
provided via the url, or when SSL requests are made to a non-standard port.  See more at
[http://www.twilio.com/docs/security#notes](http://www.twilio.com/docs/security#notes)

I'm looking to fix this shortly, but for the time being recommend either avoid using the
gem if you have such a setup, or, do heavy manual integration testing to ensure the validation
is functioning as you expect.  Apologies for the inconvenience.

Why
---

You should verify the signature in requests to your Twilio controllers for
any app.  Tutorials often miss this, and it's redundant to have
to add it to the application layer for every app you build.  Hence,
middleware!

Installation
------------

install it via rubygems:

```
gem install rack-twilio-validator
```

or put it in your Gemfile:

```ruby
# Gemfile

gem 'rack-twilio-validator', :require => 'rack/twilio-validator'
```

Usage
-----

In a Sinatra application, it would be something like:

```ruby
# app.rb

use Rack::TwilioValidator :auth_token => "your_auth_token", :protected_path => "/twilio_switchboard/"
```

The `auth_token` is required config, whereas `protected_path` is optional but
recommended if your application talks to both end users and Twilio.

#### Copyright

Copyright (c) (2012) Brendon Murphy. See license.txt for details.

