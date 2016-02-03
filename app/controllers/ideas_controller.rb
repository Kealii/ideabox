class IdeasController < ApplicationController
  def index
    render json: Idea.order(created_at: :desc).all
  end

  def create
    Idea.create(title: params[:title], body: params[:body])
    render nothing: true
  end
end
