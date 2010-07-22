class PostsController < InheritedResources::Base
  PER_PAGE = 5

  respond_to :rss
  belongs_to :section
  before_filter :assign_sections
  before_filter :authenticate_user!, :only => [:approve, :create, :update, :destroy]
  before_filter :authenticate_approver, :only => [:approve]
  before_filter :assign_user, :only => [:create]

  caches_page :all
  cache_sweeper :post_sweeper

  def all
    paginate resource_class.approved
  end

  def approve
    resource.approve!
    render 'show'
  end

  def by_tag
    paginate resource_class.approved.tagged_with(params[:tag])
  end

  private

  def resource
    @post = resource_class.find params[:id]
  end

  def collection
    paginate end_of_association_chain.approved
  end

  def paginate(posts)
    @posts = posts.paginate :page => params[:page], :per_page => PER_PAGE
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
