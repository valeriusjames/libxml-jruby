# $Id$

# Equivalent to a header guard in C/C++
# Used to prevent the class/module from being loaded more than once
unless defined? LibXMLJRuby

module LibXMLJRuby

  # :stopdoc:
  VERSION = '1.0.0'
  LIBPATH = ::File.expand_path(::File.dirname(__FILE__)) + ::File::SEPARATOR
  PATH = ::File.dirname(LIBPATH) + ::File::SEPARATOR
  # :startdoc:

  # Returns the version string for the library.
  #
  def self.version
    VERSION
  end

  # Returns the library path for the module. If any arguments are given,
  # they will be joined to the end of the libray path using
  # <tt>File.join</tt>.
  #
  def self.libpath( *args )
    args.empty? ? LIBPATH : ::File.join(LIBPATH, *args)
  end

  # Returns the lpath for the module. If any arguments are given,
  # they will be joined to the end of the path using
  # <tt>File.join</tt>.
  #
  def self.path( *args )
    args.empty? ? PATH : ::File.join(PATH, *args)
  end

  # Utility method used to rquire all files ending in .rb that lie in the
  # directory below this file that has the same name as the filename passed
  # in. Optionally, a specific _directory_ name can be passed in such that
  # the _filename_ does not have to be equivalent to the directory.
  #
  def self.require_all_libs_relative_to( fname, dir = nil )
    dir ||= ::File.basename(fname, '.*')
    search_me = ::File.expand_path(
        ::File.join(::File.dirname(fname), dir, '**', '*.rb'))

    Dir.glob(search_me).sort.each {|rb| require rb}
  end

end  # module LibXMLJRuby

require 'java'
require 'stringio'
java_import javax.xml.parsers.DocumentBuilder
java_import javax.xml.parsers.DocumentBuilderFactory
java_import javax.xml.xpath.XPath
java_import javax.xml.xpath.XPathFactory
java_import javax.xml.xpath.XPathConstants
java_import javax.xml.namespace.NamespaceContext
java_import java.io.StringReader
java_import java.io.StringWriter
java_import javax.xml.validation.Schema
java_import javax.xml.validation.SchemaFactory
java_import java.io.ByteArrayInputStream
java_import javax.xml.transform.stream.StreamSource
java_import javax.xml.transform.stream.StreamResult
java_import javax.xml.transform.TransformerFactory
java_import javax.xml.transform.dom.DOMSource

# these use include_class to avoid conflicts with Rake's top-level
# import method, the issue doesn't seem to occur when not using a
# string.
include_class 'com.sun.org.apache.xml.internal.utils.PrefixResolver'
include_class 'com.sun.org.apache.xml.internal.utils.PrefixResolverDefault'
include_class 'org.xml.sax.InputSource'

LibXMLJRuby.require_all_libs_relative_to __FILE__
::LibXML = ::LibXMLJRuby

end  # unless defined?

# EOF
