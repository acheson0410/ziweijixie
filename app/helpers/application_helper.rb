module ApplicationHelper
  def menu_header
    #menu_items = Refinery::Menu.new(Refinery::Page.menu_pages)

    presenter = Refinery::Pages::MenuPresenter.new(refinery_menu_pages, self)

    presenter.dom_id = 'bs-navbar-collapse'
    presenter.css = 'collapse navbar-collapse'
    presenter.menu_tag = :div
    presenter.list_tag = :ul
    presenter.list_item_tag = :li
    presenter.selected_css = :active
    presenter.first_css = nil
    presenter.last_css = nil
    presenter.list_tag_css = 'nav nav-justified nav-tabs'

    presenter
  end

  def page_by_path(path)
    Refinery::Page.find_by_path(path)
  end

  def session_content_empty?(path, session)
    unless page_by_path(path).nil?
      page_by_path(path).content_for(session) == ''
    end
  end

  def session_content(path, session)
    unless page_by_path(path).nil?
      raw page_by_path(path).content_for(session)
    end
  end

  def current_page_session_empty?(session)
    @page.content_for(session) == ''
  end

  def current_page_session(session)
    raw @page.content_for(session)
  end

  def determine_common_content(path, session)
    current_page_session_empty?(session) ? session_content(path, session) : current_page_session(session)
  end
end
