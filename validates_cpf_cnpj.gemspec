# frozen_string_literal: true

require_relative 'lib/validates_cpf_cnpj/version'

Gem::Specification.new do |s|
  s.name        = 'validates_cpf_cnpj'
  s.version     = ValidatesCpfCnpj::VERSION
  s.authors     = ['Reginaldo Francisco', 'Wendel Scardua']
  s.email       = ['naldo_ds@yahoo.com.br', 'wendelscardua@gmail.com']
  s.homepage    = 'http://github.com/wendelscardua/validates_cpf_cnpj'
  s.summary     = 'CPF/CNPJ ActiveModel validations'
  s.description = 'CPF and CNPJ validations for ActiveModel and Rails'
  s.licenses    = ['MIT']

  s.required_ruby_version = '>= 3.0'

  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'activemodel', '>= 8.0.0'

  s.metadata = {
    'homepage_uri' => 'https://github.com/wendelscardua/validates_cpf_cnpj',
    'changelog_uri' => 'https://github.com/wendelscardua/validates_cpf_cnpj/blob/main/CHANGELOG.md',
    'source_code_uri' => 'https://github.com/wendelscardua/validates_cpf_cnpj',
    'bug_tracker_uri' => 'https://github.com/wendelscardua/validates_cpf_cnpj/issues',
    'rubygems_mfa_required' => 'true'
  }
end
