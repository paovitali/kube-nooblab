Facter.add("sysrole") do
      setcode do
        Facter::Util::Resolution.exec('/usr/bin/check_role')
      end
    end

Facter.add("sysrole") do
      setcode do
        'common'
      end
    end
