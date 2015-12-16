# figure out how big a giant array with all possible addresses would be (run with perl -n)
$total = 0;
while (<>) {
  /^(\d+)\s+(\d+)\s/;
  $total += $2-$1;
}
print "$total bytes\n";
