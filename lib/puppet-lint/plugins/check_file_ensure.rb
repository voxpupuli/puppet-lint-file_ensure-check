PuppetLint.new_check(:file_ensure) do
  def check
    resource_indexes.each do |resource|
      if resource[:type].value == 'file'
        attr = resource[:tokens].select { |t| t.type == :NAME && t.value == 'ensure' && t.next_code_token.type == :FARROW }
        unless attr.empty?
          val_token = attr[0].next_code_token.next_code_token
          if val_token.value == 'present'
              notify :warning, {
                :message => 'ensure set to present on file resource',
                :line    => val_token.line,
                :column  => val_token.column,
                :token   => val_token,
              }
          end
        end
      end
    end
  end
end
