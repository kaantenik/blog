class CommentsController < ApplicationController
  before_action :find_post, only: [:create, :destroy]
  before_action :find_comment, only: [:destroy]

  def create
    @comment = @post.comments.new(comment_params)
    if @comment.save
      redirect_to post_path(@post), notice: 'Yorum başarıyla oluşturuldu.'
    else
      redirect_to post_path(@post), alert: 'Yorum oluşturulurken bir hata oluştu.'
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post), notice: 'Yorum başarıyla silindi.'
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :commenter)
  end
end
