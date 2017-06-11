package MyApp::Controller;
use Mojo::Base 'Mojolicious::Controller';
use Text::MeCab;
use Data::Dumper;

sub result {
	$c = shift;
	$c->render(msg => 'controller/MyApp_Controller.pl');
}
