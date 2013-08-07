Puppet::Type.newtype(:ca) do
  desc 'Ca for generating signed certs'

  ensurable

  newparam(:name, :namevar => true)

  newproperty(:common_name)

  newproperty(:country)

  newproperty(:state)

  newproperty(:city)

  newproperty(:org)

  newproperty(:org_unit)

end
