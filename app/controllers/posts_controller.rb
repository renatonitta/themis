class PostsController < InheritedResources::Base
  PER_PAGE = 5

  respond_to :rss
  belongs_to :section
  before_filter :assign_sections
  before_filter :authenticate_user!, :only => [:approve, :create, :update, :destroy]
  before_filter :authenticate_approver, :only => [:approve]
  before_filter :assign_user, :only => [:create]
  after_filter :paginate, :only => [:all, :index, :by_tag]

  def all
    @posts = Post.approved
    render :index
  end

  def approve
    resource.approve!
  end

  def by_tag
    @posts = Post.approved.tagged_with(params[:tag])
    render :index
  end

  private

  def resource
    @post = Post.find params[:id]
  end

  def collection
    @posts = end_of_association_chain.approved
  end

  def paginate
    @posts = @posts.paginate :page => params[:page], :per_page => PER_PAGE
  end

  def authenticate_approver
    render :status => 302 unless current_user.approver?
  end

  def assign_sections
    @sections = Section.all
  end

  def assign_user
    params[:post][:author] = current_user
  end
end
