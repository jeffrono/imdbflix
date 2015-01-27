#!/usr/bin/perl

use LWP::UserAgent;
use LWP::Simple;
use DBD::mysql;
use Data::Dumper;
use LWP::Simple::Cookies ( autosave => 1, file => "$ENV{'HOME'}/lwp_cookies.dat" );

$dbh = dbConnect();
$|=1;

# loop through this
$seedmin = 10;
$minrating = 6.0;
$minvotes = 500;
$startyear = 2009;
$finalyear = 2012;

for ($i=$startyear; $i <= $finalyear; $i++) {
	print "getting $i...";
	$filmnum = 1;
	$imdburl = 'http://www.imdb.com/search/title?num_votes=' . $minvotes . ',&release_date=' . $i . ',' . $i . '&sort=alpha,asc&title_type=feature,documentary&user_rating=' . $minrating . ',10';	
	#http://www.imdb.com/search/title?num_votes=500,&release_date=2010,2012&title_type=feature,documentary&user_rating=6.0,10
	
	$movie_list = retrieveWebpage($imdburl);
	$movie_list =~ s/,//g;
	
	$movie_list =~ /of (\d+) titles/gi;
	$num = $1;
		
	for ($count=1; $count < $num; $count = $count+50) {
		print "\n\n [$count] of [$num]\n\n";
		$movie_list = retrieveWebpage("$imdburl&start=$count");
		$movie_list =~ s/,//g;
		$movie_list =~ s/\'/\\\'/gi;
		
		# this regex is fucked
		#while ($movie_list =~ /title=\"(\d+) Votes\">\s*(\d.\d)\s*\/10<\/div>\s*<a href=\"(.*?)\">(.*?)</gi) {
		
		while($movie_list =~ m|<a href="(/title/.{5,25}/)">|gi) {
			$id = $1;
			$url = 'http://www.imdb.com' . $id;
		
			# get user rating, plot, genre list, and poster url
			$movie_page = retrieveWebpage($url);
			
			#rating votes
			($rating, $votes) = ($movie_page =~ /Users rated this (\d+\.\d+)\/10 \((.+?) votes\)/);
			$votes =~ s/,//g;
			
			#title
			($title) = ($movie_page =~ /title>(.{4,}) \(\d\d\d\d\) - IMDb</i);
			next if (length($title) < 5);
			
			# poster url
			$posterurl = 'http://i.media-imdb.com/images/SFd0ed3aeda7d77e6d9a8404cc3cd63dc6/intl/en/title_noposter.gif';
			($posterurl) = ($movie_page =~ /src=\"([^\"]+)\" style=\"max\-width\:214/);
			
			#genre
			$genre = '';
			$movie_page =~ s/<\/a> <span>|<\/span> <a onclick=\"[^\"]+\" href=\"[^\"]+\" >/ \|\| /g;
			($genre) = ($movie_page =~ / >(\w+ \|\| .+?<)/);
			$genre =~ s/[^A-Za-z]+/, /g;
			$genre =~ s/, $//;
			next if($genre =~ m/Short/); # if short movie, skip this film

			#plot
			$plot = '';
			($plot) = ($movie_page =~ m/Storyline<\/h2> <p>([^<]+?)\s*</i);
			$plot =~ s/\'/\'\'/g;
			
			# insert film info and poster
			$statement = "INSERT IGNORE INTO movies (title, imdburl, year, votes, rating, posterurl, genre, plot) VALUES ('$title', '$url', $i, $votes, $rating, '$posterurl', '$genre', '$plot');";
			$ddb = $dbh->prepare($statement);
			$ddb->execute or print "Fail >> $statement";
			
			print "\n> $filmnum > $title";
			$filmnum++; #number of movies found for this year
			sleep 1;
		} #while loop through list of movies

	} #forloop through more than 50 movie listings
print "\n>>>>>$i<<<<<<\n$filmnum\n";

} #for loop through all years (put it all into 1 page)


####################
# retrieve webpage
#####################
sub retrieveWebpage {
	my $url =shift;
	my $ua = LWP::UserAgent->new;
	$ua->agent('Mozilla/5.0');
	$ua->timeout(100);
	$ua->env_proxy;
	$ua->requests_redirectable();
	$ua->cookie_jar( {} );
	my $response = $ua->get($url);
	$returnme = $response->content;
	$returnme =~ s/\&nbsp;/ /g;
	$returnme =~ s/\&quot;/\"/g;
	$returnme =~ s/\&rsquo;/\'/g;
	$returnme =~ s/\&gt;//g;
	$returnme =~ s/\&lt;//g;
	$returnme =~ s/\&\#\d{1,4};//g; # this shouldnt put spaces for apostraphes
	$returnme =~ s/\&\#\w{1,4};//g;
	$returnme =~ s/<.?b>/ /g;
	$returnme =~ s/\s+/ /g;
	$returnme =~ s/<\/??font[^>]*>//gi;
	$returnme =~ s/<div class=\"info-content\">//gi;
	return $returnme;
} # end sub

###########################
# set up DB
########################
sub dbConnect {
	my $dbName = "imdbflicks";
	my $hostname = "localhost";
	my $dsn = "DBI:mysql:$dbName:$hostname";
	my $user = "root";
	my $pass = "root";
	
	my $dbh = DBI->connect($dsn, $user, $pass) or print "Can’t connect to the DB: $DBI::errstr\n";
	return $dbh;
}
