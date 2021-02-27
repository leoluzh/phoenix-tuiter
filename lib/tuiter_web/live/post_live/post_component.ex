defmodule TuiterWeb.PostLive.PostComponent do
  use TuiterWeb, :live_component

  def render(assigns) do
    ~L"""
    <div id="post-<%= @post.id %>" class="post">
      <div class="row">
        <div class="column column-10">
          <div class="post-avatar"></div>
        </div>
        <div class="column column-90 post-body">
          <b>@<%= @post.username %></b>
          <br/>
          <%= @post.body %>
        </div>
      </div>

      <div class="row">
        <div class="column post-button-column">
          <a href="#" phx-click="like" phx-target="<%= @myself %>">
          <i class="far fa-heart"></i> <%= @post.likes_count %>
        </div>
        <div class="column post-button-column">
          <a href="#" phx-click="repost" phx-target="<%= @myself %>">
          <i class="far fa-hand-peace"></i> <%= @post.reposts_count %>
        </div>
        <div class="column post-button-column">
          <%= live_patch to: Routes.post_index_path(@socket, :edit, @post.id) do %>
            <i class="far fa-edit"></i>
          <% end %>
          <%= link to: "#", phx_click: "delete", phx_value_id: @post.id do %>
            <i class="far fa-trash-alt"></i>
          <% end %>
        </div>
      </div>
    </div>
    """
  end

  def handle_event("like", _payload, socket) do
    Tuiter.Timeline.inc_likes(socket.assigns.post)
    {:noreply, socket}
  end

  def handle_event("repost", _payload, socket) do
    Tuiter.Timeline.inc_reposts(socket.assigns.post)
    {:noreply, socket}
  end


end
