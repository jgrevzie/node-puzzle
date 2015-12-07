$total = 0;
while (<>) {
  /^(\d+)\s+(\d+)\s/;
  $total += $2-$1;
}
print "$total bytes\n";
