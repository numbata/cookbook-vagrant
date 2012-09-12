maintainer       "Andrey Subbota"
maintainer_email "subbota@gmail.com"
license          "Apache 2.0"
description      "Setup vagrant boxes"
version          "0.0.4"
name             "vagrant_boxes"

%w{ build-essential iptables }.each do |cb|
  depends cb
end

recipe "vagrant_boxes::default", "Setup vagrant boxes"
