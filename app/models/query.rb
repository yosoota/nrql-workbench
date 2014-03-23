class Query < ActiveRecord::Base

  def update_results
    self.result = Nrql.query(self.query).body
    self.save!
  end
end
