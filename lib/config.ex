defmodule ReminderCli.Config do
  @moduledoc """
  Documentation for `Config`.
  """
  alias ReminderCli.Topic
  alias ReminderCli.Topics

  def root_path() do
    Path.join([File.cwd!(), "topics"])
  end

  def topics() do
    Topics.list_topics!(root_path())
  end

  def due_topics() do
    Topics.due_topics(topics())
  end

  def confirm_revision(callback) do
    Topics.confirm_revision(due_topics(), callback)
  end
end
