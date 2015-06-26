cat plfold_dp.ps | 
awk '
BEGIN{
    seqdef = 0
}
$0~/^\/sequence/{
    seqdef = 1
}
$0~/def$/{
    seqdef = 0
}
seqdef==1 && $0!~/^\/sequence/{
    print $0
}' | tr -d '\\' | tr -d "\n" | tr 'ACGTUacgtu' 'ACGUUACGUU' > data/sequence.txt

cat data/sequence.txt |
perl -ne 'print join("\n", split("",$_)), "\n"' | 
awk '{print "seq", i++, i, $1}' > data/circos.sequence.txt

cat data/sequence.txt |
awk '{print "chr", "-", "seq", "seq", "0", length($0), "black"}' > data/circos.karyotype.txt

cat plfold_dp.ps | \
grep -e '^[0-9\ \.]\+ubox$' |
awk '{print "seq",$1-1, $1, "seq", $2-1, $2, "pij="$3*$3}' > data/circos.bplinks.txt
