# Ruby bindings to Saaspose REST API

This gem provides a access to the [Saaspose REST API](http://saaspose.com/docs/display/rest/Home).

## Installation

    gem install saaspose

or using bundler

    gem "saaspose"

## Configuration

    Saaspose::Configuration.configure do |config|
      config.app_sid = ENV["SAASPOSE_APPSID"]
      config.app_key = ENV["SAASPOSE_APPKEY"]
    end

## Usage

This is subject to change!

Please have a look at the specs to see how it works currently.

## License

"THE BEER-WARE LICENSE" (Revision 42):
[ps@nofail.de](mailto:ps@nofail.de) wrote this file. As long as you retain this notice you
can do whatever you want with this stuff. If we meet some day, and you think
this stuff is worth it, you can buy me a beer in return Peter Schröder
