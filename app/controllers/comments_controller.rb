class CommentsController < ApplicationController
  include Response
  # TODO: investigate before_action and after_action
  before_action :set_comment, only: %i[ show update destroy ]

  def index
    @comments = Comment.all
    basic_response(@comments, :ok)
  end

  def show
    basic_response(@comment, :ok)
  end

  def create
    #TODO: comment validations
    @comment = Comment.new(comment_params)
    basic_response(@comment, :created, @comment.save)
  end

  def update
    basic_response(@comment, :ok, @comment.update(comment_params))
  end

  def destroy
    @comment.destroy
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:description, :user_id, :activity_id)
    end
end
