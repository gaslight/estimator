defmodule Estimator.TeamMemberTest do
  use Estimator.ModelCase

  alias Estimator.TeamMember

  @valid_attrs %{email: "some content", project_id: 1}
  @invalid_attrs %{foo: "bar"}

  test "changeset with valid attributes" do
    changeset = TeamMember.changeset(%TeamMember{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = TeamMember.changeset(%TeamMember{}, @invalid_attrs)
    refute changeset.valid?
  end
end
