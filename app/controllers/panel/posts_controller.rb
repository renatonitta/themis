class Panel::PostsController < InheritedResources::Base
  before_filter :authenticate_user!  
  before_filter :authenticate_approver!, :only => [:approve]
  before_filter :assign_user, :only => [:create]
  cache_sweeper :post_sweeper

  def approve
    resource.approve!
    render 'show'
  end

  def preview
    @preview = params[:data].to_html
    render :layout => false
  end

  private

  def authenticate_approver!
    render :status => 302 unless current_user.approver?
  end

  def assign_user
    params[:post][:author] = current_user
  end
end
