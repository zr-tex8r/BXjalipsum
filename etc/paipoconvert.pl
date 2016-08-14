use v5.12;
use utf8;
use Encode qw(encode decode);
my $mark_par = '☃';
my $mark_cr = '☂';
my $mark_iai = "\x{B7}";
my $mark_tbl = '〠';

my @range_A1 = qw(
    。 「 」 、 ・ を ぁ ぃ ぅ ぇ ぉ ゃ ゅ ょ っ
 ー あ い う え お か き く け こ さ し す せ そ
 た ち つ て と な に ぬ ね の は ひ ふ へ ほ ま
 み む め も や ゆ よ ら り る れ ろ わ ん ゛ ゜
);

my ($rx_par, $rx_cr, $rx_iai, $rx_tbl);
my ($ssgeta, %code);

sub main {
  prepare();
  while (<>) {
    print((m/$rx_tbl/) ? dump_table() :
      (m/$rx_par/) ? convert_line($_) : ($_));
  }
}

sub dump_table {
  my $cc = 0xA1; my @ls;
  foreach (@range_A1) {
    my $s = uc(unpack('H*', encode('shiftjis', $_)));
    push(@ls, sprintf("\\do{%02X}{%s%04X}\n", $cc, $s, ord($_)));
    $cc += 1;
  }
  return @ls;
}

sub prepare {
  local $_;
  $ssgeta = encode('shiftjis', '〓');
  #
  $_ = encode('utf8', $mark_par); $rx_par = qr/^$_/;
  $_ = encode('utf8', $mark_tbl); $rx_tbl = qr/^$_/;
  $rx_cr = qr/$mark_cr/; $rx_iai = qr/$mark_iai/;
  #
  %code = ( "\n" => "\n", "\xA0" => "\xA0" );
  foreach (0x21 .. 0x7E) {
    $code{chr($_)} = chr($_);
  }
  my $cc = 0xA1;
  foreach (@range_A1) {
    $code{$_} = chr($cc); $cc += 1;
  }
}

sub convert_line {
  local ($_) = @_;
  $_ = decode('utf8', $_);
  s/^.\s*//a; s/\s*$//a; s/$rx_cr/\n/g; s/$rx_iai/\xA0/g;
  my $digest = (length($_) > 10) ? (substr($_, 0, 10) . '…') : $_;
  my $first = encode('utf8', "% " . digest($_) . "\n");
  return ($first, split_line(paipo_encode($_)));
}

sub digest {
  local ($_) = @_; s/\s//ag;
  return (length($_) > 10) ? (substr($_, 0, 10) . '…') : $_;
}

sub paipo_encode {
  my ($src) = @_; my (@cs);
  foreach my $ch (split(m//, $src)) {
    my $pc = $code{$ch}; my $uc = ord($ch);
    if (defined $pc) {
      push(@cs, $pc);
    } elsif ($uc >= 0x10000) {
      die(sprintf("Non-BMP character (U+%X) found", $uc));
    } else {
      my $ss = encode('shiftjis', $ch);
      if ($ss eq '?') { $ss = $ssgeta; }
      push(@cs, $ss, pack('n', $uc));
    }
  }
  return uc(unpack('H*', join('', @cs))) . "\n";
}

sub split_line {
  local ($_) = @_;
  my @ls = m/(.{1,72})/g;
  return map { "$_%\n" } (@ls);
}

main();
