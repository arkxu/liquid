require 'test_helper'

class AssignTest < Test::Unit::TestCase
  include Liquid

  def test_assigned_variable
    assert_template_result('.foo.',
                           '{% assign foo = values %}.{{ foo[0] }}.',
                           'values' => %w{foo bar baz})
  
    assert_template_result('.bar.',
                           '{% assign foo = values %}.{{ foo[1] }}.',
                           'values' => %w{foo bar baz})
  end
  
<<<<<<< HEAD
  def test_advanced_assigned_variable
    assert_template_result('.3.',
                           '{% assign foo = values | desc %}.{{ foo[0] }}.',
                           'values' => %w{1 2 3})    
  end

  def test_advanced_assigned_variable2
    assert_template_result('.5.',
                           '{% assign foo = values | desc:"a" %}.{{ foo[0].a }}.',
                           'values' => [{"a" => 2}, {"a" => 5}, {"a" => 3}])    
  end

  def test_advanced_assigned_variable2
    assert_template_result('.3.',
                           '{% assign foo = values | size %}.{{ foo }}.',
                           'values' => [{"a" => 2}, {"a" => 5}, {"a" => 3}])    
  end

=======
  def test_assign_with_filter
    assert_template_result('.bar.',
                           '{% assign foo = values | split: "," %}.{{ foo[1] }}.',
                           'values' => "foo,bar,baz")
  end
>>>>>>> 1a1b4702d78022c113cacd2304c35aa9ffc6b5b7
end # AssignTest
