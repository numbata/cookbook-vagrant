Description
===========

Setup vagrant boxes on host machine

Requirements
============

Chef 0.10.10+

Platform
--------

 * Debian, Ubuntu
 * CentOS, Red Hat, Fedora

Tested on:

 * Debian 6.0

Cookbooks
---------

Requires iptables cookbook with nat support and virtualbox cookbook.

Resources and Providers
=======================

This cookbook includes a resource/provider for install virtual boxes.

  box "test-machine" do
    action :install
  end


Attributes
==========

See the `attributes/default.rb` for default values.

* `node['vagrant_boxes']['path']` - path where is Vagrant boxes is installed
* `node['vagrant_boxes']['image_url']` - URL to download default box

Usage
=====

On host node, use recipe:

    {
      "run_list": [
        "recipe[virtualbox]",
        "recipe[vagrant_boxes]"
      ]
    }

This will install virtualbox and setup vagrant boxes using `vagrant_boxes`
attributes.

    {
      "vagrant_boxes": {
        "boxes": [
          {
            "name": "gitlab",
            "forward_port": {
              "80": "4567",
              "22": "2222"
            },
            "public_ip": "192.168.13.166",
            "run_list": [
              "role[base]",
              "role[gitlab]"
            ]
          },
          {
            "name": "jenkins",
            "forward_port": {
              "22": "2223",
            },"
            "run_list": [
              "role[base]",
              "role[jenkins]"
            ]
          }
        ]
      }
    }

This will:

1. Download default vagrant box.
2. Setup two vagrant boxes: gitlab && jenkins.
3. Create iptables rules with nat for public ip for gitlab box and forwarding ports for both boxes.

License and Author
==================

- Author:: Andrey Subbota (<subbota@gmail.com>)

Copyright:: 2009-2012 Opscode, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
