jQuery UI Widget Library Template
====================================

This repo is a template for a jQuery UI widget library.  Clone this repo and Use it to create new jQuery UI widgets for your own projects.

Testing your widget
====================

This template uses Jasmine to specify the behaviour of your jQuery UI widget.  Jasmine is BDD for your JavaScript.  It works both in and outside the web browser, and provides a descriptive API for writing your specifications.

Running the tests in your browser
-----------------------------------

As most modern browsers prevent JavaScript running from the file-system to access other content on the file system the test specs cannot make use of jQuery XHR calls.  To resolve this, you need to run a web server serving the contents of the widget directory.

    <code>python -m SimpleHTTPServer</code>

The tests are being refactored to prevent the need for XHR which will eliminate this dependency.

Open the <code>/spec/SpecRunner.html</code> file in your web browser to run the tests using the Jasmine browser test runner.

Running the tests on the command-line
---------------------------------------

Using Jasmine and PhantomJS allows us to run our unit tests from the command-line.  You'll need phantomjs installed on your machine before you can run this:

    <code>phantomjs spec/run_jasmine.js http://localhost:8000/spec/SpecRunner.html</code>

TODO
=====

* Add support for junit compatable XML output from the command-line
* Eliminate XHR dependency on local web server to run tests
