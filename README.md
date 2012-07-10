# Ruby bindings to Saaspose REST API

This gem provides a access to the [Saaspose REST API](http://saaspose.com/docs/display/rest/Home).

## Installation

    gem install saaspose

or using bundler

    gem "saaspose"

## Configuration

    Saaspose::Configuration.configure do |config|
      config.app_sid     = ENV["SAASPOSE_APPSID"]
      config.app_key     = ENV["SAASPOSE_APPKEY"]
    end

## Usage

This is subject to change!

Please have a look at the specs to see how it works currently.
