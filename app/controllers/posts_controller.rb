class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, only: %i[show edit update destroy]

  # GET /posts or /posts.json
  def index
    @posts = Post.order(created_at: :desc)
    @post = Post.new # For the new post form
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    # Optionally, ensure only the author can edit
    redirect_to posts_path, alert: "Not authorized" unless @post.user == current_user
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { redirect_to root_path, alert: @post.errors.full_messages.to_sentence }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    if @post.user == current_user
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to @post, notice: "Post was successfully updated." }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to posts_path, alert: "Not authorized"
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    if @post.user == current_user
      @post.destroy!
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Post was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      redirect_to posts_path, alert: "Not authorized"
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:content)
    end
end
