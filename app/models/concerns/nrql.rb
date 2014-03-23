class Nrql

  class << self

    def account_id
      raise if ENV['ACCOUNT_ID'].blank?
      ENV['ACCOUNT_ID']
    end

    def query_key
      raise if ENV['QUERY_KEY'].blank?
      ENV['QUERY_KEY']
    end

    def insert_key
      raise if ENV['INSERT_KEY'].blank?
      ENV['INSERT_KEY']
    end


    def query(raw_query)
      escaped_query = ERB::Util.u(raw_query)

      Excon.get("https://insights.newrelic.com/beta_api/accounts/#{account_id}/query?nrql=#{escaped_query}",
          headers: {
              'Accept' => 'application/json',
              'X-Query-Key' => query_key})
    end


    # [TODO]
    # def insert
    #   <<-EOS
    # cat example_events.json | curl -d @- -X POST -H "Content-Type: application/json" -H "X-Insert-Key: #{insert_key}" https://insights.newrelic.com/beta_api/accounts/#{account_id}/events
    #   EOS
    # end

  end
end
