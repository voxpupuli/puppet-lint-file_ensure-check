PuppetLint.new_check(:file_ensure) do
  def check
    resource_indexes.each do |resource|
      next unless resource[:type].value == 'file'

      attr = resource[:tokens].select do |t|
        t.type == :NAME &&
          t.value == 'ensure' &&
          t.next_code_token.type == :FARROW
      end
      next if attr.empty?

      val_token = attr[0].next_code_token.next_code_token
      next unless val_token.value == 'present'
      next unless %i[NAME STRING SSTRING].include? val_token.type

      notify :warning, {
        message: 'ensure set to present on file resource',
        line: val_token.line,
        column: val_token.column,
        token: val_token,
        resource: resource,
      }
    end
  end

  def fix(problem)
    target_attr = problem[:resource][:tokens].select do |t|
      t.type == :NAME &&
        t.value == 'target' &&
        t.next_code_token.type == :FARROW
    end
    problem[:token].value = if target_attr.empty?
                              'file'
                            else
                              'link'
                            end
  end
end
