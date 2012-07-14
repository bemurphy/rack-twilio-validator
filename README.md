Rack::TwilioValidator
=====================

Rack middleware for authorizing the signature on Twilio requests.
Read more about Twilio security at [Twilio Security](http://www.twilio.com/docs/security)

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

