# frozen_string_literal: true
module ApplicationHelper
  
  MD_EXTENSIONS = {
    autolink:           true,
    superscript:        true,
    fenced_code_blocks: true,
    disable_indented_code_blocks: true,
    lax_spacing:        true,
    strikethrough:      true,
    highlight:          true
  }

  def markdown(text)
    text ||= ''

    unless @markdown
      options = {
        filter_html:     true,
        safe_links_only:  true,
        hard_wrap:       true,
        no_images:       true,
        no_styles:       true,
        prettify:        true,
        link_attributes: { rel: 'nofollow', target: '_blank' },
        space_after_headers: true
      }

      renderer = Redcarpet::Render::HTML.new(options)
      @markdown = Redcarpet::Markdown.new(renderer, MD_EXTENSIONS)
    end

    @markdown.render(text).html_safe
  end

  def markdown_unsafe(text)
    text ||= ''

    unless @markdown_unsafe
      options = {
        filter_html:     false,
        safe_links_only:  true,
        hard_wrap:       true,
        prettify:        true,
        link_attributes: { rel: 'nofollow', target: '_blank' },
        space_after_headers: true
      }

      renderer = Redcarpet::Render::HTML.new(options)
      @markdown_unsafe = Redcarpet::Markdown.new(renderer, MD_EXTENSIONS)
    end

    @markdown_unsafe.render(text)
  end

  def markdown_wiki(text)
    text ||= ''

    unless @markdown_wiki
      options = {
        filter_html:     true,
        safe_links_only:  true,
        no_images:       false,        
        hard_wrap:       true,
        prettify:        true,
        link_attributes: { rel: 'nofollow', target: '_blank' },
        space_after_headers: true
      }

      renderer = Redcarpet::Render::HTML.new(options)
      @markdown_wiki = Redcarpet::Markdown.new(renderer, MD_EXTENSIONS)
    end

    @markdown_wiki.render(text).html_safe
  end
end
