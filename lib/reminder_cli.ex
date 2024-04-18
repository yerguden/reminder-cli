defmodule ReminderCli do
  @moduledoc """
  Documentation for `ReminderCli`.
  """

  alias ReminderCli.Topics

  @doc """
  Hello world.

  ## Examples

      iex> ReminderCli.hello()
      :world

  """
  def hello do
    :world
  end

  def remind(dir) do
    dir
    # should return Topic  
    |> Topics.list_topics!()
    # filter topics which havent been reminded in a while 
    |> Topics.due_topics()
    # confirm revision is done via callback 
    |> Topics.confirm_revision(fn topic_label -> {:ok, IO.puts(topic_label)} end)
  end
end
