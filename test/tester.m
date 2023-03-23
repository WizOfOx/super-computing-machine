import matlab.unittest.plugins.XMLPlugin

suite = testsuite("hs71");
runner = testrunner("textoutput");
xmlFile = fullfile(getenv('HOME'),'testresults.xml');
p = XMLPlugin.producingJUnitFormat(xmlFile);
runner.addPlugin(p);
results = runner.run(suite);
table(results)

dir(getenv('HOME'))