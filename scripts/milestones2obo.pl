#!/usr/bin/perl

# ----------------------------------------
# SOMEONE PLEASE REWRITE THIS!!!
# ----------------------------------------
# It would be better to go directly from TSV to RDF

while(<>) {
    chomp;
    my ($id, $team, $ms, $layer, $component, $crit, $rel_to, $depends_on, $f, $n, $o, $isr, $ag, $log, $nlp, $zz, $wf, $clin_related) = split(/\t/,$_);

    # normalize on case
    $team = lc($team);
    $layer = lc($layer);

    # escape problematic chars
    $ms =~ s@\"@@g;
    $ms =~ s@\n@ @g;

    # remove trailing ws
    $id =~ s@\s@@g;

    # the name is the first sentence of the milestone
    my $name = $ms;
    $name =~ s@\..*@@;
    $name =~ s@\r.*@@;

    # clear junk
    $ms =~ s@\r@ @g;

    # normalize
    $layer =~ tr/a-zA-Z//cd;

    # OBO writing. Each id has the prefix T
    print "[Term]\n";
    print "id: T:$id\n";
    print "name: $name\n";
    print "subset: $_\n" foreach split(/, /,$team);
    print "subset: $_\n" foreach split(/, /,$layer);
    print "def: \"$ms\" []\n";
    foreach my $x (getids($rel_to)) {
        print "relationship: related_to $x\n";
    }
    foreach my $x (getids($depends_on)) {
        print "relationship: depends_on $x\n";
    }
    foreach my $x (getids($clin_related)) {
        print "relationship: clin_related $x\n";
    }
            
    print "\n";
    
}
exit 0;

sub getids {
    my $s = shift;
    return map {s@\s@@g; "T:$_"} (split(/, /,$s));
}
