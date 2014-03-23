class NrqlController < ApplicationController

  respond_to :js

  def query
    @result = Nrql.query(params[:query][:query]).body
    Query.create(query: params[:query][:query], result: @result)
  end
end
