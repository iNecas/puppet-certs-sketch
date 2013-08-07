require 'fileutils'
require 'puppet/provider/katello_ssl_tools'

Puppet::Type.type(:cert).provide(:katello_ssl_tools, :parent => Puppet::Provider::KatelloSslTools) do

  def create
    # generate the selfsigne cert based on params
    write("#{resource[:name]}.crt", <<CERT)
-----BEGIN CERTIFICATE-----
Generated with passphrase #{cert_details[:passphrase]}
-----END CERTIFICATE-----
CERT
    write("#{resource[:name]}.key", "-----BEGIN PRIVATE KEY-----")
  end

  def destroy
    files.each { |file| FileUtils.rm(file) }
  end

  def exists?
    files.all? { |file| File.exist?(file) }
  end

  private

  def files
    file_names = ["#{resource[:name]}.crt",
                  "#{resource[:name]}.key"]
    file_names.map { |file_name| full_path(file_name) }
  end

  def cert_details
    @cert_details ||= Puppet::Provider::KatelloSslTools.details(@resource[:ca].to_hash[:name])
  end
end
