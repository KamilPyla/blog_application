class PostsController < CommonActionController
  include ::ActivityLogs::Loggable

  before_action :set_object, only: %i[show edit update destroy]
  after_action :create_log, only: %i[create update destroy]
  before_action :load_action_context, only: %i[create update destroy]
  before_action :verify_params, only: %i[create update]
  before_action :check_ability, only: %i[new edit create update destroy]
  before_action :owner?, only: %i[edit update destroy]

  def index
    @posts = Post.with_rich_text_body
                 .includes(:post_category, :user, image_attachment: :blob)
                 .order(created_at: :desc).page(params[:page])
  end

  def show; end

  def new
    @object = Post.new
  end

  def edit; end

  def create
    respond_to do |format|
      if @action_context.perform
        format.html { redirect_to @action_context.response, notice: 'Dodano post' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @action_context.perform
        format.html { redirect_to post, notice: 'Edytowano post' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @action_context.perform
        format.html { redirect_to posts_path, notice: 'Usunięto post' }
      else
        format.html { render edit: :unprocessable_entity }
      end
    end
  end

  private

  def post
    @object
  end

  def set_object
    @object = Post.find(params[:id])
  end

  def permitted_params
    params.fetch(:post, params).permit!
  end

  def action_subject
    :post
  end

  def owner?
    return if @object.user_id == current_user.id

    render :file => "public/401.html", :status => :unauthorized
  end
end
