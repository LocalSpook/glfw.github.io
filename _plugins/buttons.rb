# Jekyll helper plugin for button creation
#
# This plugin extends Liquid tag blocks with a few custom tags to
# help creating buttons without the need to use HTML tags directly.
#
# Sample usage:
#
# {% button http://www.example.com %}
#    Button Label Goes Here
# {% endbutton %}

module Jekyll
  class Buttons < Liquid::Block
    def initialize(tag_name, text, tokens)
      super
      @link = text
    end

    def render(context)
      require "maruku"
      # Letting Liquid to process variables mixed with the link address if any
      @link = Liquid::Template.parse(@link).render context
      
      # Use this one in case you are going to use Markdown syntax for button label
      #buttonLabel = Maruku::new(super).to_html
      buttonLabel = super
      %|<a class="button" href="#{@link}">#{buttonLabel}</a>|
    end
  end
end

Liquid::Template.register_tag('button', Jekyll::Buttons)
