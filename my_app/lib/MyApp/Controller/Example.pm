package MyApp::Controller::Example;
use Mojo::Base 'Mojolicious::Controller';
use Text::MeCab;
use Data::Dumper;
use Encode;
use DBI;

# This action will render a template
sub index {
	my $c = shift;
	my $dbh = DBI->connect('dbi:Pg:dbname=analysis',"yu","pass");
	# Render template "example/index.html.ep" with message
	my $m = Text::MeCab->new();
	# html の text_field から値を取ってくる
	my $str = $c->param('word');
	my $n = $m->parse($str);

	my $surface;
	my $feature;
#	print Dumper $surface;
	my $info;
	my @words; 	
	my $sth;
	do {
		# 解析結果を$infoに文字列結合していく
		# sprintf 内で改行してもhtmlでは反映されない
		$surface = $n->surface;
#    	$surface = decode('utf8', $surface);
		$feature = $n->feature;
#		$feature = decode('utf8', $feature);
#		$info .=  
#		sprintf("%s\n",
#			$feature,
#			$surface
#		);


		# 解析結果をログとして出力
		printf "%s\t%s\n", $n->surface, $n->feature;

	
		# database に格納
#		sth = $dbh->prepare(
#		" 
#			insert into result (words, result, create_timestamp)
#			values(?, ?, now())
#		"
#		);
#		$sth->execute($surface, $feature);
	
		# 解析結果を@wordsに格納していく
		 push @words, $n->surface;

	}while($n = $n->next);

	print Dumper \@words;
	
	# $c->stash(words => \@words);
	$c->render(msg => '形態素解析', analysis => $info); #, words => \@words
}

sub result{
	my $c = shift;
	$c->render(msg => '形態素解析');
#	my $m = Text::MeCab->new();
#	my $str = $c->param('word');
#	my $n = $m->parse($str);
#	do {
#		printf("%s\t%s\t%d\n",
#			$n->surface,
#			$n->feature,
#			$n->cost
#		);
#	}while($n = $n->next);
#	
#	$c->redirect_to('/result');
} 
   
1;
