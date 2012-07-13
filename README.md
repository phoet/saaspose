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

Please have a look at the specs to see all the examples!

    # generate a png from a page of a remote pdf
    Saaspose::Pdf.convert("remote_pdf_file.pdf", "local_png.png", 1)
    # read the number of pages from a remote pdf
    Saaspose::Pdf.page_count"remote_pdf_file.pdf"
    # => 1

    # generate a pdf from a remote ppt
    Saaspose::Slides.convert"remote_ppt_file.ppt", "local_pdf.pdf")

    # generate a pdf from a remote doc
    Saaspose::Words.convert"remote_doc_file.doc", "local_pdf.pdf")

    # generate a pdf from a remote xls
    Saaspose::Cells.convert("remote_xls_file.xls", "local_pdf.pdf")

    # upload a file to the root dir
    Saaspose::Storage.upload("example.pdf", "")

    # get a list of files from the root dir
    files = Saaspose::Storage.files("")
    files.first
    # => <struct Saaspose::Storage::RemoteFile name="test", folder=true, modified=1969-12-31 14:00:00 +0100, size=0>

## License

"THE BEER-WARE LICENSE" (Revision 42):
[ps@nofail.de](mailto:ps@nofail.de) wrote this file. As long as you retain this notice you
can do whatever you want with this stuff. If we meet some day, and you think
this stuff is worth it, you can buy me a beer in return Peter Schröder
