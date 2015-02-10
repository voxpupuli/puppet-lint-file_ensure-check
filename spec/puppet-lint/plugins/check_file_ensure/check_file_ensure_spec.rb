require 'spec_helper'

describe 'file_ensure' do
  let (:msg) { 'ensure set to present on file resource' }

  context 'with fix disabled' do
    context 'correct file resource declarations' do
      let (:code) {
        <<-EOS
        file { '/etc/sudoers':
          ensure => file,
        }

        file { '/etc/fstab':
          ensure => 'file',
        }
        EOS
      }

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end
    end

    context 'wrong file resource declarations' do
      let (:code) {
        <<-EOS
        file { '/etc/sudoers':
          ensure => present,
        }

        file { '/etc/fstab':
          ensure => 'present',
        }
        EOS
      }

      it 'should detect a single problem' do
        expect(problems).to have(2).problems
      end

      it 'should create a warning' do
        expect(problems).to contain_warning(msg).on_line(2).in_column(21)
        expect(problems).to contain_warning(msg).on_line(6).in_column(21)
      end
    end
  end
end
