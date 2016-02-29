class ScriptsController < ApplicationController

  def install
    render text:
      "sudo apt-get -y update;\n" \
      "sudo apt-get install -y git </dev/null;\n" \
      "cd /tmp;\n" \
      "git clone --depth=1 https://github.com/EnginesOS/EnginesInstaller;\n" \
      "cd EnginesInstaller;\n" \
      "sudo bash ./install_engines.sh;\n"
  end

  def uninstall
    render text:
      "cd /tmp;\n" \
      "rm -rf EnginesInstaller;\n" \
      "git clone --depth=1 https://github.com/EnginesOS/EnginesInstaller;\n" \
      "sudo sh ./EnginesInstaller/obliterate_engines_no_warning.sh;\n"
  end

end
