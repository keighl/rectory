# Rectory

Quickly test HTTP redirects and status codes.

Have a ton of HTTP redirects, and need to verify they're working? Use this. Give rectory a list of live HTTP expectations, and it'll tell you what happens: status code, location, and whether it behaved as expected (i.e pass/fail).

Rectory can also take a spreadsheet to crunch via a CLI. **Yes, your project manager might be able to use this.**

Rectory uses Celluloid for concurrency... so testing a lot of HTTP requests is fast.

Currently, rectory only supports GET requests.

## Installation

Add this line to your Gemfile:

    gem 'rectory'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rectory

## Using a spreadsheet?

The easiest way to run a redirect test is using a CSV spreadsheet.

**1) Generate a new spreadsheet**

    $ rectory new -o example.com.csv

**2) Open up the CSV file and fill in your expectations.**

* `url` - The URL to test.
* `location` - Where the URL should redirect. If the request should not redirect (for instance, a 200 code), leave it blank
* `code` - The HTTP status code the request should return

url,location,code
http://google.com,http://www.google.com,301
http://www.google.com,,200

<table>
  <thead>
    <tr>
      <th>url</th>
      <th>location</th>
      <th>code</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>http://google.com</td>
      <td>http://www.google.com</td>
      <td>301</td>
    </tr>
    <tr>
      <td>http://www.google.com</td>
      <td></td>
      <td>200</td>
    </tr>
  </tbody>
</table>

**3) Run a test using the expectations in your spreadsheet**

    $ rectory test example.com.csv

**4) Examine the results in results_example.com.csv**

<table>
  <thead>
    <tr>
      <th>url</th>
      <th>location</th>
      <th>code</th>
      <th>result_location</th>
      <th>result_code</th>
      <th>pass</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>http://google.com</td>
      <td>http://www.google.com</td>
      <td>301</td>
      <td>http://www.google.com</td>
      <td>301</td>
      <td>true</td>
    </tr>
    <tr>
      <td>http://www.google.com</td>
      <td></td>
      <td>200</td>
      <td></td>
      <td>200</td>
      <td>true</td>
    </tr>
  </tbody>
</table>

## Using the code?

**Testing a single HTTP expectation**

    expectation = Rectory::Expectation.new("http://google.com", location: "http://www.google.com/", code: 301)
    result      = expectation.pass?

**Testing many expectations**

    expectations = [
      Rectory::Expectation.new("http://google.com", location: "http://www.google.com/", code: 301),
      Rectory::Expectation.new("http://google.com", location: "http://www.google.com/", code: 301),
      Rectory::Expectation.new("http://google.com", location: "http://www.google.com/", code: 301)
    ]

    Rectory.perform expectations

    expectations.each do |e|
      puts "#{e.url} ---> #{e.pass?.to_s}"
    end

The `Rectory.perform` class method utilizes [celluloid](https://github.com/celluloid/celluloid)... so it's nice and fast.

## TODO

* Support all HTTP verbs
* Support post data
* Support more HTTP header information (such as basic auth)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
