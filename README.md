# API Service Searching

Provides a consistent way of implementing searching in API endpoints.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'api_service_searching'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install api_service_searching

## Searches it supports

### Return all data

A query string like `/users` will return every element in your data collection.

### Return all data with non-null attribute value

A query string like `/users=q=role=true` will return every element in your data collectionthat has a non-null `role` value. `/users=q=role=all` behaves exactly the same way.

### Return all data with null attribute value

A query string like `/users=q=role=false` will return every element in your data collectionthat has a null `role` value. `/users=q=role=none` behaves exactly the same way.

### Return all data with an attribute value that matches

A query string like `/users=q=role=admin` will return every element in your data collectionthat has a role value of 'admin'. Case insensitive.

### Combining Searches

Search criteria can be separated with commas

`users=q=role=admin,state=MN,active=true`

Records that match **all** the criteria will be returned.


## Usage

First, create a collection of data. With ActiveRecord or other ORMs this is straightforward:

```ruby
User.all
```

Or something similar. As long as it returns a collection of objects, you should be good.

The objects must respond to the attributes you want to search on. Say you want to allow a search string like this:

```
users.json?q=role=admin
```

Then every object in your data collection needs to respond to `role`.

Again, with ActiveRecord this is pretty straightforward. But if you're building your data source from raw SQL then you're going to have to convert that data into objects that respond to the attributes you want to search on.

Second, search!

```ruby
results = ApiServiceSearching.where(
  SearchParameters.build_from_querystring(params[:q]),
  User.all #or whatever your data collection is
)
```

`results` is a collection of the objects that matched the search criteria.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/api_service_searching/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
