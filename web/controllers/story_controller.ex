defmodule Estimator.StoryController do
  use Estimator.Web, :controller

  alias Estimator.Story
  alias Estimator.Project

  plug :scrub_params, "story" when action in [:create, :update]

  def index(conn, _params) do
    stories = Repo.all(Story)
    render(conn, "index.html", stories: stories)
  end

  def new(conn, _params) do
    changeset = Story.changeset(%Story{})
    projects = Repo.all(Project) |> Enum.map(&( {&1.name, &1.id} ))
    render(conn, "new.html", changeset: changeset, projects: projects)
  end

  def create(conn, %{"story" => story_params}) do
    changeset = Story.changeset(%Story{}, story_params)
    projects = Repo.all(Project) |> Enum.map(&( {&1.name, &1.id} ))
    case Repo.insert(changeset) do
      {:ok, _story} ->
        conn
        |> put_flash(:info, "Story created successfully.")
        |> redirect(to: story_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, projects: projects)
    end
  end

  def show(conn, %{"id" => id}) do
    story = Repo.get!(Story, id) |> Repo.preload([:project])
    render(conn, "show.html", story: story, current_user: get_session(conn, :current_user))
  end

  def edit(conn, %{"id" => id}) do
    story = Repo.get!(Story, id)
    projects = Repo.all(Project) |> Enum.map(&( {&1.name, &1.id} ))
    changeset = Story.changeset(story)
    render(conn, "edit.html", story: story, changeset: changeset, projects: projects)
  end

  def update(conn, %{"id" => id, "story" => story_params}) do
    story = Repo.get!(Story, id)
    projects = Repo.all(Project) |> Enum.map(&( {&1.name, &1.id} ))
    changeset = Story.changeset(story, story_params)

    case Repo.update(changeset) do
      {:ok, story} ->
        conn
        |> put_flash(:info, "Story updated successfully.")
        |> redirect(to: story_path(conn, :show, story))
      {:error, changeset} ->
        render(conn, "edit.html", story: story, changeset: changeset, projects: projects)
    end
  end

  def delete(conn, %{"id" => id}) do
    story = Repo.get!(Story, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(story)

    conn
    |> put_flash(:info, "Story deleted successfully.")
    |> redirect(to: story_path(conn, :index))
  end
end
