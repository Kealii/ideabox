class IdeasController < ApplicationController
  def index
    render json: Idea.order(created_at: :desc).all
  end

  def create
    Idea.create(idea_params)
    render nothing: true
  end

  def update
    idea = Idea.update(params[:id], idea_params)
    idea.rating += params[:rating].to_i
    idea.save
    render nothing: true
  end

  def destroy
    Idea.delete(params[:id])
    render nothing: true
  end

  private

  def idea_params
    params.permit(:body, :title)
  end
end
