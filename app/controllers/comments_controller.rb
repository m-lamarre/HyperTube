class CommentsController < ApplicationController

  def create
    @comment = Comment.new(movie_id: get_movie_id, user_id: current_user.id, comment: params[:comment][:comment])
    if @comment.save!
      flash[:notice] = 'Comment Saved'
    else
      flash[:error] = @comments.errors
    end
    redirect_to :back
  end

private

  def get_movie_id
    Movie.find_by(source: params[:source], id: params[:id], quality: params[:quality]).id
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
