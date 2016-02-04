class IdeasController < ApplicationController
  def index
    ideas = Idea.order(created_at: :desc)

    if params[:q]
      idea_table = Idea.arel_table
     ideas = ideas.where(idea_table[:title].matches("%#{params[:q]}%").or(idea_table[:body].matches("%#{params[:q]}%")))
    end

    render json: ideas.all
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
