# Query String Search

Provides an easy way to implement searching in your API endpoints

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
gem 'query_string_search'
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

Second, search! In Rails you can do something like this in a Controller method.

```ruby
QueryStringSearch.new(data, query_string).results
```

This returns a collection of the objects that matched the search criteria.

Or you can do it not in the controller. This will work:

```ruby
test_query = "country=us"
QueryStringSearch.new(Movie.all, test_query).results
```

You get the idea. Pass in a data set and a query-stringish string and you'll get results back.


## Contributing

- Fork, branch, commit & pull.
- Tests are required.
- Don't go against our Rubocop style guidelines.

## License

© Regents of the University of Minnesota. All rights reserved.
