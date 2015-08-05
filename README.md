# foreman_noenv

The ```foreman_noenv``` plugin introduces a new host-level option called 'Agent Specified Environment.'  By default, if the global ```enc_environment``` Foreman setting is set to ```true```, Foreman will explicitly set the puppet environment in the ENC YAML output.  This overrides any local environment setting on the host it's self.  This plugin allows you to disable this functionality and prevent Foreman from specifying the environment in the ENC output on an individual host basis without globally setting ```enc_environment`` to ``false```.

## Why?

If your Puppet workflow includes dynamic feature based environments (R10k), it's useful to be able to run ```puppet agent -t --environment=featureX``` on a host to test new Puppet code on individual hosts.  With ```enc_environment``` set to ```true```, this is impossible.  One alternative would be to import the new environment(s) into Foreman, and then manually assign the test environment to the host using Foreman, but this is a long process.

Another alternative would be to set ```enc_environment``` to ```false```, but this would stop Foreman from enforcing the environment globally.  Many organizations prefer to have Foreman be authoritative for environment information, so this is not always a good option.

This plugin will allow you to disable this functionality on a per-host basis in Foreman offering greater flexibility and security and allowing the user to run ```puppet agent -t --environment=featureX``` on specific hosts.

## Installation

Please see the Foreman manual for installation instructions:

* [Foreman:  Plugin Manual:] (http://theforeman.org/plugins/)

## Configuration

After installing, to enable the plugin, set ```:noenv_enable: true``` in Foreman's ```settings.yml```.

## Usage

After instalilng and enabling the plugin, a new option named 'Agent Specified Environment' will appear under the 'Additional Information' tab of the host's properties.  Check or uncheck this box based on the desired behavior.

## Contributing

Fork and send a Pull Request. Thanks!

## Contributors

Thank you to the following people who helped immemseley with the creation of this plugin:

* Stephen Benjamin
* Dominic Cleal
* Ohad Levy

## Copyright

Copyright (c) 2015 Josh Baird

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

