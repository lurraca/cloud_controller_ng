require 'spec_helper'
require 'presenters/v3/cache_key_presenter'

module VCAP::CloudController::Presenters::V3
  RSpec.describe CacheKeyPresenter do
    context 'v2 app / v3 process' do
      it 'renders as app_guid/stack_name' do
        process = VCAP::CloudController::ProcessModel.make

        key = CacheKeyPresenter.cache_key(guid: process.guid, stack_name: process.stack.name)

        expect(key).to eq("#{process.guid}/#{process.stack.name}")
      end
    end

    context 'v3 AppModel' do
      it 'renders as app_guid/stack_name' do
        app = VCAP::CloudController::AppModel.make
        stack_name = VCAP::CloudController::Stack.make.name
        key = CacheKeyPresenter.cache_key(guid: app.guid, stack_name: stack_name)
        expect(key).to eq("#{app.guid}/#{stack_name}")
      end
    end
  end
end
