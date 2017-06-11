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
	my $info;
	my $sth;

	# table の group_id の最大値を調べる
	$sth = $dbh->prepare("select MAX(group_id) from result");	
	$sth->execute;
	my $href = $sth->fetchrow_hashref;
	my $num = $href;
	$num->{max}++;
	print Dumper $num->{max};	

	do {
		# 解析結果を$infoに文字列結合していく
		# sprintf 内で改行してもhtmlでは反映されない
		$surface = $n->surface;
		$surface = decode('utf8', $surface);
		$feature = $n->feature;
		$feature = decode('utf8', $feature);
		# $info .=  
		# sprintf("%s\n",
		# $feature,
		# $surface
		# );


		# 解析結果をログとして出力
		printf "%s\t%s\n", $n->surface, $n->feature;


		# database に格納
		$sth = $dbh->prepare(
		" 
			insert into result (words, result, create_timestamp, group_id)
			values(?, ?, now(), $num->{max})
		"
		);
		$sth->execute($surface, $feature);
	

	}while($n = $n->next);

	# database から全て取ってきて@resultに格納
	$sth = $dbh->prepare("select words, result, group_id from result");	
	$sth->execute;
	my @result = ();
	while ( my $href = $sth->fetchrow_hashref) {
		unshift @result, $href;
	}
	print Dumper @result;

	# my $result = \@result;
	# for (@{$result}){
	#    printf $_->{words}; 
	# };
	
	$c->stash(result => \@result);
	$c->render(msg => '形態素解析', analysis => $info); # , result => \@result
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
