# frozen_string_literal: true

require 'spec_helper'

describe ValidatesCpfCnpj do
  describe 'validates_cpf' do
    it 'raises an ArgumentError when no attribute is informed' do
      person = Person.new
      expect { person.validates_cpf }.to raise_exception(ArgumentError, 'You need to supply at least one attribute')
    end

    context 'when cpf is invalid' do
      invalid_cpfs = %w[1234567890 12345678901 ABC45678901 123.456.789-01 800337.878-83 800337878-83]

      invalid_cpfs.each do |cpf|
        context "when value is #{cpf}" do
          it 'does not accept it' do
            person = Person.new(code: cpf)
            person.validates_cpf(:code)
            expect(person.errors).not_to be_empty
          end
        end
      end

      context 'when value is a valid CNPJ' do
        it 'does not accept it' do
          person = Person.new(code: '05393625000184')
          person.validates_cpf(:code)
          expect(person.errors).not_to be_empty
        end
      end

      context 'when value is a valid formatted CNPJ' do
        it 'does not accept it' do
          person = Person.new(code: '05.393.625/0001-84')
          person.validates_cpf(:code)
          expect(person.errors).not_to be_empty
        end
      end

      context 'when value is a valid alphanumeric CNPJ' do
        it 'does not accept it' do
          person = Person.new(code: '12ABC34501DE35')
          person.validates_cpf(:code)
          expect(person.errors).not_to be_empty
        end
      end

      context 'when value is nil' do
        it 'does not accept it' do
          person = Person.new(code: nil)
          person.validates_cpf(:code)
          expect(person.errors).not_to be_empty
        end
      end

      context 'when value is empty' do
        it 'does not accept it' do
          person = Person.new(code: '')
          person.validates_cpf(:code)
          expect(person.errors).not_to be_empty
        end
      end

      # These numbers would be considered valid by the algorithm but are known
      # as not valid in the real world, so they should be blocked
      blocked_cpfs = %w[12345678909 11111111111 22222222222 33333333333
                        44444444444 55555555555 66666666666 77777777777
                        88888888888 99999999999 00000000000]

      blocked_cpfs.each do |cpf|
        context "when value is #{cpf}" do
          it 'does not accept it' do
            person = Person.new(code: cpf)
            person.validates_cpf(:code)
            expect(person.errors).not_to be_empty
          end
        end
      end
    end

    context 'when cpf is valid' do
      context 'when value is 80033787883' do
        it 'accepts it' do
          person = Person.new(code: '80033787883')
          person.validates_cpf(:code)
          expect(person.errors).to be_empty
        end
      end

      context 'when value is 800.337.878-83' do
        it 'accepts it' do
          person = Person.new(code: '800.337.878-83')
          person.validates_cpf(:code)
          expect(person.errors).to be_empty
        end
      end

      context 'when value is nil and :allow_nil or :allow_blank is true' do
        it 'accepts it' do
          person = Person.new(code: nil)
          person.validates_cpf(:code, allow_nil: true)
          expect(person.errors).to be_empty
          person.validates_cpf(:code, allow_blank: true)
          expect(person.errors).to be_empty
        end
      end

      context 'when value is empty and :allow_blank is true' do
        it 'accepts it' do
          person = Person.new(code: '')
          person.validates_cpf(:code, allow_blank: true)
          expect(person.errors).to be_empty
          person.validates_cpf(:code, allow_nil: true)
          expect(person.errors).not_to be_empty
        end
      end

      context 'when :if option evaluates false' do
        it 'accepts it' do
          person = Person.new(code: '12345678901')
          person.validates_cpf(:code, if: false)
          expect(person.errors).to be_empty
        end
      end

      context 'when :unless option evaluates true' do
        it 'accepts it' do
          person = Person.new(code: '12345678901')
          person.validates_cpf(:code, unless: true)
          expect(person.errors).to be_empty
        end
      end

      context 'when :on option is :create and the model instance is not a new record' do
        it 'accepts it' do
          person = Person.new(code: '12345678901')
          allow(person).to receive(:new_record?).and_return(false)
          person.validates_cpf(:code, on: :create)
          expect(person.errors).to be_empty
        end
      end

      context 'when :on option is :update and the model instance is a new record' do
        it 'accepts it' do
          person = Person.new(code: '12345678901')
          person.validates_cpf(:code, on: :update)
          expect(person.errors).to be_empty
        end
      end
    end
  end

  describe 'validates_cnpj' do
    it 'raises an ArgumentError when no attribute is informed' do
      person = Person.new
      expect { person.validates_cnpj }.to raise_exception(ArgumentError, 'You need to supply at least one attribute')
    end

    context 'when cnpj is invalid' do
      invalid_cnpjs = %w[1234567890123 12345678901234 123456789012345 ABC05393625000184 12.345.678/9012-34
                         05393.625/0001-84 05393.6250001-84]

      invalid_cnpjs.each do |cnpj|
        context "when value is #{cnpj}" do
          it 'does not accept it' do
            person = Person.new(code: cnpj)
            person.validates_cnpj(:code)
            expect(person.errors).not_to be_empty
          end
        end
      end

      context 'when value is a valid CPF' do
        it 'does not accept it' do
          person = Person.new(code: '80033787883')
          person.validates_cnpj(:code)
          expect(person.errors).not_to be_empty
        end
      end

      context 'when value is a valid formatted CPF' do
        it 'does not accept it' do
          person = Person.new(code: '800.337.878-83')
          person.validates_cnpj(:code)
          expect(person.errors).not_to be_empty
        end
      end

      context 'when value is a valid formatted CPF' do
        it 'does not accept it' do
          person = Person.new(code: '800.337.878-83')
          person.validates_cnpj(:code)
          expect(person.errors).not_to be_empty
        end
      end

      context 'when value is nil' do
        it 'does not accept it' do
          person = Person.new(code: nil)
          person.validates_cnpj(:code)
          expect(person.errors).not_to be_empty
        end
      end

      context 'when value is empty' do
        it 'does not accept it' do
          person = Person.new(code: '')
          person.validates_cnpj(:code)
          expect(person.errors).not_to be_empty
        end
      end
    end

    context 'when cnpj is valid' do
      context 'when value is 05393625000184' do
        it 'accepts it' do
          person = Person.new(code: '05393625000184')
          person.validates_cnpj(:code)
          expect(person.errors).to be_empty
        end
      end

      context 'when value is 05.393.625/0001-84' do
        it 'accepts it' do
          person = Person.new(code: '05.393.625/0001-84')
          person.validates_cnpj(:code)
          expect(person.errors).to be_empty
        end
      end

      context 'when value is a valid alphanumeric CNPJ' do
        it 'accepts it' do
          person = Person.new(code: '12ABC34501DE35')
          person.validates_cnpj(:code)
          expect(person.errors).to be_empty
        end
      end

      context 'when value is a valid formatted alphanumeric CNPJ' do
        it 'accepts it' do
          person = Person.new(code: '12.ABC.345/01DE-35')
          person.validates_cnpj(:code)
          expect(person.errors).to be_empty
        end
      end

      context 'when value is nil and :allow_nil or :allow_blank is true' do
        it 'accepts it' do
          person = Person.new(code: nil)
          person.validates_cnpj(:code, allow_nil: true)
          expect(person.errors).to be_empty
          person.validates_cnpj(:code, allow_blank: true)
          expect(person.errors).to be_empty
        end
      end

      context 'when value is empty and :allow_blank is true' do
        it 'accepts it' do
          person = Person.new(code: '')
          person.validates_cnpj(:code, allow_blank: true)
          expect(person.errors).to be_empty
          person.validates_cnpj(:code, allow_nil: true)
          expect(person.errors).not_to be_empty
        end
      end

      context 'when :if option evaluates false' do
        it 'accepts it' do
          person = Person.new(code: '12345678901234')
          person.validates_cnpj(:code, if: false)
          expect(person.errors).to be_empty
        end
      end

      context 'when :unless option evaluates true' do
        it 'accepts it' do
          person = Person.new(code: '12345678901234')
          person.validates_cnpj(:code, unless: true)
          expect(person.errors).to be_empty
        end
      end

      context 'when :on option is :create and the model instance is not a new record' do
        it 'accepts it' do
          person = Person.new(code: '12345678901')
          allow(person).to receive(:new_record?).and_return(false)
          person.validates_cnpj(:code, on: :create)
          expect(person.errors).to be_empty
        end
      end

      context 'when :on option is :update and the model instance is a new record' do
        it 'accepts it' do
          person = Person.new(code: '12345678901')
          person.validates_cnpj(:code, on: :update)
          expect(person.errors).to be_empty
        end
      end
    end
  end

  describe 'validates_cpf_or_cnpj' do
    it 'raises an ArgumentError when no attribute is informed' do
      person = Person.new
      expect do
        person.validates_cpf_or_cnpj
      end.to raise_exception(ArgumentError, 'You need to supply at least one attribute')
    end

    context 'when the value is invalid' do
      invalid_numbers = %w[1234567890 12345678901 ABC45678901 123.456.789-01
                           800337.878-83 800337878-83 1234567890123
                           12345678901234 123456789012345 ABC05393625000184
                           12.345.678/9012-34 05393.625/0001-84 05393.6250001-84]
      invalid_numbers.each do |number|
        context "when value is #{number}" do
          it 'does not accept it' do
            person = Person.new(code: number)
            person.validates_cpf_or_cnpj(:code)
            expect(person.errors).not_to be_empty
          end
        end
      end

      context 'when value is nil' do
        it 'does not accept it' do
          person = Person.new(code: nil)
          person.validates_cpf_or_cnpj(:code)
          expect(person.errors).not_to be_empty
        end
      end

      context 'when value is empty' do
        it 'does not accept it' do
          person = Person.new(code: '')
          person.validates_cpf_or_cnpj(:code)
          expect(person.errors).not_to be_empty
        end
      end
    end

    context 'when the value is valid' do
      context 'when value is 80033787883' do
        it 'accepts it' do
          person = Person.new(code: '80033787883')
          person.validates_cpf_or_cnpj(:code)
          expect(person.errors).to be_empty
        end
      end

      context 'when value is 800.337.878-83' do
        it 'accepts it' do
          person = Person.new(code: '800.337.878-83')
          person.validates_cpf_or_cnpj(:code)
          expect(person.errors).to be_empty
        end
      end

      context 'when value is a valid alphanumeric CNPJ' do
        it 'accepts it' do
          person = Person.new(code: '12ABC34501DE35')
          person.validates_cpf_or_cnpj(:code)
          expect(person.errors).to be_empty
        end
      end

      context 'when value is nil and :allow_nil or :allow_blank is true' do
        it 'accepts it' do
          person = Person.new(code: nil)
          person.validates_cpf_or_cnpj(:code, allow_nil: true)
          expect(person.errors).to be_empty
          person.validates_cpf_or_cnpj(:code, allow_blank: true)
          expect(person.errors).to be_empty
        end
      end

      context 'when value is empty and :allow_blank is true' do
        it 'accepts it' do
          person = Person.new(code: '')
          person.validates_cpf_or_cnpj(:code, allow_blank: true)
          expect(person.errors).to be_empty
          person.validates_cpf_or_cnpj(:code, allow_nil: true)
          expect(person.errors).not_to be_empty
        end
      end

      context 'when :if option evaluates false' do
        it 'accepts it' do
          person = Person.new(code: '12345678901')
          person.validates_cpf_or_cnpj(:code, if: false)
          expect(person.errors).to be_empty
        end
      end

      context 'when :unless option evaluates true' do
        it 'accepts it' do
          person = Person.new(code: '12345678901')
          person.validates_cpf_or_cnpj(:code, unless: true)
          expect(person.errors).to be_empty
        end
      end

      context 'when :on option is :create and the model instance is not a new record' do
        it 'accepts it' do
          person = Person.new(code: '12345678901')
          allow(person).to receive(:new_record?).and_return(false)
          person.validates_cpf_or_cnpj(:code, on: :create)
          expect(person.errors).to be_empty
        end
      end

      context 'when :on option is :update and the model instance is a new record' do
        it 'accepts it' do
          person = Person.new(code: '12345678901')
          person.validates_cpf_or_cnpj(:code, on: :update)
          expect(person.errors).to be_empty
        end
      end

      context 'when value is 05393625000184' do
        it 'accepts it' do
          person = Person.new(code: '05393625000184')
          person.validates_cpf_or_cnpj(:code)
          expect(person.errors).to be_empty
        end
      end

      context 'when value is 05.393.625/0001-84' do
        it 'accepts it' do
          person = Person.new(code: '05.393.625/0001-84')
          person.validates_cpf_or_cnpj(:code)
          expect(person.errors).to be_empty
        end
      end

      context 'when value is nil and :allow_nil or :allow_blank is true' do
        it 'accepts it' do
          person = Person.new(code: nil)
          person.validates_cpf_or_cnpj(:code, allow_nil: true)
          expect(person.errors).to be_empty
          person.validates_cpf_or_cnpj(:code, allow_blank: true)
          expect(person.errors).to be_empty
        end
      end

      context 'when value is empty and :allow_blank is true' do
        it 'accepts it' do
          person = Person.new(code: '')
          person.validates_cpf_or_cnpj(:code, allow_blank: true)
          expect(person.errors).to be_empty
          person.validates_cpf_or_cnpj(:code, allow_nil: true)
          expect(person.errors).not_to be_empty
        end
      end

      context 'when :if option evaluates false' do
        it 'accepts it' do
          person = Person.new(code: '12345678901234')
          person.validates_cpf_or_cnpj(:code, if: false)
          expect(person.errors).to be_empty
        end
      end

      context 'when :unless option evaluates true' do
        it 'accepts it' do
          person = Person.new(code: '12345678901234')
          person.validates_cpf_or_cnpj(:code, unless: true)
          expect(person.errors).to be_empty
        end
      end

      context 'when :on option is :create and the model instance is not a new record' do
        it 'accepts it' do
          person = Person.new(code: '12345678901')
          allow(person).to receive(:new_record?).and_return(false)
          person.validates_cpf_or_cnpj(:code, on: :create)
          expect(person.errors).to be_empty
        end
      end

      context 'when :on option is :update and the model instance is a new record' do
        it 'accepts it' do
          person = Person.new(code: '12345678901')
          person.validates_cpf_or_cnpj(:code, on: :update)
          expect(person.errors).to be_empty
        end
      end
    end
  end
end
