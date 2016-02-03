class IdeasController < ApplicationController
  def index
    render json: Idea.order(created_at: :desc).all
  end

  def create
    Idea.create(idea_params)
    render nothing: true
  end

  def update
    Idea.update(params[:id], idea_params)
    render nothing: true
  end

  private

  def idea_params
    {title: params[:title], body: params[:body]}
  end
end
