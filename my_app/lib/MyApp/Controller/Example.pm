package MyApp::controller::example;
use Mojo::Base 'Mojolicious::Controller';
use Text::MeCab;
use Data::Dumper;

# This action will render a template
sub index {
	my $c = shift;
	# Render template "example/index.html.ep" with message
	$c->render(msg => '形態素解析');

	my $m = Text::MeCab->new();
	my $str = $c->param('word');
	my $n = $m->parse($str);
	do {
		printf("%s\t%s\t%d\n",
			$n->surface,
			$n->feature,
			$n->cost
		);
	}while($n = $n->next);

}

sub result{
	my $c = shift;
	my $m = Text::MeCab->new();
	my $str = $c->param('word');
	my $n = $m->parse($str);
	do {
		printf("%s\t%s\t%d\n",
			$n->surface,
			$n->feature,
			$n->cost
		);
	}while($n = $n->next);
	
	$c->redirect_to('/result');
} 
   
1;
