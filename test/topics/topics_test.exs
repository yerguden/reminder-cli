defmodule TopicsTest do
  use ExUnit.Case
  alias ReminderCli.Topics
  alias ReminderCli.Topic
  doctest Topics

  defp topic_directory(path) do
    "test/Topics/fixtures/#{path}"
  end

  defp file_names(topics) do
    topics |> Enum.map(&Topic.name/1)
  end

  describe "list_topics" do
    test "returns empty list if directory is empty" do
      topics = topic_directory("list-topics/nothing") |> Topics.list_topics!() |> file_names()

      assert topics == []
    end

    test "lists the topics" do
      topics =
        "list-topics/some-topics"
        |> topic_directory
        |> Topics.list_topics!()
        |> Enum.sort()
        |> file_names()

      assert topics == ["topic-a", "topic-b"]
    end

    test "ignores files" do
      topics =
        "list-topics/topics-and-files"
        |> topic_directory
        |> Topics.list_topics!()
        |> Enum.sort()
        |> file_names()

      assert topics == ["topic-a"]
    end

    test "ignores hidden folders" do
      topics =
        "list-topics/topics-and-hidden-folders"
        |> topic_directory()
        |> Topics.list_topics!()
        |> Enum.sort()
        |> file_names()

      assert topics == ["topic-a"]
    end
  end

  describe "due_topics" do
    test "returns empty list if no topics are due" do
      topics = [
        %Topic{
          name: "topic-a",
          last_revised: Date.utc_today() |> Date.add(-29)
        },
        %Topic{
          name: "topic-b",
          last_revised: Date.utc_today() |> Date.add(-29)
        }
      ]

      due_topics = topics |> Topics.due_topics()
      assert due_topics == []
    end

    test "returns topics that are due" do
      old_date = Date.utc_today() |> Date.add(-31)
      new_date = Date.utc_today() |> Date.add(-29)

      topics =
        [old_topic, new_topic] = [
          %Topic{
            name: "topic-a",
            last_revised: old_date
          },
          %Topic{
            name: "topic-b",
            last_revised: new_date
          }
        ]

      due_topics = topics |> Topics.due_topics()
      assert due_topics == [old_topic]
    end
  end
end
