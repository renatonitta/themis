require 'spec_helper'

describe "posts/index.html.haml" do
  before(:each) do
    assign(:posts, [
      stub_model(Post,
        :title => "Title",
        :body => "MyText",
        :user => nil
      ),
      stub_model(Post,
        :title => "Title",
        :body => "MyText",
        :user => nil
      )
    ])
  end

  it "renders a list of posts" do
    render
    rendered.should have_selector("tr>td", :content => "Title".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => nil.to_s, :count => 2)
  end
end
