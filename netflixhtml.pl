#!/usr/bin/perl

use LWP::UserAgent;
use LWP::Simple;
use DBD::mysql;
use Data::Dumper;
use LWP::Simple::Cookies ( autosave => 1, file => "$ENV{'HOME'}/lwp_cookies.dat" );

$dbh = dbConnect();

$minrating = 6;
$minvotes = 500;
$startyear = 1940;
$finalyear = 2010;


for ($i=$startyear; $i<$finalyear; $i++) {
	print "getting $i...";
	
	$htmlfile = '';
	$htmlheaderyear = '';
	
	#build up the html file
	open(TOP, "<header.txt");
	while(<TOP>) { $htmlfile .= $_; }
	close(TOP);
		
	open(TOP, "<year.txt");
	while(<TOP>) { $htmlheaderyear .= $_; }
	close(TOP);
	
	$htmlheaderyear =~ s/$i\.html\"/$i\.html\" SELECTED/gi;
	$htmlthisyear = '<table border="0" cellpadding="5" cellspacing="0">';
	
	
	$statement= "SELECT * from movies where abs(year - nfyear) < 5 and streamurl <> '' and year = $i order by round(rating,0) desc, title asc;";
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
	
		$htmlthisyear .= '<tr bgcolor="' . $bgcolor . '"><td width="144" rowspan="2" valign="top"><img src="' . $posterurl . '" width="144" height="208"></td><td width="425" valign="top"><a href="' . $imdburl . '" class="stylemedium">' . $title . ' - (' . $rating . ' from '. $votes . ' votes)</a></td><td width="275" valign="top"><span class="stylesmall"><b>' . $genre . '</b></span></td></tr><tr><td align="left" valign="top" bgcolor="' . $bgcolor . '"><ul><a href="' . $nfurl . '"><img src = "nfadd.jpg" border=0></a><a href="' . $streamurl . '"><img src = "nfplay.jpg" border=0></a> <p><a href="' . $nfurl . '">(netflix)</a></p><td  width="275" align="left" valign="top" bgcolor="' . $bgcolor . '"><span class="stylesmall"><b>TAG:</b> ' . $tagline . '<br><b>PLOT:</b><em> ' . $nfsummary . '</em><br><b>Comment:</b> ' . $comments . '</span></tr>';
	
		$filmnum++; #number of movies found for this year
	}
		
	$htmlthisyear  .= '</table>';
	
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
	
	print "\n>>>>>$i<<<<<<\n";
	
	open(OUT, ">$i.html");
	print OUT $htmlfile;
	close(OUT);

} #for loop through all years


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
