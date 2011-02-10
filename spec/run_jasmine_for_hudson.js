var HudsonReporter = function() {
};
HudsonReporter.prototype.parseDocument = function(document) {
  var specs, passed, failures, i, el, desc, message, stackTrace;

  specs = document.body.querySelectorAll('.spec');
  passed = document.body.querySelectorAll('.spec.passed');
  failures = document.body.querySelectorAll('.spec.failed');

  console.log('<?xml version="1.0" encoding="UTF-8" ?>');
  console.log('<testsuite errors="0" failures="' + failures.length + '" hostname="HOSTNAME" name="PACKAGENAME" tests="' + specs.length + '" time="3.0" timestamp="2010-06-30T05:16:00Z">');
  for(i = 0; i < passed.length; i++) {
    el = passed[i];
    desc = el.querySelectorAll('.description')[0].innerText;
    console.log('  <testcase name="' + desc +'"/>');
  }

  for(i = 0; i < failures.length; i++) {
    el = failures[i];
    desc = el.querySelectorAll('.description')[0].innerText;
    console.log('  <testcase name="' + desc +'"/>');

    message = el.querySelectorAll('.messages .fail')[0].innerText;
    stackTrace = "TRACE";
    console.log('    <failure message="'+ message + '">' + stackTrace + '</failure>');

    console.log('  </testcase>');
  }
  console.log('  <system-out>STDOUT</system-out>');
  console.log('  <system-err>STDERR</system-err>');
  console.log('</testsuite>');
}

if (phantom.state.length === 0) {
  if (phantom.args.length !== 1) {
    console.log('Usage: run-jasmine.js URL');
    phantom.exit();
  } else {
    phantom.state = 'run-jasmine';
    phantom.open(phantom.args[0]);
  }
} else {
  window.setInterval(function () {
    var list, el, desc, i, j, reporter;
    if (document.body.querySelector('.finished-at')) {
      reporter = new HudsonReporter()
      reporter.parseDocument(document);
      phantom.exit();
    }
  }, 100);
}
