# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TasksControllers', type: :request do
  describe 'GET' do
    it 'get returns a successful response' do
      get '/tasks'
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST' do
    it 'post creates a new task' do
      post '/tasks', params: { task: { title: 'Task Title', description: 'Task Description' } }
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to have_key('id')
      expect(JSON.parse(response.body)).to have_key('title')
      expect(JSON.parse(response.body)).to have_key('description')
    end

    it 'post without title returns error' do
      post '/tasks', params: { task: { description: 'Task Description' } }
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe 'PATCH' do
    before do
      @task = Task.create(title: 'title', description: 'description')
      @new_task = Task.new(title: 'title 2', description: 'description')
    end

    it 'patch completes task' do
      patch "/tasks/#{@task.id}/completed", params: { id: @task.id }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to have_key('completed_at')
      expect(JSON.parse(response.body)['completed_at']).not_to eql(nil)
    end

    it 'patch returns not found' do
      patch "/tasks/#{@new_task.id}/completed", params: { id: @new_task.id }
      expect(response).to have_http_status(:not_found)
    end

  end
end
