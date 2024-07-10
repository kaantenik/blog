class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /posts or /posts.json
  def index
    @posts = policy_scope(Post)
  end

  # GET /posts/1 or /posts/1.json
  def show
    authorize @post
  end

   # GET /posts/new
   def new
    @post = current_user.posts.build
    authorize @post
  end

  # GET /posts/1/edit
  def edit
    authorize @post
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)
    authorize @post

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post başarılı bir şekilde oluşturuldu." }
        format.json { render :show, stat  us: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    authorize @post
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post başarılı bir şekilde güncellendi." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    authorize @post
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post başarılı bir şekilde kaldırıldı." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:name, :title, :body, :user_id)
    end
end
