# encoding: UTF-8

require 'test_helper'

class Filters
  include Liquid::StandardFilters
end

class MockModel
  attr_accessor :v1
end

class StandardFiltersTest < Test::Unit::TestCase
  include Liquid

  def setup
    @filters = Filters.new
  end

  def test_size
    assert_equal 3, @filters.size([1,2,3])
    assert_equal 0, @filters.size([])
    assert_equal 0, @filters.size(nil)
  end

  def test_downcase
    assert_equal 'testing', @filters.downcase("Testing")
    assert_equal '', @filters.downcase(nil)
  end

  def test_upcase
    assert_equal 'TESTING', @filters.upcase("Testing")
    assert_equal '', @filters.upcase(nil)
  end

  def test_upcase
    assert_equal 'TESTING', @filters.upcase("Testing")
    assert_equal '', @filters.upcase(nil)
  end

  def test_truncate
    assert_equal '1234...', @filters.truncate('1234567890', 7)
    assert_equal '1234567890', @filters.truncate('1234567890', 20)
    assert_equal '1234567890', @filters.truncate('1234567890',10)
    assert_equal '中文...', @filters.truncate('中文的测试结果是什么',5)
    assert_equal '中文的...', @filters.truncate('中文的测试结果是什么',6)
    assert_equal '中文的测试结果是什么', @filters.truncate('中文的测试结果是什么',10)
    assert_equal '中文的测试结果是什么', @filters.truncate('中文的测试结果是什么',11)
  end

  def test_escape
    assert_equal '&lt;strong&gt;', @filters.escape('<strong>')
    assert_equal '&lt;strong&gt;', @filters.h('<strong>')
  end

  def test_escape_once
    assert_equal '&lt;strong&gt;', @filters.escape_once(@filters.escape('<strong>'))
  end

  def test_truncatewords
    assert_equal 'one two three', @filters.truncatewords('one two three', 4)
    assert_equal 'one two...', @filters.truncatewords('one two three', 2)
    assert_equal 'one two three', @filters.truncatewords('one two three')
    assert_equal 'Two small (13&#8221; x 5.5&#8221; x 10&#8221; high) baskets fit inside one large basket (13&#8221;...', @filters.truncatewords('Two small (13&#8221; x 5.5&#8221; x 10&#8221; high) baskets fit inside one large basket (13&#8221; x 16&#8221; x 10.5&#8221; high) with cover.', 15)
  end

  def test_strip_html
    assert_equal 'test', @filters.strip_html("<div>test</div>")
    assert_equal 'test', @filters.strip_html("<div id='test'>test</div>")
    assert_equal '', @filters.strip_html("<script type='text/javascript'>document.write('some stuff');</script>")
    assert_equal '', @filters.strip_html(nil)
  end

  def test_join
    assert_equal '1 2 3 4', @filters.join([1,2,3,4])
    assert_equal '1 - 2 - 3 - 4', @filters.join([1,2,3,4], ' - ')
  end

  def test_split
    assert_equal ["1","2","3","4"], @filters.split('1 2 3 4')
    assert_equal ["1","2","3","4"], @filters.split('1,2,3,4', ',')
  end

  def test_sort
    assert_equal [1,2,3,4], @filters.sort([4,3,2,1])
    assert_equal [{"a" => 1}, {"a" => 2}, {"a" => 3}, {"a" => 4}], @filters.sort([{"a" => 4}, {"a" => 3}, {"a" => 1}, {"a" => 2}], "a")
  end

  def test_desc
    assert_equal [4,3,2,1], @filters.desc([1,2,3,4])
    assert_equal [4,3,2,1], @filters.desc([4,3,2,1])
    assert_equal [{"a" => 4}, {"a" => 3}, {"a" => 2}, {"a" => 1}], @filters.desc([{"a" => 4}, {"a" => 3}, {"a" => 1}, {"a" => 2}], "a")
    assert_equal [{"a" => 4}, {"a" => 3}, {"a" => 2}, {"a" => 1}], @filters.desc([{"a" => 1}, {"a" => 2}, {"a" => 3}, {"a" => 4}], "a")
    v1 = MockModel.new
    v1.v1 = "v1"
    v2 = MockModel.new
    v2.v1 = "v2"
    v = [v1,v2]
    assert_equal [v2,v1], @filters.desc(v, "v1")
  end

  def test_map
    assert_equal [1,2,3,4], @filters.map([{"a" => 1}, {"a" => 2}, {"a" => 3}, {"a" => 4}], 'a')
    assert_template_result 'abc', "{{ ary | map:'foo' | map:'bar' }}",
      'ary' => [{'foo' => {'bar' => 'a'}}, {'foo' => {'bar' => 'b'}}, {'foo' => {'bar' => 'c'}}]
  end

  def test_date
    assert_equal 'May', @filters.date(Time.parse("2006-05-05 10:00:00"), "%B")
    assert_equal 'June', @filters.date(Time.parse("2006-06-05 10:00:00"), "%B")
    assert_equal 'July', @filters.date(Time.parse("2006-07-05 10:00:00"), "%B")

    assert_equal 'May', @filters.date("2006-05-05 10:00:00", "%B")
    assert_equal 'June', @filters.date("2006-06-05 10:00:00", "%B")
    assert_equal 'July', @filters.date("2006-07-05 10:00:00", "%B")

    assert_equal '2006-07-05 10:00:00', @filters.date("2006-07-05 10:00:00", "")
    assert_equal '2006-07-05 10:00:00', @filters.date("2006-07-05 10:00:00", "")
    assert_equal '2006-07-05 10:00:00', @filters.date("2006-07-05 10:00:00", "")
    assert_equal '2006-07-05 10:00:00', @filters.date("2006-07-05 10:00:00", nil)

    assert_equal '07/05/2006', @filters.date("2006-07-05 10:00:00", "%m/%d/%Y")

    assert_equal "07/16/2004", @filters.date("Fri Jul 16 01:00:00 2004", "%m/%d/%Y")

    assert_equal nil, @filters.date(nil, "%B")
  end


  def test_first_last
    assert_equal 1, @filters.first([1,2,3])
    assert_equal 3, @filters.last([1,2,3])
    assert_equal nil, @filters.first([])
    assert_equal nil, @filters.last([])
  end

  def test_replace
    assert_equal 'b b b b', @filters.replace("a a a a", 'a', 'b')
    assert_equal 'b a a a', @filters.replace_first("a a a a", 'a', 'b')
    assert_template_result 'b a a a', "{{ 'a a a a' | replace_first: 'a', 'b' }}"
  end

  def test_remove
    assert_equal '   ', @filters.remove("a a a a", 'a')
    assert_equal 'a a a', @filters.remove_first("a a a a", 'a ')
    assert_template_result 'a a a', "{{ 'a a a a' | remove_first: 'a ' }}"
  end

  def test_pipes_in_string_arguments
    assert_template_result 'foobar', "{{ 'foo|bar' | remove: '|' }}"
  end

  def test_strip_newlines
    assert_template_result 'abc', "{{ source | strip_newlines }}", 'source' => "a\nb\nc"
  end

  def test_newlines_to_br
    assert_template_result "a<br />\nb<br />\nc", "{{ source | newline_to_br }}", 'source' => "a\nb\nc"
  end

  def test_plus
    assert_template_result "2", "{{ 1 | plus:1 }}"
    assert_template_result "2.0", "{{ '1' | plus:'1.0' }}"
  end

  def test_minus
    assert_template_result "4", "{{ input | minus:operand }}", 'input' => 5, 'operand' => 1
    assert_template_result "2.3", "{{ '4.3' | minus:'2' }}"
  end

  def test_times
    assert_template_result "12", "{{ 3 | times:4 }}"
    assert_template_result "0", "{{ 'foo' | times:4 }}"

    # Ruby v1.9.2-rc1, or higher, backwards compatible Float test
    assert_match(/(6\.3)|(6\.(0{13})1)/, Template.parse("{{ '2.1' | times:3 }}").render)

    assert_template_result "6", "{{ '2.1' | times:3 | replace: '.','-' | plus:0}}"
  end

  def test_divided_by
    assert_template_result "4", "{{ 12 | divided_by:3 }}"
    assert_template_result "4", "{{ 14 | divided_by:3 }}"

    # Ruby v1.9.2-rc1, or higher, backwards compatible Float test
    assert_match(/4\.(6{13,14})7/, Template.parse("{{ 14 | divided_by:'3.0' }}").render)

    assert_template_result "5", "{{ 15 | divided_by:3 }}"
    assert_template_result "Liquid error: divided by 0", "{{ 5 | divided_by:0 }}"
  end

  def test_mod_by
    assert_template_result "0", "{{ 12 | mod_by:3 }}"
    assert_template_result "2", "{{ 14 | mod_by:3 }}"

    # Ruby v1.9.2-rc1, or higher, backwards compatible Float test
    assert_match(/2\.(0)/, Template.parse("{{ 14 | mod_by:'3.0' }}").render)

    assert_template_result "0", "{{ 15 | mod_by:15 }}"
    #assert_template_result "Liquid error: mod by 0", "{{ 5 | mod_by:0 }}"
  end

  def test_append
    assigns = {'a' => 'bc', 'b' => 'd' }
    assert_template_result('bcd',"{{ a | append: 'd'}}",assigns)
    assert_template_result('bcd',"{{ a | append: b}}",assigns)
  end

  def test_prepend
    assigns = {'a' => 'bc', 'b' => 'a' }
    assert_template_result('abc',"{{ a | prepend: 'a'}}",assigns)
    assert_template_result('abc',"{{ a | prepend: b}}",assigns)
  end

  def test_cannot_access_private_methods
    assert_template_result('a',"{{ 'a' | to_number }}")
  end
  
  def test_url_encode
    assert_template_result "a+b%E4%B8%AD%E6%96%87++%E8%BF%98%E6%9C%89", "{{ 'a b中文  还有' | url_encode }}"
  end
end # StandardFiltersTest
