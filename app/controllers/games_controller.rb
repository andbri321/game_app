class GamesController < ApplicationController
  def index  
    @json_return = Game.all.page(params[:page])

    render json: @json_return, meta: meta_data(@json_return), adapter: :json
  end
end
