$:.unshift(Dir.pwd + "/lib")
require 'rubygems'
require 'hpricot'
require 'xml'
require 'rexml/document'

ITERATIONS = 10
NESTED_ITERATIONS = 5

def bm(name, filename, &block)
  text = File.open(filename).read
  length = text.length / 1024.0 / 1024.0
  puts "#{filename}: #{name} (#{(length * 1024).round} kb)"
  for j in 0 .. NESTED_ITERATIONS
    s = Time.now.to_f
    for i in 0 .. ITERATIONS
      block.call(text)
    end
    timer = Time.now.to_f - s
    puts "\t#{length * ITERATIONS / timer} MB/s"
  end
end

def bm_suite(filenames)
  filenames.each do |filename|    
    bm("LIBXML THROUGHPUT:", filename) do |text|
      XML::Parser.string(text).parse
    end
    
    bm("HPRICOT THROUGHPUT:", filename) do |text|
      Hpricot.XML(text)
    end
    
    bm("REXML THROUGHPUT:", filename) do |text|
      REXML::Document.new(text)
    end
  end
end

bm_suite("script/benchmark/hamlet.xml")