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
          ensure => 'target',
          target => '/etc/mtab',
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
          target => '/etc/mtab',
        }
        EOS
      }

      it 'should detect problems' do
        expect(problems).to have(2).problems
      end

      it 'should create a warning' do
        expect(problems).to contain_warning(msg).on_line(2).in_column(21)
        expect(problems).to contain_warning(msg).on_line(6).in_column(21)
      end
    end
  end

  context 'with fix enabled' do
    before do
      PuppetLint.configuration.fix = true
    end

    after do
      PuppetLint.configuration.fix = false
    end

    context 'correct file resource declarations' do
      let (:code) {
        <<-EOS
        file { '/etc/sudoers':
          ensure => file,
        }

        file { '/etc/fstab':
          ensure => 'target',
          target => '/etc/mtab',
        }
        EOS
      }

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end

      it 'should not modify the manifest' do
        expect(manifest).to eq(code)
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
          target => '/etc/mtab',
        }
        EOS
      }

      it 'should detect two problems' do
        expect(problems).to have(2).problems
      end

      it 'should create a warning' do
        expect(problems).to contain_fixed(msg).on_line(2).in_column(21)
        expect(problems).to contain_fixed(msg).on_line(6).in_column(21)
      end

      it 'should fix the ensure parameter' do
        expect(manifest).to eq(
          <<-EOS
        file { '/etc/sudoers':
          ensure => file,
        }

        file { '/etc/fstab':
          ensure => 'link',
          target => '/etc/mtab',
        }
          EOS
        )
      end
    end
  end
end
