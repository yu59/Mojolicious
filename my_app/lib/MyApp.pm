package MyApp;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;


  # Load configuration from hash returned by "my_app.conf"
  my $config = $self->plugin('Config');

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer') if $config->{perldoc};

  # Router
  my $r = $self->routes;
  $r->post('/')->to('example#index');

  # Normal route to controller
  $r->get('/')->to('example#index');
  $r->get('/result')->to('example#result');
}

1;
