require 'spec_helper'

module VCAP::Services::ServiceBrokers::V2
  RSpec.describe ResourcesPath do
    let(:resources_path) { ResourcesPath }
    let(:service_instance) do
      VCAP::CloudController::ManagedServiceInstance.make(
        service_plan: plan,
        space:        space
      )
    end
    let(:service_instance_guid) { '948c9d06-845e-11e8-adc0-fa7ae01bbebc' }
    let(:service_binding_guid) { '15114c3f-1f28-48ea-8c8f-bb930666ce39' }

    describe '#service_instances' do
      it 'returns the correct path' do
        expect(resources_path.service_instances(service_instance_guid)).to eq('/v2/service_instances/948c9d06-845e-11e8-adc0-fa7ae01bbebc')
      end

      context 'accepts_incomplete=true' do
        it 'returns the correct path' do
          expect(resources_path.service_instances(service_instance_guid, accepts_incomplete: true)).
            to eq('/v2/service_instances/948c9d06-845e-11e8-adc0-fa7ae01bbebc?accepts_incomplete=true')
        end
      end
    end

    describe 'service_instances_last_operation' do
      let(:plan) { VCAP::CloudController::ServicePlan.make }
      let(:space) { VCAP::CloudController::Space.make }

      before do
        service_instance.save_with_new_operation({}, { type: 'create', broker_provided_operation: '123' })
      end

      it 'returns the correct path' do
        expect(resources_path.service_instances_last_operation(service_instance)).
          to eq('/v2/service_instances/e86892ba-6f98-420f-b69e-cd74a775c5ee/last_operation?operation=123&plan_id=74be7973-8d71-41fa-b912-54b4ef1cc7b6&service_id=5b8a9eba-7d0a-4ff8-93cf-482928e4bf75')
      end
    end

    describe '#service_binding' do
      it 'returns the correct path' do
        expect(resources_path.service_bindings(service_binding_guid, service_instance_guid)).
          to eq('/v2/service_instances/948c9d06-845e-11e8-adc0-fa7ae01bbebc/service_bindings/15114c3f-1f28-48ea-8c8f-bb930666ce39')
      end

      context 'accepts_incomplete=true' do
        it 'returns the correct path' do
          expect(resources_path.service_bindings(service_binding_guid, service_instance_guid, accepts_incomplete: true)).
            to eq('/v2/service_instances/948c9d06-845e-11e8-adc0-fa7ae01bbebc/service_bindings/15114c3f-1f28-48ea-8c8f-bb930666ce39?accepts_incomplete=true')
        end
      end
    end
  end
end
