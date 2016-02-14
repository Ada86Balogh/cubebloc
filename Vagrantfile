require 'json'

jsonPath = "./cubebloc.json"
afterScriptPath = "./after.sh"
aliasesPath = "/aliases"

require File.expand_path(File.dirname(__FILE__) + '/scripts/cubebloc.rb')

Vagrant.configure(2) do |config|
  if File.exists? aliasesPath then
      config.vm.provision "file", source: aliasesPath, destination: "~/.bash_aliases"
  end

  if File.exists? jsonPath then
    Cubebloc.configure(config, JSON.parse(File.read(jsonPath)))
  end

  if File.exists? afterScriptPath then
    config.vm.provision "shell", path: afterScriptPath
  end
end