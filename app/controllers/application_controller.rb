class ApplicationController < ActionController::API
  def index
    data = if params[:hotel_ids].present?
      ApiData.new.get_data_filtered_by_hotel_ids(params[:hotel_ids])
    elsif params[:destination_ids].present?
      ApiData.new.get_data_filtered_by_destination_ids(params[:destination_ids].map(&:to_i))
    else
      ApiData.new.get_merged_data
    end
    render json: data
  end
end
