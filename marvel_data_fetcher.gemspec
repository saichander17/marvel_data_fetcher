Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'marvel_data_fetcher'
  s.version     = '1.0.1'
  s.date        = '2018-05-20'
  s.summary     = "Fetching data from developer.marvel apis"
  s.description = ""
  s.authors     = ["Sai Chander"]
  s.email       = 'saichander17@gmail.com'
  s.files       = Dir['lib/*.rb']
  s.homepage    =
    'https://github.com/saichander17/marvel_data_fetcher'
  %w(rest-client).map {|gem| s.add_runtime_dependency gem}
end