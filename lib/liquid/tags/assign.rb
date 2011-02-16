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
    Syntax = /(#{VariableSignature}+)\s*=\s*(#{QuotedFragment}+)/

    def initialize(tag_name, markup, tokens)
      @var = Liquid::Variable.new(markup)
      if markup =~ Syntax
        @to = $1
        @from = $2
      else
        raise SyntaxError.new("Syntax Error in 'assign' - Valid syntax: assign [var] = [source]")
      end

      super
    end

    def render(context)
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
end
