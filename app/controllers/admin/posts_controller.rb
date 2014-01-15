# Admin post controller
class Admin::PostsController < Admin::BaseController
  before_action :check_file_size, only: [:upload_image]
  before_action :check_file_ext, only: [:upload_image]

  # Render Blog list pages
  def index
    @posts = Post.order(created_at: :desc).paginate(page: params[:page])
  end

  # Render a blog post
  def show
    @post = Post.find(params[:id])
    render layout: false
  end

  # Render new blog post page
  def new
    @post = Post.new
  end

  # Handle create new post
  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:success] = t('create_post_success')
      redirect_to posts_url
    else
      render 'new'
    end
  end

  # Render edit post view
  def edit
    @post = Post.find(params[:id])
  end

  # Handle updating a new post
  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:success] = t('update_post_success')
      redirect_to edit_post_path(@post)
    else
      render 'edit'
    end
  end

  # Handle delete a post
  def destroy
    Post.find(params[:id]).destroy!

    flash[:success] = t('delete_post_success')

    redirect_to posts_url
  end

  # Function to upload image for a post
  def upload_image
    uploader = ImageUploader.new

    respond_to do |format|
      uploader.store!(params[:file])

      format.json { render json: { status: 1, url: image_url(uploader.url) } }
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  # Function to return the full image url after uploading
  def image_url(uploaded_url)
    host_url = request.port == 80 ? request.host : request.host_with_port
    "http://#{host_url}#{uploaded_url}"
  end

  # Function to check image size for image uploaded for post
  def check_file_size
    if params[:file].size > AppSettings.config['max_filesize'].megabytes.to_i
      respond_to do |format|
        format.json { render json: { status: 0, error: t('image_warning') } }
      end
    end
  end

  # Function to check image extension
  def check_file_ext
    allowed_ext = %w(image/jpeg image/png image/gif)

    unless allowed_ext.include? params[:file].content_type
      respond_to do |format|
        format.json { render json: { status: 0, error: t('image_warning') } }
      end
    end
  end
end
