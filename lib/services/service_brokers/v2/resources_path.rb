module VCAP::Services::ServiceBrokers::V2
  module ResourcesPath
    def self.service_instances(instance_guid, accepts_incomplete: false)
      path = "/v2/service_instances/#{instance_guid}"
      path += '?accepts_incomplete=true' if accepts_incomplete
      path
    end

    def self.service_instances_last_operation(instance)
      query_params = {}.tap do |q|
        q['plan_id']    = instance.service_plan.broker_provided_id
        q['service_id'] = instance.service.broker_provided_id
        q['operation']  = instance.last_operation.broker_provided_operation if instance.last_operation.broker_provided_operation
      end

      "#{service_instances(instance.guid)}/last_operation?#{query_params.to_query}"
    end

    def self.service_bindings(service_binding_guid, service_instance_guid, accepts_incomplete: false)
      path = "/v2/service_instances/#{service_instance_guid}/service_bindings/#{service_binding_guid}"
      path += '?accepts_incomplete=true' if accepts_incomplete
      path
    end

    def service_binding_last_operation_path(service_binding)
      query_params = {
       'service_id' => service_binding.service_instance.service.broker_provided_id,
       'plan_id' => service_binding.service_instance.service_plan.broker_provided_id
      }

      if service_binding.last_operation.broker_provided_operation
        query_params['operation'] = service_binding.last_operation.broker_provided_operation
      end
      "#{service_binding_resource_path(service_binding.guid, service_binding.service_instance.guid)}/last_operation?#{query_params.to_query}"
    end
  end
end
