require 'active_model'
require 'validates_cpf_cnpj/cpf'
require 'validates_cpf_cnpj/cnpj'

module ActiveModel
  module Validations
    module CpfValidation
      def validate_cpf(record, attr_name, value)
        return if (value.to_s.match(/\A\d{11}\z/) || value.to_s.match(/\A\d{3}\.\d{3}\.\d{3}\-\d{2}\z/)) &&
                  ValidatesCpfCnpj::Cpf.valid?(value)

        record.errors.add(attr_name)
      end
    end

    module CnpjValidation
      def validate_cnpj(record, attr_name, value)
        return if (value.to_s.match(/\A\d{14}\z/) || value.to_s.match(/\A\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2}\z/)) &&
                  ValidatesCpfCnpj::Cnpj.valid?(value)

        record.errors.add(attr_name)
      end
    end

    class CpfOrCnpjValidator < ActiveModel::EachValidator
      include CpfValidation
      include CnpjValidation

      def validate_each(record, attr_name, value)
        return unless should_validate? record, value

        if value.to_s.gsub(/[^0-9]/, '').length <= 11
          validate_cpf record, attr_name, value
        else
          validate_cnpj record, attr_name, value
        end
      end

      private def should_validate?(record, value)
        return if (options[:allow_nil] && value.nil?) || (options[:allow_blank] && value.blank?)
        return if (options[:if] == false) || (options[:unless] == true)
        return if (options[:on].to_s == 'create' && !record.new_record?) || (options[:on].to_s == 'update' && record.new_record?)

        true
      end
    end

    class CpfValidator < CpfOrCnpjValidator
      def validate_each(record, attr_name, value)
        return unless should_validate? record, value

        validate_cpf record, attr_name, value
      end
    end

    class CnpjValidator < CpfOrCnpjValidator
      def validate_each(record, attr_name, value)
        return unless should_validate? record, value

        validate_cnpj record, attr_name, value
      end
    end

    module HelperMethods
      def validates_cpf(*attr_names)
        raise ArgumentError, "You need to supply at least one attribute" if attr_names.empty?
        validates_with CpfValidator, _merge_attributes(attr_names)
      end

      def validates_cnpj(*attr_names)
        raise ArgumentError, "You need to supply at least one attribute" if attr_names.empty?
        validates_with CnpjValidator, _merge_attributes(attr_names)
      end

      def validates_cpf_or_cnpj(*attr_names)
        raise ArgumentError, "You need to supply at least one attribute" if attr_names.empty?
        validates_with CpfOrCnpjValidator, _merge_attributes(attr_names)
      end
    end
  end
end
