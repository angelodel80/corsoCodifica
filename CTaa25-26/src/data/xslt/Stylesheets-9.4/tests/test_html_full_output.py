import glob
import os
import shlex
import subprocess
import tempfile
import unittest


class HTMLFullOutputTestCase(unittest.TestCase):

    """Tests that the full HTML output for each available edition
    structure is as expected.

    The comparison between actual and expected results is a straight
    string comparison; no XML c14n is performed.

    """

    _command = 'saxon -o:{output} -s:{source} ' \
               '-xsl:{xsl} -versionmsg:off !indent=yes edn-structure={structure}'
    _structures = ('default', 'dol', 'edak', 'inslib', 'iospe', 'sample', 'sigidoc',
                   'spes')

    def setUp(self):
        base_dir = os.path.dirname(os.path.abspath(__file__))
        data_dir = os.path.join(base_dir, 'data')
        xslt_dir = os.path.dirname(base_dir)
        self._expected_dir = os.path.join(data_dir, 'expected', 'full_html')
        self._html_xslt = os.path.join(xslt_dir, 'start-edition.xsl')
        self._source_dir = os.path.join(data_dir, 'source')
        self._source_files = os.path.join(self._source_dir, '*.xml')
        self._output_dir = os.path.join(data_dir, 'actual')
        subprocess.run(['rm', '-f', os.path.join(data_dir, 'actual', '*.*')])

    def _get_contents(self, path):
        """Return the contents of `path`."""
        with open(path, 'r', encoding='utf-8') as fh:
            contents = fh.read()
        return contents
    
    def test_edition_structure_creta(self):
        """Test full HTML output with creta structure."""
        for f in os.listdir(self._source_dir):
          output = os.path.join(
              self._output_dir, '{}-{}.html'.format(os.path.splitext(
                  os.path.basename(f))[0], 'creta'))
          args = {'output': output, 'source': os.path.join(self._source_dir, f),
                  'structure': 'creta', 'xsl': self._html_xslt}
          subprocess.run(shlex.split(self._command.format(**args)),
                          check=True)
        for source in glob.glob(self._source_files):
            self._test_edition_structure(
                source, 'creta', self._output_dir)

    def test_edition_structure_default(self):
        """Test full HTML output with various edition structures."""
        for f in os.listdir(self._source_dir):
          output = os.path.join(
              self._output_dir, '{}-{}.html'.format(os.path.splitext(
                  os.path.basename(f))[0], 'default'))
          args = {'output': output, 'source': os.path.join(self._source_dir, f),
                  'structure': 'default', 'xsl': self._html_xslt}
          subprocess.run(shlex.split(self._command.format(**args)),
                          check=True)
        for source in glob.glob(self._source_files):
            self._test_edition_structure(
                source, 'default', self._output_dir)

    def test_edition_structure_ddbdp(self):
        """Test full HTML output with ddbdp structure."""
        for f in os.listdir(self._source_dir):
          output = os.path.join(
              self._output_dir, '{}-{}.html'.format(os.path.splitext(
                  os.path.basename(f))[0], 'ddbdp'))
          args = {'output': output, 'source': os.path.join(self._source_dir, f),
                  'structure': 'ddbdp', 'xsl': self._html_xslt}
          subprocess.run(shlex.split(self._command.format(**args)),
                          check=True)
        for source in glob.glob(self._source_files):
            self._test_edition_structure(
                source, 'ddbdp', self._output_dir)

    def test_edition_structure_ecg(self):
        """Test full HTML output with ecg structure."""
        for f in os.listdir(self._source_dir):
          output = os.path.join(
              self._output_dir, '{}-{}.html'.format(os.path.splitext(
                  os.path.basename(f))[0], 'ecg'))
          args = {'output': output, 'source': os.path.join(self._source_dir, f),
                  'structure': 'ecg', 'xsl': self._html_xslt}
          subprocess.run(shlex.split(self._command.format(**args)),
                          check=True)
        for source in glob.glob(self._source_files):
            self._test_edition_structure(
                source, 'ecg', self._output_dir)

    def test_edition_structure_edak(self):
        """Test full HTML output with edak structure."""
        for f in os.listdir(self._source_dir):
          output = os.path.join(
              self._output_dir, '{}-{}.html'.format(os.path.splitext(
                  os.path.basename(f))[0], 'edak'))
          args = {'output': output, 'source': os.path.join(self._source_dir, f),
                  'structure': 'edak', 'xsl': self._html_xslt}
          subprocess.run(shlex.split(self._command.format(**args)),
                          check=True)
        for source in glob.glob(self._source_files):
            self._test_edition_structure(
                source, 'edak', self._output_dir)

    def test_edition_structure_inslib(self):
        """Test full HTML output with inslib structure."""
        for f in os.listdir(self._source_dir):
          output = os.path.join(
              self._output_dir, '{}-{}.html'.format(os.path.splitext(
                  os.path.basename(f))[0], 'inslib'))
          args = {'output': output, 'source': os.path.join(self._source_dir, f),
                  'structure': 'inslib', 'xsl': self._html_xslt}
          subprocess.run(shlex.split(self._command.format(**args)),
                          check=True)
        for source in glob.glob(self._source_files):
            self._test_edition_structure(
                source, 'inslib', self._output_dir)

    def test_edition_structure_iospe(self):
        """Test full HTML output with iospe structure."""
        for f in os.listdir(self._source_dir):
          output = os.path.join(
              self._output_dir, '{}-{}.html'.format(os.path.splitext(
                  os.path.basename(f))[0], 'iospe'))
          args = {'output': output, 'source': os.path.join(self._source_dir, f),
                  'structure': 'iospe', 'xsl': self._html_xslt}
          subprocess.run(shlex.split(self._command.format(**args)),
                          check=True)
        for source in glob.glob(self._source_files):
            self._test_edition_structure(
                source, 'iospe', self._output_dir)

    def test_edition_structure_london(self):
        """Test full HTML output with london structure."""
        for f in os.listdir(self._source_dir):
          output = os.path.join(
              self._output_dir, '{}-{}.html'.format(os.path.splitext(
                  os.path.basename(f))[0], 'london'))
          args = {'output': output, 'source': os.path.join(self._source_dir, f),
                  'structure': 'london', 'xsl': self._html_xslt}
          subprocess.run(shlex.split(self._command.format(**args)),
                          check=True)
        for source in glob.glob(self._source_files):
            self._test_edition_structure(
                source, 'london', self._output_dir)

    def test_edition_structure_sample(self):
        """Test full HTML output with sample edition structure."""
        for f in os.listdir(self._source_dir):
          output = os.path.join(
              self._output_dir, '{}-{}.html'.format(os.path.splitext(
                  os.path.basename(f))[0], 'sample'))
          args = {'output': output, 'source': os.path.join(self._source_dir, f),
                  'structure': 'sample', 'xsl': self._html_xslt}
          subprocess.run(shlex.split(self._command.format(**args)),
                          check=True)
        for source in glob.glob(self._source_files):
            self._test_edition_structure(
                source, 'sample', self._output_dir)

    def test_edition_structure_sigidoc(self):
        """Test full HTML output with sigidoc structure."""
        for f in os.listdir(self._source_dir):
          output = os.path.join(
              self._output_dir, '{}-{}.html'.format(os.path.splitext(
                  os.path.basename(f))[0], 'sigidoc'))
          args = {'output': output, 'source': os.path.join(self._source_dir, f),
                  'structure': 'sigidoc', 'xsl': self._html_xslt}
          subprocess.run(shlex.split(self._command.format(**args)),
                          check=True)
        for source in glob.glob(self._source_files):
            self._test_edition_structure(
                source, 'sigidoc', self._output_dir)

    def test_edition_structure_spes(self):
        """Test full HTML output with spes structure."""
        for f in os.listdir(self._source_dir):
          output = os.path.join(
              self._output_dir, '{}-{}.html'.format(os.path.splitext(
                  os.path.basename(f))[0], 'spes'))
          args = {'output': output, 'source': os.path.join(self._source_dir, f),
                  'structure': 'spes', 'xsl': self._html_xslt}
          subprocess.run(shlex.split(self._command.format(**args)),
                          check=True)
        for source in glob.glob(self._source_files):
            self._test_edition_structure(
                source, 'spes', self._output_dir)

    def _test_edition_structure(self, source, structure, actual_dir):
        with self.subTest(source=source, structure=structure):
            base_filename = os.path.basename(source)
            actual_path = os.path.join(
                actual_dir, '{}-{}.html'.format(os.path.splitext(
                    base_filename)[0], structure))
            expected_path = os.path.join(
                self._expected_dir, '{}-{}.html'.format(os.path.splitext(
                    base_filename)[0], structure))
            result = subprocess.run(['diff', actual_path, expected_path], capture_output=True)
            self.assertEqual(0, result.returncode)


if __name__ == '__main__':
    unittest.main()
