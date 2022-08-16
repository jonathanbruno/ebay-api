# Ebay API Ruby



## Installation

Add it to your Gemfile.

```rb
gem 'ebay', '~> 1.0'
```

## Requirements
- Ruby 2.0.0 or newer.

### OAuth App

- ```app_id```: Obtained from the on the Ebay [Developer Portal's](https://dev.ebay.com) "My Apps" section.
- ```app_secret```: Obtained from the on the Ebay [Developer Portal's](https://dev.ebay.com) "My Apps" section.
- ```token```: Obtained after a token exchange in the auth callback.
- ```refresh_token```: Also obtained after the token exchange.

```rb

cm = Ebay::ConnectionManager.new(
  token: 'some-toke',
  refresh_token: 'some-refresh-token',
  app_id: ENV['EBAY_APP_ID'],
  app_secret: ENV['EBAY_APP_SECRET']
)

```

## Usage
For full examples of using the API client, please see the [examples folder](examples) and refer to BigCommerce's [developer documentation](https://developer.bigcommerce.com/api).

Example:

```rb
# Configure the client to talk to a given store

cm = Ebay::ConnectionManager.new(
  token: 'some-toke',
  refresh_token: 'some-refresh-token',
  app_id: ENV['EBAY_APP_ID'],
  app_secret: ENV['EBAY_APP_SECRET']
)
connection = cm.build_connection

Ebay::Collection.create(
  collection: { name: 'Some category name'},
  connection: connection
)

```