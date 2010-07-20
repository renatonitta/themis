class PostsController < InheritedResources::Base
  belongs_to :section
  before_filter :authenticate_user!, :only => [:create, :update, :destroy]
  before_filter :assign_user, :only => [:create]

  def all
    @sections = Section.all
    @posts = Post.all
    render :index
  end

  protected

  def resource
    @post = Post.find params[:id]
  end

  private

  def assign_user
    params[:post][:author] = current_user
  end
end
