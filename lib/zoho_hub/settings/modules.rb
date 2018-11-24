# frozen_string_literal: true

require 'zoho_hub/with_connection'
require 'zoho_hub/with_attributes'

module ZohoHub
  module Settings
    # Zoho CRM has standard modules such as, Leads, Accounts, Contacts, Deals, Forecasts,
    # Activities, etc,. Using Zoho CRM REST API, you can retrieve the list of available modules.
    #
    # convertable: Describes if the user can convert the record into another type of record.
    #              For example: Convert Leads in to Deals.
    # creatable: Checks if the user can create a record in the current module.
    # generated_type: Describes the type of module which would be generated by the user. There are
    #                 4 types: default, web, custom, linking.
    # api_supported: The modules which are currently not accessible by APIs have value as "false".
    #                If the modules are supported in the future, the value automatically changes
    #                to "true".
    # modified_time: The date and time of changes made by the user.
    #
    # More details: https://www.zoho.com/crm/help/api/v2/#Modules-APIs
    class Modules
      include WithConnection
      include WithAttributes

      REQUEST_PATH = 'settings/modules'

      attributes :convertable, :editable, :deletable, :web_link, :singular_label, :modified_time,
                 :viewable, :api_supported, :creatable, :plural_label, :api_name, :modified_by,
                 :generated_type, :id, :module_name

      def self.all
        response = get(REQUEST_PATH)

        modules = response[:modules]
        modules.map { |json| new(json) }
      end

      def initialize(json = {})
        attributes.each { |attr| self.send("#{attr}=", json[attr]) }
      end
    end
  end
end
