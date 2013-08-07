require 'fileutils'
require 'puppet/provider/katello_ssl_tools'

Puppet::Type.type(:ca).provide(:katello_ssl_tools, :parent => Puppet::Provider::KatelloSslTools) do

  def create
    @passphrase = "very secret passphrase"
    # generate the selfsigne cert based on params
    write("#{resource[:name]}.crt", "-----BEGIN CERTIFICATE-----")
    write("#{resource[:name]}.key", "-----BEGIN PRIVATE KEY-----")
    write("#{resource[:name]}.pwd", @passphrase)
  end

  private

  def files
    file_names = ["#{resource[:name]}.crt",
                  "#{resource[:name]}.key",
                  "#{resource[:name]}.pwd"]
    file_names.map { |file_name| full_path(file_name) }
  end
end
