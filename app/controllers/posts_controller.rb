class PostsController < InheritedResources::Base
  PER_PAGE = Themis::Config['paginate']['per_page']

  respond_to :rss
  belongs_to :section
  before_filter :assign_sections
  before_filter :authenticate_user!, :only => [:approve, :create, :update, :destroy]
  before_filter :assign_user, :only => [:create]

  def all
    @posts = Post.approved.paginate :page => params[:page], :per_page => PER_PAGE 
    render :index
  end

  def approve
    resource.approve!
  end

  def by_tag
    @posts = Post.approved.tagged_with(params[:tag]).paginate :page => params[:page], :per_page => PER_PAGE 
    render :index
  end

  protected

  def resource
    @post = Post.find params[:id]
  end

  def collection
    @posts = end_of_association_chain.approved.paginate :page => params[:page], :per_page => PER_PAGE 
  end

  private

  def assign_sections
    @sections = Section.all
  end

  def assign_user
    params[:post][:author] = current_user
  end
end
