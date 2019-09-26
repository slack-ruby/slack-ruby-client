# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Slack::Web::Api::Endpoints::Views do
  let(:client) { Slack::Web::Client.new }

  context 'views_open' do
    context 'with a hash for view' do
      it 'automatically converts view into JSON' do
        expect(client).to receive(:post).with(
          'views.open',
          trigger_id: '12345.98765.abcd2358fdea',
          view: '{"celery":"man"}'
        )
        client.views_open(trigger_id: '12345.98765.abcd2358fdea', view: {celery: 'man'})
      end
    end
    context 'with a string for view' do
      it 'leaves view as is' do
        expect(client).to receive(:post).with(
          'views.open',
          trigger_id: '12345.98765.abcd2358fdea',
          view: 'celery man'
        )
        client.views_open(trigger_id: '12345.98765.abcd2358fdea', view: 'celery man')
      end
    end
  end

  context 'views_push' do
    context 'with a hash for view' do
      it 'automatically converts view into JSON' do
        expect(client).to receive(:post).with(
          'views.push',
          trigger_id: '12345.98765.abcd2358fdea',
          view: '{"celery":"man"}'
        )
        client.views_push(trigger_id: '12345.98765.abcd2358fdea', view: {celery: 'man'})
      end
    end
    context 'with a string for view' do
      it 'leaves view as is' do
        expect(client).to receive(:post).with(
          'views.push',
          trigger_id: '12345.98765.abcd2358fdea',
          view: 'celery man'
        )
        client.views_push(trigger_id: '12345.98765.abcd2358fdea', view: 'celery man')
      end
    end
  end

  context 'views_update' do
    context 'with a hash for view' do
      it 'automatically converts view into JSON' do
        expect(client).to receive(:post).with(
          'views.update',
          view: '{"celery":"man"}'
        )
        client.views_update(view: {celery: 'man'})
      end
    end
    context 'with a string for view' do
      it 'leaves view as is' do
        expect(client).to receive(:post).with(
          'views.update',
          view: 'celery man'
        )
        client.views_update(view: 'celery man')
      end
    end
  end
end
