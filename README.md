# API Service Searching

Provides an easy way to implement searchin in your API endpoints

## Searches it supports

Say you have a `movies` endpoint and people want to be able to search your huge collection of movie data. The API Search gem will give you the following search functionality:

### Return all data

`movies` will return every movie in the data set.

### Return all data with non-null attribute value

`movies?q=rating=all`

Returns every movie with a non-nil rating.

### Return all data with null attribute value

`movies?q=rating=none`

Returns every movie without ratings.

### Return all data with an attribute value that matches

`movies?q=year=1994`

Returns every movie with a year of 1994

### Combining Searches

Search criteria can be separated with commas

`movie?q=year=1994,country=US,rated=none`

Records that match **all** the criteria will be returned. All un-rated movies made in the US in 1994.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'api_service_searching', git: https://github.umn.edu/asrweb/api_service_searching.git
```

And then execute:

    $ bundle

## Usage

First, create a collection of data. With ActiveRecord or other ORMs this is straightforward:

```ruby
Movie.all
```

Or something similar. As long as it returns a collection of objects, you should be good.

The objects must respond to the attributes you want to search on. Say you want to allow a search string like this:

```
`movies?q=year=1994`
```

Then every object in your data collection needs to respond to `year`.

Again, with ActiveRecord this is pretty straightforward. But if you're building your data source from raw SQL then you're going to have to convert that data into objects that respond to the attributes you want to search on.

Second, search!

```ruby
ApiServiceSearching.where(
  Movie.all,
  params[:q]
)
```

This returns a collection of the objects that matched the search criteria.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/api_service_searching/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
