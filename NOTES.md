# Notes

## Project Setup

Rails is chosen due to my familiarity with it and it being generally the
default framework used.
This means community support would be strong, more libraries, and easier
to find answers to issues.

The data sources are assumed to be dynamic, each API call will read directly
from all of the source APIs.
In light of this, I do not need any database configuration or setup for this.
I also don't need all the other options, so they will be skipped.
I could have used the `--minimal` flag, but being unfamiliar with it,
I opted to skip what I knew instead of creating a minimal Rails app.

```shell
rails new hotels-data-merge --api \
  --skip-active-record \
  --skip-action-mailbox \
  --skip-action-text \
  --skip-action-cable \
  --skip-active-job \
  --skip-action-mailer \
  --skip-active-storage
```

## Data Exploration

In order to serve data correctly, we need to understand the shape of the data
coming from the API sources.

Researching the data can be done in Rails console using the following snippet:

```ruby
require 'net/http'
require 'json'

endpoints = %w[https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/acme https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/patagonia https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/paperflies]

data = endpoints.map do |endpoint|
  url = URI(endpoint)

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = (url.scheme == 'https')
  request = Net::HTTP::Get.new(url)

  response = http.request(request)

  if response.is_a?(Net::HTTPSuccess)
    JSON.parse(response.body)
  end
end
```

Looking at the data, they have mostly the same data with some missing fields in
different objects.

With a good feel of the structure of the data, we can plan on how to deliver
the most complete data by interpolating the data from each of the different
endpoints and serving a complete set of data from it.

## Data Superset

A superset of the attributes and mappings are:

| attribute | API 1 | API 2 | API 3 |
| --------- | ----- | ----- | ----- |
| `id` | `Id` | `id` | `hotel_id` |
| `destination_id` | `DestinationId` | `destination` | `destination_id` |
| `name` | `Name` | `name` | `hotel_name` |
| `latitude` | `Latitude` | `lat` | missing |
| `longitude` | `Longitude` | `lng` | missing |
| `address` | `Address` | `address` | `location.address` |
| `city` | `City` | missing | missing |
| `country` | `Country` | missing | `location.country` |
| `postal_code` | `PostalCode` | Part of `address` | Part of `address` |
| `description` | `Description` | `info` | `details` |
| `amenities` | `Facilities` | `amenities` | `amenities` |
| `images` | missing | `images` | `images` |
| `conditions` | missing | missing | `booking_conditions` |

Image URLs and metadata come have the following mapping:

| attribute | API 2 | API 3 |
| --------- | ----- | ----- |
| `rooms` | `rooms` | `rooms` |
| `site` | missing | `site` |
| `amenities` | `amenities` | missing |
| `url` | `url` | `link` |
| `description` | `description` | `caption` |

Using the mappings we can build the data models to read and interpolate all the
data from each of the three endpoints and return a single unified data set.

## Development Process

TDD will be used particularly for the services that will pull
and then transform the data.

TDD is especially useful for data transformation work because there are no
API calls being made, it only includes pure functions.

Some instances where TDD is not useful is when data is being read from a remote
source. In such cases, the VCR gem could be used, but in does not add much
value if the SRP is being followed strictly since the "getter" classes would
only be getting the data and handing it off to another class.

### VCR

As development progressed it became obvious quickly that purely mocking data
for classes that didn't call the API and then kind of not really testing the
API calls was not going to work. While all the data transformations worked,
integrating the entire system broke in many different places. This happens
a lot in Ruby as the language is not statically typed. Having a full
integration test suite would have caught these issues.
