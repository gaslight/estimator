defmodule Estimator.StoryTest do
  use Estimator.ModelCase

  alias Estimator.Story

  @valid_attrs %{description: "some content", estimate: 42, title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Story.changeset(%Story{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Story.changeset(%Story{}, @invalid_attrs)
    refute changeset.valid?
  end
end
