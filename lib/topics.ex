defmodule ReminderCli.Topics do
  @moduledoc """
  Documentation for `Topics`.
  """
  alias ReminderCli.Topic

  def list_topics!(root_path) do
    root_path
    |> File.ls!()
    |> Enum.filter(fn file_name -> File.dir?("#{root_path}/#{file_name}") end)
    |> Enum.filter(fn file_name -> !String.starts_with?(file_name, ".") end)
    |> Enum.map(fn file_name -> Topic.from_file_name(file_name) end)
  end

  def due_topics(topics) do
    topics
    |> Enum.filter(&Topic.due?/1)
  end

  def confirm_revision(topics, callback) do
    topics
    |> Enum.each(fn topic -> callback.(topic) end)
  end

  def due_topics(_) do
    throw("Not implemented")
  end
end
