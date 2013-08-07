Puppet::Type.newtype(:cert) do
  desc 'ca signed cert'

  ensurable

  newparam(:name, :namevar => true)

  newparam(:ca) do
    # TODO: should be required, how to do it?
    validate do |value|
      unless value.is_a?(Puppet::Resource) && value.resource_type.name == :ca
        raise ArgumentError, "Expected Ca resource"
      end
    end
  end

  autorequire(:ca) do
    @parameters[:ca].value.to_hash[:name]
  end

end
