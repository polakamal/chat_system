require 'elasticsearch'

ELASTICSEARCH_CLIENT = Elasticsearch::Client.new(
  url: ENV.fetch('ELASTICSEARCH_URL', 'http://elasticsearch:9200'),
  log: true
)
