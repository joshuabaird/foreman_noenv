module ForemanNoenv
  module HostManagedExtensions
    extend ActiveSupport::Concern

    included do
      alias_method_chain :info, :env
    end

    def info_with_env
      noenv ? info_without_env.except('environment') : info_without_env
    end

  end
end
