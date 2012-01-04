module Liquid

  # Assign sets a variable in your template.
  #
  #   {% assign foo = 'monkey' %}
  #
  # You can then use the variable later in the page.
  #
  #  {{ foo }}
  #
  class Assign < Tag
<<<<<<< HEAD
    Syntax = /(#{VariableSignature}+)\s*=\s*(#{QuotedFragment}+)/

    def initialize(tag_name, markup, tokens)
      @var = Liquid::Variable.new(markup)
=======
    Syntax = /(#{VariableSignature}+)\s*=\s*(.*)\s*/   
  
    def initialize(tag_name, markup, tokens)          
>>>>>>> 1a1b4702d78022c113cacd2304c35aa9ffc6b5b7
      if markup =~ Syntax
        @to = $1
        @from = Variable.new($2)
      else
        raise SyntaxError.new("Syntax Error in 'assign' - Valid syntax: assign [var] = [source]")
      end

      super
    end

    def render(context)
<<<<<<< HEAD
      if @var.filters.size > 0
        @var.filters.inject(context[@from]) do |output, filter|
          filterargs = filter[1].to_a.collect do |a|
            context[a]
          end
          begin
            output = context.invoke(filter[0], output, *filterargs)
            context.scopes.last[@to] = output
          rescue FilterNotFound
            raise FilterNotFound, "Error - filter '#{filter[0]}' in '#{@markup.strip}' could not be found."
          end
        end
      else
        context.scopes.last[@to] = context[@from]
      end
      ''
    end

  end

  Template.register_tag('assign', Assign)
=======
       context.scopes.last[@to] = @from.render(context)
       ''
    end 
  
  end  
  
  Template.register_tag('assign', Assign)  
>>>>>>> 1a1b4702d78022c113cacd2304c35aa9ffc6b5b7
end
