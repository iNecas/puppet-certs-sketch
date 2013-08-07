class Puppet::Provider::KatelloSslTools < Puppet::Provider

  def destroy
    files.each { |file| FileUtils.rm(file) }
  end

  def exists?
    files.all? { |file| File.exist?(file) }
  end


  def self.details(cert_name)
    { :cert_file  => full_path("#{cert_name}.crt"),
      :key_file   => full_path("#{cert_name}.key"),
      :passphrase => File.read(full_path("#{cert_name}.pwd")) }
  end

  protected

  def write(file_name, message)
    FileUtils.mkdir_p(self.class.root_path)
    File.open(full_path(file_name), "w") { |f| f << message }
  end

  def full_path(file_name)
    self.class.full_path(file_name)
  end

  def self.full_path(file_name)
    File.join(root_path, file_name)
  end

  def self.root_path
    File.expand_path("~/certs_experiment")
  end

end
