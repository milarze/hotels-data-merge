class ApplicationController < ActionController::API
  def index
    data = ApiData.new.get_merged_data
    render json: data
  end
end
