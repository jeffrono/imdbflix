<?

$minrating = 7.5;
$minvotes = 5000;

mysql_connect(localhost,$username,$password);
@mysql_select_db($database) or die( "Unable to select database");
$query="SELECT * from movies where abs(year - nfyear) < 3 and streamurl <> '' and rating >= $minrating and votes > $minvotes order by year desc, round(rating,0) desc, title asc;";
$result=mysql_query($query);
$num=mysql_numrows($result);
mysql_close();
$i=0;

$imdbsearchurl = "http://www.imdb.com/search/title?num_votes=$minvotes,&sort=alpha,asc&title_type=feature,documentary&user_rating=$minrating,10";

?>

<html>
<head>
<title>IMDBFlicks.com</title>

<style type="text/css">
.stylegreen {	color: #009900;
	font-weight: bold;
}
.styleyr {
	text-align: center;
	font-weight: bold;
	font-size: xx-large;
}

.stylered {	color: #FF0000;
	font-weight: bold;
}
.stylebig {
	font-size: x-large;
	font-weight: bold;
}
.stylemedium {
	font-size: medium;
	font-weight: bold;
}
.stylesmall {font-size: small}
-->
</style>

<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-16795005-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>

</head>

<body>
<script type="text/javascript"><!--
google_ad_client = "pub-6915771596323733";
/* imdbflix 6-8 */
google_ad_slot = "6962192026";
google_ad_width = 728;
google_ad_height = 90;
//-->
</script>
<script type="text/javascript"
src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script><br><br>

<span class="stylebig"><b><a href="http://www.imdbflicks.com">IMDBFlicks.com</a></b>
	<br>A <font color="blue"><b>mashup</b></font> <br>
	of <font color="green"><b>top-rated IMDB movies</b></font> <br>
	with <font color="red"><b>Netflix</b></font><br>
</span><p>
<span class="stylemedium">IMDBFlicks.com shows you the Netflix streaming library filtered through the top IMDB movies by year.</span>
<p>
<ul><li>Netflix has a lot of streaming movies, but they're hard to browse.
<li>I generally don't care for Netflix "recommended" movies.
<li>IMDB's ratings are great.
<li>Linked directly to the IMDB profile page.  Netflix summary and nice large posters.  Only streaming movies are listed so you can watch NOW!
</ul>
Brought to you by Jeff Novich, creator of <a href="http://www.vocabsushi.com">VocabSushi.com</a> and <a href="http://www.faresharenyc.com">FareshareNYC.com</a>.  Please send feedback <a href="mailto:imdbflix@gmail.com">here</a>.

<br><br>

<table border="1" cellpadding="5" cellspacing="0">
<tr bgcolor="E8EDF5">
<td width="144">

<FORM ACTION="">
<select name="jumpto" onChange='window.location.href= this.form.jumpto.options[this.form.jumpto.selectedIndex].value'>
				      <option value="topflix.php" SELECTED>Top Flix</option>
				      <option value="2009.html">2009</option>
	      			<option value="2008.html">2008</option>
              <option value="2007.html">2007</option>
              <option value="2006.html">2006</option>
              <option value="2005.html">2005</option>
              <option value="2004.html">2004</option>
              <option value="2003.html">2003</option>
              <option value="2002.html">2002</option>
              <option value="2001.html">2001</option>
              <option value="2000.html">2000</option>
              <option value="1999.html">1999</option>
              <option value="1998.html">1998</option>
              <option value="1997.html">1997</option>
              <option value="1996.html">1996</option>
              <option value="1995.html">1995</option>
              <option value="1994.html">1994</option>
              <option value="1993.html">1993</option>
              <option value="1992.html">1992</option>
              <option value="1991.html">1991</option>
              <option value="1990.html">1990</option>
              <option value="1989.html">1989</option>
              <option value="1988.html">1988</option>
              <option value="1987.html">1987</option>
              <option value="1986.html">1986</option>
              <option value="1985.html">1985</option>
              <option value="1984.html">1984</option>
              <option value="1983.html">1983</option>
              <option value="1982.html">1982</option>
              <option value="1981.html">1981</option>
              <option value="1980.html">1980</option>
              <option value="1979.html">1979</option>
              <option value="1978.html">1978</option>
              <option value="1977.html">1977</option>
              <option value="1976.html">1976</option>
              <option value="1975.html">1975</option>
              <option value="1974.html">1974</option>
              <option value="1973.html">1973</option>
              <option value="1972.html">1972</option>
              <option value="1971.html">1971</option>
              <option value="1970.html">1970</option>
              <option value="1969.html">1969</option>
              <option value="1968.html">1968</option>
              <option value="1967.html">1967</option>
              <option value="1966.html">1966</option>
              <option value="1965.html">1965</option>
              <option value="1964.html">1964</option>
              <option value="1963.html">1963</option>
              <option value="1962.html">1962</option>
              <option value="1961.html">1961</option>
              <option value="1960.html">1960</option>
              <option value="1959.html">1959</option>
              <option value="1958.html">1958</option>
              <option value="1957.html">1957</option>
              <option value="1956.html">1956</option>
              <option value="1955.html">1955</option>
              <option value="1954.html">1954</option>
              <option value="1953.html">1953</option>
              <option value="1952.html">1952</option>
              <option value="1951.html">1951</option>
              <option value="1950.html">1950</option>
              <option value="1949.html">1949</option>
              <option value="1948.html">1948</option>
              <option value="1947.html">1947</option>
              <option value="1946.html">1946</option>
              <option value="1945.html">1945</option>
              <option value="1944.html">1944</option>
              <option value="1943.html">1943</option>
              <option value="1942.html">1942</option>
              <option value="1941.html">1941</option>
              <option value="1940.html">1940</option>
        </select>
        </FORM>
</span>
</td>

<td width="425" valign="top">
<span class="styleyr"><a href="<? echo $imdbsearchurl; ?>">Top Flix</a></span>
</td>
<td width="275" valign="top">
<a name="Top Flix"><span class="stylemedium"><? echo $num; ?> movies</span><br></a>
</span>
</td></tr>
</table>

<br><br>

<script type="text/javascript"><!--
google_ad_client = "pub-6915771596323733";
/* imdbflix 6-8 */
google_ad_slot = "6962192026";
google_ad_width = 728;
google_ad_height = 90;
//-->
</script>
<script type="text/javascript"
src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>
<br><br>

<table border="0" cellpadding="5" cellspacing="0">

<?
while ($i < $num) {

$year=mysql_result($result,$i,"year");
$title=mysql_result($result,$i,"title");
$imdburl=mysql_result($result,$i,"imdburl");
$posterurl=mysql_result($result,$i,"nfposter");
$votes=mysql_result($result,$i,"votes");
$rating=mysql_result($result,$i,"rating");
$genre=mysql_result($result,$i,"genre");
$plot=mysql_result($result,$i,"plot");
$comments=mysql_result($result,$i,"comments");
$tagline=mysql_result($result,$i,"tagline");
$nfurl=mysql_result($result,$i,"nfurl");
$streamurl=mysql_result($result,$i,"streamurl");
$nfsummary=mysql_result($result,$i,"nfsummary");

if($i % 2 == 0) {$bgcolor = "E8EDF5"; }
else{$bgcolor = "FFFFFF"; }

echo '<tr bgcolor="' . $bgcolor . '" style="WORD-BREAK:BREAK-ALL"><td width="144" rowspan="2" valign="top"><img src="' . $posterurl . '" width="144" height="208"></td><td width="425" valign="top"><a href="' . $imdburl . '" class="stylemedium">' . $title . ' - (' . $rating . ' from '. $votes . ' votes)</a><br>' . $year . '</td><td width="275" valign="top"><span class="stylesmall"><b>' . $genre . '</b></span></td></tr><tr><td align="left" valign="top" bgcolor="' . $bgcolor . '"><ul><a href="' . $nfurl . '"><img src = "nfadd.jpg" border=0></a><a href="' . $streamurl . '"><img src = "nfplay.jpg" border=0></a>
	<p><b>IMDB Tagline:</b> ' . $tagline . '<br><b>IMDB Comment:</b> ' . $comments . '</p>
	<td  width="275" align="left" valign="top" bgcolor="' . $bgcolor . '"><span class="stylesmall">' . $nfsummary . '<br></span></tr>';



$i++;
} #while loop

?>

</table></body></html>