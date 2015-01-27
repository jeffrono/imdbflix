#!/usr/bin/perl

use LWP::UserAgent;
use LWP::Simple;
use DBD::mysql;
use Data::Dumper;
use LWP::Simple::Cookies ( autosave => 1, file => "$ENV{'HOME'}/lwp_cookies.dat" );

$dbh = dbConnect();

$minrating = 7.5;
$minvotes = 5000;

#build up the html file
open(TOP, "<header.txt");
while(<TOP>) { $htmlfile .= $_; }
close(TOP);
	
open(TOP, "<year.txt");
while(<TOP>) { $htmlheaderyear .= $_; }
close(TOP);

$htmlheaderyear =~ s/$i\.html\"/$i\.html\" SELECTED/gi;
$htmlthisyear = '<table border="0" cellpadding="5" cellspacing="0">';


$statement= "SELECT * from movies where abs(year - nfyear) < 3 and streamurl <> '' and rating >= $minrating and votes > $minvotes order by year desc, round(rating,0) desc, title asc;";
$query = $dbh->prepare($statement);
$query->execute or $error = "Fail";

$filmnum = 1;
	
#loop through movies
while (my $data = $query->fetchrow_hashref()) {
	$title = $data->{'title'};
	$imdburl = $data->{'imdburl'};
	$posterurl = $data->{'nfposter'};
	$votes = $data->{'votes'};
	$rating = $data->{'rating'};
	$genre = $data->{'genre'};
	$plot = $data->{'plot'};
	$comments = $data->{'comments'};
	$tagline = $data->{'tagline'};
	$nfurl= $data->{'nfurl'};
	$streamurl = $data->{'streamurl'};
	$nfsummary = $data->{'nfsummary'};

	if($filmnum % 2 == 0) {$bgcolor = "E8EDF5"; }
	else{$bgcolor = "FFFFFF"; }

	$htmlthisyear .= '<tr bgcolor="' . $bgcolor . '"><td width="144" rowspan="2" valign="top"><img src="' . $posterurl . '" width="144" height="208"></td><td width="425" valign="top"><a href="' . $imdburl . '" class="stylemedium">' . $title . ' - (' . $rating . ' from '. $votes . ' votes)</a></td><td width="275" valign="top"><span class="stylesmall"><b>' . $genre . '</b></span></td></tr><tr><td align="left" valign="top" bgcolor="' . $bgcolor . '"><ul><a href="' . $nfurl . '"><img src = "nfadd.jpg" border=0></a><a href="' . $streamurl . '"><img src = "nfplay.jpg" border=0></a>
	<p><b>IMDB Tagline:</b> ' . $tagline . '<br><b>IMDB Comment:</b> ' . $comments . '</p>
	<td  width="275" align="left" valign="top" bgcolor="' . $bgcolor . '"><span class="stylesmall">' . $nfsummary . '<br></span></tr>';
	
	#if ($filmnum % 5 == 0) { $htmlthisyear .= insertg1(); }
	#else { $htmlthisyear .= '</tr>'; }
	
	$filmnum++; #number of movies found for this year
}
	
$htmlthisyear  .= '</table></body></html>';

#top off year with year header
$filmnum--;
$imdbsearchurl = "http://www.imdb.com/search/title?num_votes=$minvotes,&release_date=$i,$i&sort=alpha,asc&title_type=feature,documentary&user_rating=$minrating,10";
$headeryear = $htmlheaderyear;
$headeryear =~ s/YEAR/$i/;
$headeryear =~ s/MOV/$filmnum/;
$headeryear =~ s/IMDB/$imdbsearchurl/;
$headeryear =~ s/LABEL/$i/;

$htmlfile .= $headeryear;
$htmlfile .= $htmlthisyear;

open(OUT, ">topfilms.html");
print OUT $htmlfile;
close(OUT);


###########################
# set up DB
########################
sub dbConnect {
	my $dbName = "imdbflix";
	my $hostname = "localhost";
	my $dsn = "DBI:mysql:$dbName:$hostname";

	
	my $dbh = DBI->connect($dsn, $user, $pass) or print "Can’t connect to the DB: $DBI::errstr\n";
	return $dbh;
}

##################
# insert google adsense
######################

sub insertg1 {
	return '<script type="text/javascript"><!--
google_ad_client = "pub-6915771596323733";
/* imdbflix 6-8 */
google_ad_slot = "6962192026";
google_ad_width = 728;
google_ad_height = 90;
//-->
</script>
<script type="text/javascript"
src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>';

}

##################
# insert google adsense
######################

sub insertg {
	return '<script type="text/javascript"
src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>';

}
