defmodule App.SchoolTest do
  use App.DataCase

  alias App.School

  describe "students" do
    alias App.School.Student

    @valid_attrs %{firstname: "some firstname", lastname: "some lastname"}
    @update_attrs %{firstname: "some updated firstname", lastname: "some updated lastname"}
    @invalid_attrs %{firstname: nil, lastname: nil}

    def student_fixture(attrs \\ %{}) do
      {:ok, student} =
        attrs
        |> Enum.into(@valid_attrs)
        |> School.create_student()

      student
    end

    test "list_students/0 returns all students" do
      student = student_fixture()
      assert School.list_students() == [student]
    end

    test "get_student!/1 returns the student with given id" do
      student = student_fixture()
      assert School.get_student!(student.id) == student
    end

    test "create_student/1 with valid data creates a student" do
      assert {:ok, %Student{} = student} = School.create_student(@valid_attrs)
      assert student.firstname == "some firstname"
      assert student.lastname == "some lastname"
    end

    test "create_student/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = School.create_student(@invalid_attrs)
    end

    test "update_student/2 with valid data updates the student" do
      student = student_fixture()
      assert {:ok, %Student{} = student} = School.update_student(student, @update_attrs)
      assert student.firstname == "some updated firstname"
      assert student.lastname == "some updated lastname"
    end

    test "update_student/2 with invalid data returns error changeset" do
      student = student_fixture()
      assert {:error, %Ecto.Changeset{}} = School.update_student(student, @invalid_attrs)
      assert student == School.get_student!(student.id)
    end

    test "delete_student/1 deletes the student" do
      student = student_fixture()
      assert {:ok, %Student{}} = School.delete_student(student)
      assert_raise Ecto.NoResultsError, fn -> School.get_student!(student.id) end
    end

    test "change_student/1 returns a student changeset" do
      student = student_fixture()
      assert %Ecto.Changeset{} = School.change_student(student)
    end
  end
end
