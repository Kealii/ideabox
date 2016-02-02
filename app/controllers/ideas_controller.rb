class IdeasController < ApplicationController
  def index
    render json: Idea.all
  end

  def create
    Idea.create(title: params[:title], body: params[:body])
    render nothing: true
  end
end
