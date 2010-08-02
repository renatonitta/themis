class ApplicationController < ActionController::Base
  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
  protect_from_forgery
  layout 'application'

  caches_page :sitemap

  def sitemap
    @posts = Post.approved.all
    @sections = Section.all

    respond_to do |format|
      format.xml { render :template => 'shared/sitemap' }
    end
  end
end
