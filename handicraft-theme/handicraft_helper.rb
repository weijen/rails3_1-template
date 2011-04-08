# coding: utf-8
module HandicraftHelper

  def title(options={})
    options.reverse_merge!(:show => true, :default => :"helpers.title.#{controller.action_name}")
    @show_title = options.delete(:show)
    @_content_for[:title] = t('.title', options)
  end

  def show_title?
    @show_title
  end

  def yield_or_default(message, default_message = "")
    message.nil? ? default_message : message
  end

  def render_page_title
    title = (@page_title ? "#{t(:sitename)} | #{@page_title}" : "#{t(:sitename)}") rescue "SITE_NAME"
    content_tag("title", title, nil, false)
  end

  def render_body_tag
    class_attribute = ["#{controller_name}-controller","#{action_name}-action"].join(" ")
    id_attribute = (@body_id)? " id=\"#{@body_id}-page\"" : ""

    raw(%Q|<!--[if lt IE 7 ]>
<body class="#{class_attribute} ie6"><![endif]-->
<!--[if gte IE 7 ]>
<body class="#{class_attribute} ie"><![endif]-->
<!--[if !IE]>-->
<body#{id_attribute} class="#{class_attribute}">
<!--<![endif]-->|)

  end

  # .current will be added to current action, but if you want to add .current to another link, you can set @current = ['/other_link']
  # TODO: hot about render_list( *args )
  def render_list(list=[], options={})
    if list.is_a? Hash
      options = list
      list = []
    end

    yield(list) if block_given?

    ul = TagNode.new('ul', :id => options[:id], :class => options[:class] )

    list.each_with_index do |content, i|
      item_class = []
      item_class << "first" if i == 0
      item_class << "last" if i == (list.length - 1)

      item_content = content
      item_options = {}

      if content.is_a? Array
        item_content = content[0]
        item_options = content[1]
      end

      if item_options[:class]
        item_class << item_options[:class]
      end

      link = item_content.match(/href=(["'])(.*?)(\1)/)[2] rescue nil

      if ( link && current_page?(link) ) || ( @current && @current.include?(link) )
        item_class << "current"
      end

      item_class = (item_class.empty?)? nil : item_class.join(" ")
      ul << li = TagNode.new('li', :class => item_class )
      li << item_content
    end

    return ul.to_s
  end

  # Composite pattern
  class TagNode
    include ActionView::Helpers::TagHelper

    def initialize(name, options = {})
      @name = name.to_s
      @attributes = options
      @children = []
    end

    def to_s
      value = @children.each { |c| c.to_s }.join
      content_tag(@name, value.to_s, @attributes, false)
    end

    def <<(tag_node)
      @children << tag_node
    end
  end
end

