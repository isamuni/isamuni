module ApplicationHelper

  def markdown(text)
    text ||= ""

    unless @markdown
      options = {
        filter_html:     true,
        hard_wrap:       true,
        no_images:       true,
        prettify:        true,
        link_attributes: { rel: 'nofollow', target: "_blank" },
        space_after_headers: true
      }

      extensions = {
        autolink:           true,
        superscript:        true,
        fenced_code_blocks: true,
        disable_indented_code_blocks: true,
        lax_spacing:        true,
        strikethrough:      true,
        highlight:          true
      }

      renderer = Redcarpet::Render::HTML.new(options)
      @markdown = Redcarpet::Markdown.new(renderer, extensions)
    end

    @markdown.render(text).html_safe
  end

  def markdown_html(text)
    text ||= ""

    unless @markdown
      options = {
        filter_html:     false,
        hard_wrap:       true,
        no_images:       true,
        prettify:        true,
        link_attributes: { rel: 'nofollow', target: "_blank" },
        space_after_headers: true
      }

      extensions = {
        autolink:           true,
        superscript:        true,
        fenced_code_blocks: true,
        disable_indented_code_blocks: true,
        lax_spacing:        true,
        strikethrough:      true,
        highlight:          true
      }

      renderer = Redcarpet::Render::HTML.new(options)
      @markdown = Redcarpet::Markdown.new(renderer, extensions)
    end

    @markdown.render(text).html_safe
  end

  def wrap_string(text,max_width = 24)
    (text.length < max_width) ? 
      text : 
      text.scan(/.{1,#{max_width}}/).join(" ")
  end
end
