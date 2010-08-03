class PostsController < InheritedResources::Base
  belongs_to :section
  actions :index, :show
  respond_to :rss
  before_filter :assign_sections
  caches_page :all, :index, :show

  def all
    paginate resource_class.approved
  end

  def by_tag
    @tag = params[:tag]
    paginate resource_class.approved.tagged_with(@tag)
  end

  private

  def collection
    paginate end_of_association_chain.approved
  end

  def paginate(posts)
    @posts = posts.paginate :page => params[:page], :per_page => Post::PER_PAGE
  end

  def assign_sections
    @sections = Section.all
  end
end
