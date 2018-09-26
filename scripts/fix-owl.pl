#!/usr/bin/perl
while(<>) {
    s@http://purl.obolibrary.org/obo/T#_@http://transltr.io/milestones/@g;
    s@http://purl.obolibrary.org/obo/TEMP#@http://transltr.io/vocab#@;
    print $_;
}
