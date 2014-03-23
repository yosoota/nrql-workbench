json.array!(@queries) do |query|
  json.extract! query, :id, :query, :result
  json.url query_url(query, format: :json)
end
