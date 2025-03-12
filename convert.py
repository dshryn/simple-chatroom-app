import xml.etree.ElementTree as ET

def convert_xml_to_html(xml_file, html_file):
    tree = ET.parse(xml_file)
    root = tree.getroot()

    html_content = "<html><head><title>Test Report</title></head><body>"
    html_content += "<h1>Test Report Summary</h1>"
    
    for suite in root.findall("testsuite"):
        html_content += f"<h2>Suite: {suite.get('name')}</h2>"
        html_content += f"<p>Tests: {suite.get('tests')} | Failures: {suite.get('failures')} | Errors: {suite.get('errors')} | Skipped: {suite.get('skipped')}</p>"
        html_content += "<ul>"

        for testcase in suite.findall("testcase"):
            classname = testcase.get("classname")
            name = testcase.get("name")
            html_content += f"<li>{classname} - {name}: ✅ Passed</li>"

            failure = testcase.find("failure")
            if failure is not None:
                html_content += f"<li style='color:red;'>{classname} - {name}: ❌ Failed ({failure.get('message')})</li>"

        html_content += "</ul>"

    html_content += "</body></html>"

    with open(html_file, "w", encoding="utf-8") as f:
        f.write(html_content)

# Convert
convert_xml_to_html("test_report.xml", "test_report.html")
print("✅ Conversion complete! Check test_report.html")
