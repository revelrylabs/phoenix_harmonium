defmodule Harmonium.Pagination do
  @moduledoc false
  @page_links_to_show 2
  import Phoenix.HTML

  def pagination(_conn, _url, _page_number, 1) do
    nil
  end

  def pagination(conn, url, page_number, total_pages) do
    ~E"""
    <div class="rev-PaginationWrapper text-center">
      <ul class="rev-Pagination" role="navigation" aria-label="Pagination">
        <%= unless first_page?(page_number) do %>
          <li class="rev-Pagination-arrow">
            <a href="<%= make_page_link(conn, 1, url) %>">
              <span><i class="icon-angle-double-left"></i>First<span class="ShowForSR"> page</span></span>
            </a>
          </li>
          <li class="rev-Pagination-arrow">
            <a href="<%= make_previous_page_link(conn, page_number, url) %>">
              <span><i class="icon-angle-left"></i>Previous<span class="ShowForSR"> page</span></span>
            </a>
          </li>
        <% end %>

        <%= for page <- 1..total_pages do %>
          <%= if show_previous_ellipsis?(page, page_number) do %>
            <li class="rev-Pagination-dots">
              ...
            </li>
          <% end %>
          <%= if show_page_link?(page, page_number) do %>
            <li class="rev-Pagination-number <%= selected_page_class(page, page_number)%>">
              <%= if page == page_number do %>
                <span class="ShowForSR">You're on page </span><a><%= page_number %></a>
              <% else %>
                <a href="<%= make_page_link(conn, page, url) %>" aria-label="Page <%= page %>"><%= page %></a>
              <% end %>
            </li>
          <% end %>
          <%= if show_next_ellipsis?(page, page_number, total_pages) do %>
            <li class="rev-Pagination-dots">
              ...
            </li>
          <% end %>
        <% end %>
        <%= unless last_page?(page_number, total_pages) do %>
          <li class="rev-Pagination-arrow">
            <a href="<%= make_next_page_link(conn, page_number, url) %>">
              <span>Next<span class="ShowForSR"> page</span><i class="icon-angle-right"></i></span>
            </a>
          </li>
          <li class="rev-Pagination-arrow">
            <a href="<%= make_page_link(conn, total_pages, url) %>">
              <span>Last<span class="ShowForSR"> page</span><i class="icon-angle-double-right"></i></span>
            </a>
          </li>
        <% end %>
      </ul>
      <div class="rev-PaginationWrapper-pageList">
        <span class="Small">( Page <%= page_number %> of <%= total_pages %> )</span>
      </div>
    </div>
    """
  end

  defp make_next_page_link(conn, current_page, url) do
    make_page_link(conn, current_page + 1, url)
  end

  defp make_previous_page_link(conn, current_page, url) do
    make_page_link(conn, current_page - 1, url)
  end

  defp make_page_link(conn, page, url) do
    query_params = conn.query_params

    query_params = Map.put(query_params, "page", page)

    uri = URI.parse(url)

    query_params =
      if is_nil(uri.query) do
        query_params
      else
        URI.decode_query(uri.query, query_params)
      end

    uri = %{uri | query: Plug.Conn.Query.encode(query_params)}

    URI.to_string(uri)
  end

  defp first_page?(1), do: true
  defp first_page?(_), do: false

  defp last_page?(page_number, total_pages) when page_number == total_pages, do: true
  defp last_page?(_, _), do: false

  defp selected_page_class(page_number, current_page) when page_number == current_page do
    "rev-Pagination-number--selected"
  end

  defp selected_page_class(_, _) do
    ""
  end

  defp show_previous_ellipsis?(1, _) do
    false
  end

  defp show_previous_ellipsis?(page, page_number) do
    page == page_number - @page_links_to_show
  end

  defp show_next_ellipsis?(page, page_number, total_pages) do
    page == page_number + @page_links_to_show and page != total_pages
  end

  defp show_page_link?(page, page_number) do
    page >= page_number - @page_links_to_show and page <= page_number + @page_links_to_show
  end
end
