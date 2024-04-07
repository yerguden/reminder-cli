defmodule ReminderCli.Topic do
  defstruct name: nil, last_revised: nil, revision_count: 0, next_revision: nil

  alias ReminderCli.Topic

  def due?(topic) do
    # check if topic hasnt been revised in a while
    Date.diff(Date.utc_today(), topic.last_revised) > 30
  end

  def set_next_revision(topic) do
    %Topic{topic | next_revision: Date.add(topic.last_revised, 30)}
  end

  def from_file_name(file_name) do
    %Topic{name: file_name}
  end

  def name(%Topic{name: name}) do
    name
  end
end
