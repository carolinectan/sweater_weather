class Api::V1::BackgroundsController < ApplicationController
  def index
    background = BackgroundFacade.get_background(params[:location])

    render json: BackgroundSerializer.get_background(background,
                                                     params[:location])
  end
end
