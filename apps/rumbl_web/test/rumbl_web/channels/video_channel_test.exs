defmodule RumblWeb.Channels.VideoChannelTest do
  use RumblWeb.ChannelCase
  import RumblWeb.TestHelpers

  # The calls to :timer.sleep() in these tests are to resolve
  # an error that happens when tests are run. All test still
  # pass however an error occurs because of an issue with the
  # database connection being closed before a Task finishes,
  # (at least I think that is why, 
  # see here: https://stackoverflow.com/questions/38335635/ecto-2-0-sql-sandbox-error-on-tests)

  setup do
    user = insert_user(name: "Gary")

    video = insert_video(user, title: "Testing")
    token = Phoenix.Token.sign(@endpoint, "user socket", user.id)
    {:ok, socket} = connect(RumblWeb.UserSocket, %{"token" => token})

    {:ok, socket: socket, user: user, video: video}
  end

  test "join replies with video annotations",
    %{socket: socket, video: vid, user: user} do
    for body <- ~w(one two) do
      Rumbl.Multimedia.annotate_video(user, vid.id, %{body: body, at: 0})
    end

    {:ok, reply, socket} = subscribe_and_join(socket, "videos:#{vid.id}", %{})

    assert socket.assigns.video_id == vid.id
    assert %{annotations: [%{body: "one"}, %{body: "two"}]} = reply

    :timer.sleep(1000)
  end

  test "inserting new annotations", %{socket: socket, video: vid} do
    {:ok, _, socket} = subscribe_and_join(socket, "videos:#{vid.id}", %{})
    ref = push socket, "new_annotation", %{body: "the body", at: 0}
    
    assert_reply ref, :ok, %{}
    assert_broadcast "new_annotation", %{}

    :timer.sleep(3000)
  end

  test "new annotations trigger InfoSys", %{socket: socket, video: vid} do
    insert_user(
      username: "wolfram",
      password: "supersecret"
    )

    {:ok, _, socket} = subscribe_and_join(socket, "videos:#{vid.id}", %{})
    ref = push socket, "new_annotation", %{body: "1 + 1", at: 123}

    assert_reply ref, :ok, %{}
    assert_broadcast "new_annotation", %{body: "1 + 1", at: 123}
    assert_broadcast "new_annotation", %{body: "2", at: 123}

    :timer.sleep(3000)
  end
end