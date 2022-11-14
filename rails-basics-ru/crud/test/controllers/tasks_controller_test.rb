require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:one)
  end

  teardown do
    Rails.cache.clear
  end

  test 'should get index' do
    get tasks_url
    assert_response :success
  end

  test 'should show task' do
    get task_url(@task)
    assert_response :success
    assert_equal 'MyString', @task.name
  end

  test 'should update task' do
    patch task_path(@task), params: { task: { status: 'finished' } }
    assert_redirected_to task_path(@task)

    @task.reload
    assert_equal 'finished', @task.status
  end

  test 'should create task' do
    assert_difference('Task.count') do
      post tasks_path, params: { task: { name: 'Test task',
                                         description: 'Description is bad',
                                         status: 'new',
                                         creator: 'Author the Pyotor',
                                         performer: 'The dog - bow wow',
                                         completed: 'false' } }
    end

    assert_redirected_to task_path(Task.last)
    assert_equal 'Test task', Task.last.name
  end

  test 'should not create task because of validation' do
    task_name = 'Empty task'
    post tasks_path, params: { task: { name: task_name } }
    assert_response 422

    assert_not Task.find_by(name: task_name)
  end

  test 'should destroy task' do
    assert_difference('Task.count', -1) do
      delete task_url(@task)
    end
    assert_redirected_to tasks_path
  end
end
