# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::Web::Api::Endpoints::Views do
  let(:client) { Slack::Web::Client.new }
  let(:trigger_id) { '12345.98765.abcd2358fdea' }

  describe 'views_open' do
    context 'with a hash for view' do
      let(:view_str) { '{"celery":"man"}' }

      it 'automatically converts view into JSON' do
        expect(client).to receive(:post).with('views.open', trigger_id: trigger_id, view: view_str)
        client.views_open(trigger_id: trigger_id, view: { celery: 'man' })
      end
    end

    context 'with a string for view' do
      let(:view_str) { 'celery man' }

      it 'leaves view as is' do
        expect(client).to receive(:post).with('views.open', trigger_id: trigger_id, view: view_str)
        client.views_open(trigger_id: trigger_id, view: 'celery man')
      end
    end
  end

  describe 'views_publish' do
    let(:user_id) { 'U1234' }

    context 'with a hash for view' do
      let(:view_str) { '{"celery":"man"}' }

      it 'automatically converts view into JSON' do
        expect(client).to receive(:post).with('views.publish',
                                              user_id: user_id,
                                              trigger_id: trigger_id,
                                              view: view_str)
        client.views_publish(user_id: user_id, trigger_id: trigger_id, view: { celery: 'man' })
      end
    end

    context 'with a string for view' do
      let(:view_str) { 'celery man' }

      it 'leaves view as is' do
        expect(client).to receive(:post).with('views.publish',
                                              user_id: user_id,
                                              trigger_id: trigger_id,
                                              view: view_str)
        client.views_publish(user_id: user_id, trigger_id: trigger_id, view: 'celery man')
      end
    end
  end

  describe 'views_push' do
    context 'with a hash for view' do
      let(:view_str) { '{"celery":"man"}' }

      it 'automatically converts view into JSON' do
        expect(client).to receive(:post).with('views.push', trigger_id: trigger_id, view: view_str)
        client.views_push(trigger_id: trigger_id, view: { celery: 'man' })
      end
    end

    context 'with a string for view' do
      let(:view_str) { 'celery man' }

      it 'leaves view as is' do
        expect(client).to receive(:post).with('views.push', trigger_id: trigger_id, view: view_str)
        client.views_push(trigger_id: trigger_id, view: 'celery man')
      end
    end
  end

  describe 'views_update' do
    context 'with a hash for view' do
      let(:view_str) { '{"celery":"man"}' }

      it 'automatically converts view into JSON' do
        expect(client).to receive(:post).with('views.update', view: view_str)
        client.views_update(view: { celery: 'man' })
      end
    end

    context 'with a string for view' do
      let(:view_str) { 'celery man' }

      it 'leaves view as is' do
        expect(client).to receive(:post).with('views.update', view: view_str)
        client.views_update(view: 'celery man')
      end
    end
  end
end
