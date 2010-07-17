def should_have_an_slugged_id(name)
  it "should be found by the slugged #{name} as an id" do
    clazz = subject.class
    object = Factory(clazz.to_s.underscore, name => "Hello World")
    clazz.find(object.id).should == clazz.find("hello-world")
  end
end
