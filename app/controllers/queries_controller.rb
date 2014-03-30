class QueriesController < ApplicationController

  before_action :set_query,
      only: [:show, :edit, :update, :destroy,
            :gc, :results, :edit_javascript_source, :update_javascript_source,
            :edit_query, :update_query]

  before_action do
    add_breadcrumb 'NRQL Workbench', '/'
    add_breadcrumb 'Query', queries_path
  end

  def index
    @query = Query.new(query: 'SELECT * FROM PageView')
    @queries = Query.order('id DESC').all
  end

  def run
    @query = Query.find(params[:id])
    @query.update_results
  end

  def results
  end

  def show
    add_breadcrumb @query.query
  end

  def edit_query

  end

  def update_query
    @query.result = Nrql.query(params[:query][:query]).body
    @query.save!
  end

  # GET
  def edit_javascript_source
    add_breadcrumb @query.query, query_path(@query)
  end

  # POST
  def update_javascript_source
    @query.update_attributes!(
        javascript_source: params[:javascript_source])
  end

  # GET /queries/1/edit
  def edit
    add_breadcrumb params[:id], query_path(params[:id])
    add_breadcrumb 'Edit'
  end

  # POST /queries
  # POST /queries.json
  def create
    @query = Query.new(query_params)
    @query.result = Nrql.query(params[:query][:query]).body

    respond_to do |format|
      if @query.save
        format.html { redirect_to @query, notice: 'Query was successfully created.' }
        format.json { render action: 'show', status: :created, location: @query }
        format.js do
          @queries = Query.order('id DESC').all
        end
      else
        format.html { render action: 'new' }
        format.json { render json: @query.errors, status: :unprocessable_entity }
        format.js do
          # TODO
        end
      end
    end
  end

  def gc
    render layout: 'plain'
  end

  # PATCH/PUT /queries/1
  # PATCH/PUT /queries/1.json
  def update
    @query = Query.new(query_params)
    @query.result = Nrql.query(params[:query][:query]).body

    respond_to do |format|
      if @query.update(query_params)
        format.html { redirect_to @query, notice: 'Query was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @query }
      else
        format.html { render action: 'edit' }
        format.json { render json: @query.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /queries/1
  # DELETE /queries/1.json
  def destroy
    @query.destroy
    respond_to do |format|
      format.html { redirect_to queries_url }
      format.json { head :no_content }
    end
  end

  private

    def set_query
      @query = Query.find(params[:id])
    end

    def query_params
      params.require(:query).permit(:query, :javascript_source)
    end
end
