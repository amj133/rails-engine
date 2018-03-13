class Api::V1::SearchController < ApplicationController

  def show
    render json: Invoice.find_by(params.keys.first => params.values.first)
  end

end
