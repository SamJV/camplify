require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'creates a valid task' do
    task = Task.new(
      title: 'Task title',
      description: 'Task Description',
      completed_at: Time.now
    )

    expect(task).to be_valid
    expect(task.title).not_to be_blank
    expect(task.description).not_to be_blank
    expect(task.completed_at).not_to be_blank
    expect(task.errors).to be_blank
  end

  it 'is a valid task with only a title' do
    task = Task.new(
      title: 'Task title'
    )
    task.valid?
    expect(task.title).not_to be_blank
    expect(task.errors).to be_blank
  end

  it 'is a not a valid task without a title' do
    task = Task.new(
      description: 'Task Description',
      completed_at: Time.now
    )
    task.valid?
    expect(task.errors).not_to be_blank
  end

  describe 'incomplete tasks' do
    before do
      @task_a = Task.create(title: 'title', description: 'description')
      @task_b = Task.new(title: 'title 2', description: 'description')
      @task_a.completed_at = Time.now
    end
    it 'has at least one incomplete task' do
      incomplete_tasks = Task.incomplete
      incomplete_tasks.present?
      expect(incomplete_tasks.size).to be >= 1
    end

    

  end

end
