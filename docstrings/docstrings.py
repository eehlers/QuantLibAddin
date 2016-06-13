
import os.path
import sys
import argparse
import string
import glob
import xml.sax
import xml.sax.handler
from collections import deque

d = dict()

class A(xml.sax.handler.ContentHandler):

    def __init__(self):
        xml.sax.handler.ContentHandler.__init__(self)
        self.namespace=""
        self.funcName=""
        self.parmName=""
        self.docStr=""
        self.tags = deque()  

    def startElement(self, name, attrs):
        #print "startelement - name=" + name
        #for n in attrs.getNames():
        #    print "n=" + n + " v=" + attrs.getValue(n)
        if name=="compoundname":
            self.tags.append("namespace")
        elif name=="memberdef" and attrs.has_key("kind") and attrs.getValue("kind")=="function":
            self.tags.append("function")
        elif name=="param":
            self.tags.append("param")
        elif name=="declname":
            self.tags.append("parmName")
        elif name=="name" and self.tags and self.tags[-1]=="function":
            self.tags.append("funcName")
        elif name=="briefdescription" and self.tags and (self.tags[-1]=="function" or self.tags[-1]=="param"):
            self.tags.append("docStr")

    def accumulate(self):
        if self.docStr:
            d[self.namespace + "|" + self.funcName + "|" + self.parmName] = self.docStr

    def endElement(self, name):
        if not self.tags:
            return
        if name=="compoundname":
            self.tags.pop()
        elif name=="memberdef" and self.tags[-1]=="function":
            self.tags.pop()
            self.accumulate()
            self.funcName=""
            self.docStr=""
        elif name=="param":
            self.tags.pop()
            self.accumulate()
            self.parmName=""
            self.docStr=""
        elif name=="declname":
            self.tags.pop()
        elif name=="name" and self.tags[-1]=="funcName":
            self.tags.pop()
        elif name=="briefdescription" and self.tags[-1]=="docStr":
            self.tags.pop()

    def trim(self, s):
        s = string.replace(s, "\n", "")
        s = s.strip()
        return s

    def characters(self, content):
        if not self.tags:
            return
        if self.tags[-1]=="namespace":
            self.namespace = self.namespace + content
        elif self.tags[-1]=="funcName":
            self.funcName = self.funcName + content
        elif self.tags[-1]=="parmName":
            self.parmName = self.parmName + content
        elif self.tags[-1]=="docStr":
            self.docStr = self.docStr + self.trim(content)

def parse(p):
    print p
    try:
        a = A()
        xml.sax.parse(p, a)
    except xml.sax._exceptions.SAXParseException as e:
        print e

parser = argparse.ArgumentParser(description='parse doxygen output, generate docstrings file for swig')
parser.add_argument('xml', help='directory containing doxygen xml data to be parsed')
parser.add_argument('out', help='name of docstrings output file')
args = vars(parser.parse_args())
xmlDir=args['xml']
outFile=args['out']

for p in glob.glob(xmlDir + "/namespace_*.xml"):
    parse(p)
for p in glob.glob(xmlDir + "/class_*.xml"):
    parse(p)
for p in glob.glob(xmlDir + "/struct_*.xml"):
    parse(p)

f = open(outFile, "w")

for k in sorted(d):
    f.write(k + "=" + d[k] + "\n")

